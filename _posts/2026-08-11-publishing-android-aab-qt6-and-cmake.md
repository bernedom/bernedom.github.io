--- 
layout: post
title: "From Conan to Play Store: Building a Multi-ABI Qt6 Android App Bundle with CMake"
description: "How QRLite uses Conan as a CMake dependency provider and a three-way Qt6 cross-build to produce a single Android App Bundle from one CMake project."
image: /images/agentic-coding-brute-force/thumbnail.jpg
hero_image: /images/agentic-coding-brute-force/hero.jpg
hero_darken: true
tags: android qt6 cmake
lang: en
author: Dominik Berner
---

# From Conan to Play Store: Building a Multi-ABI Qt6 Android App Bundle with CMake

At Software Craft we build and ship C++ across a lot of targets, and Android is
usually the one that surprises people most. Not because Android itself is
exotic, but because "compile a C++ project" quietly turns into "cross-compile
it three times, for three different ABIs, wire in a dependency manager that
also has to cross-compile, and hand the result to a Java-flavoured packaging
toolchain that expects a single Gradle-shaped project." None of the individual
steps are hard. Getting all of them to agree with each other is where the
time goes.

This post walks through how we do that for [QRLite](https://github.com/bernedom/QRLite),
one of our C++/Qt6 Android apps, using **CMake presets**, **Conan 2** as a
CMake dependency provider, and Qt6's own `qt-cmake` tooling to go from source
to a single installable `.aab` (Android App Bundle) covering
`armeabi-v7a`, `arm64-v8a`, and `x86_64`. QRLite is small on purpose — a
local-only photo-collage app with no backend — which makes it a clean example
of the build plumbing without the app logic getting in the way.

If you haven't set up a Qt/CMake Android build before, read
[cmake-android-apk-and-qt](https://softwarecraft.ch/cmake-android-apk-and-qt)
first. That post covers NDK/SDK installation, environment variables, basic
`CMakePresets.json` anatomy, and `adb install` — all still valid, and we
won't repeat it here. It targets Qt5 with no dependency manager at all; this
post picks up from there and adds **Conan 2 + Qt6**, then goes all the way to
a signed-ready multi-ABI bundle. Signing the bundle and wiring it into a
Play Store release pipeline is its own topic and gets a follow-up post — here
we stop once we have a valid, installable `.aab`.

## The dependency problem: Conan as a CMake dependency provider

QRLite depends on [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp) for QR
decoding and [Catch2](https://github.com/catchorg/Catch2) for its test suite.
On desktop Linux you could reasonably reach for system packages or
`FetchContent`. Cross-compiled for three Android ABIs, that stops being
reasonable — you'd need three copies of every dependency, built with the
right NDK toolchain, and some way of keeping `find_package()` pointed at the
right one depending on which ABI CMake is currently configuring.

Conan solves the "build the right binary for the right ABI" half of that
problem. CMake's **dependency provider** mechanism is what lets Conan do it
*transparently*, from inside `find_package()`, instead of requiring every
consumer of the project to run a separate `conan install` step by hand and
remember to keep it in sync with the CMake configure. Since CMake 3.24,
setting

```cmake
set(CMAKE_PROJECT_TOP_LEVEL_INCLUDES "path/to/conan_provider.cmake")
```

before the first `project()` call registers a script that CMake consults
whenever `find_package()` can't resolve a package the normal way. The script
is [`cmake-conan`](https://github.com/conan-io/cmake-conan), which QRLite
vendors as a git submodule at `cmake-conan/`. In `CMakePresets.json` this
becomes a small hidden preset that every other configuration inherits from:

```json
{
    "name": "conan-dependency-provider",
    "hidden": true,
    "cacheVariables": {
        "CMAKE_PROJECT_TOP_LEVEL_INCLUDES": "${sourceDir}/cmake-conan/conan_provider.cmake"
    }
}
```

With that in place, the provider intercepts `find_package(ZXing REQUIRED)`
and `find_package(Catch2)` and Conan runs automatically: it reads
`conanfile.txt`, resolves and (if needed) builds the dependency graph for the
active profile, and generates the `CMakeDeps` config files that
`find_package()` then picks up as if they'd always been there. QRLite's
`conanfile.txt` is intentionally minimal:

```ini
[requires]
catch2/3.10.0
zxing-cpp/2.3.0

[generators]
CMakeDeps
```

`CMakeDeps` is the generator that matters here — it's what produces the
`Find<Package>.cmake`/`<package>-config.cmake` files that make Conan-provided
dependencies look like any other CMake package to `find_package()`.

### Host and build profiles

Once you're cross-compiling, "what compiler and settings should this
dependency be built with" stops having one answer — Conan needs to know about
*two* toolchains at once:

- the **build profile**: the machine actually running the compiler (your
  desktop/CI container, x86_64 Linux, system GCC/Clang)
- the **host profile**: the machine the binary will *run on* (an Android
  device — a given ABI, the NDK's Clang, `libc++`, a minimum API level)

For a desktop build these happen to be the same, so Conan defaults quietly
work. For Android they diverge on almost every axis: `arch`, `os`,
`compiler`, `compiler.libcxx`, even `compiler.version` (the NDK ships its own
Clang, not whatever `clang` your Ubuntu container has on `PATH`). QRLite's
devcontainer and CI image (`bernedom/qtandroidbuilder`) ship pre-built Conan
profiles for exactly this split — one host profile per Android ABI/build type
(`android-debug`, `android-release`) and a build profile for the container
itself (`android`). A host profile looks roughly like:

```ini
[settings]
arch=armv8
os=Android
os.api_level=31
compiler=clang
compiler.version=18
compiler.libcxx=c++_shared
compiler.cppstd=gnu17
build_type=Release

[conf]
tools.android:ndk_path=$ANDROID_NDK_HOME
```

with a separate one per ABI (`armv7`, `armv8`, `x86_64` map to
`armeabi-v7a`/`arm64-v8a`/`x86_64`). The desktop build profile is the
"normal" one — plain `os=Linux`, system GCC. CMakePresets.json wires the pair
in as cache variables that `cmake-conan` reads directly:

```json
{
    "name": "conan-android-debug",
    "hidden": true,
    "cacheVariables": {
        "CONAN_HOST_PROFILE": "android-debug",
        "CONAN_BUILD_PROFILE": "android"
    }
}
```

## Making `find_package` work for Conan + Qt6 while cross-compiling

Getting Conan to *produce* the right binaries is half the battle; getting
CMake's `find_package()` to actually *find* them while an Android toolchain
file is active is the other half. The NDK's CMake toolchain file is
deliberately strict about this — by default it sets
`CMAKE_FIND_ROOT_PATH_MODE_PACKAGE`/`LIBRARY`/`INCLUDE` to `ONLY`, meaning
`find_package()` will only look inside `CMAKE_FIND_ROOT_PATH` (the sysroot).
That's correct behaviour for system libraries — you don't want a x86_64 host
`.so` linked into an ARM binary by accident — but it also means CMake will
silently refuse to see Conan's host-profile packages, which live outside the
NDK sysroot entirely. QRLite's `android-ndk` hidden preset relaxes exactly
this:

```json
"cacheVariables": {
    "ANDROID_PLATFORM": "31",
    "ANDROID_SDK_ROOT": "/opt/android",
    "CMAKE_FIND_ROOT_PATH_MODE_PACKAGE": "BOTH",
    "CMAKE_FIND_ROOT_PATH_MODE_LIBRARY": "BOTH",
    "CMAKE_FIND_ROOT_PATH_MODE_INCLUDE": "BOTH"
}
```

`BOTH` tells CMake to search the sysroot *and* the ordinary
`CMAKE_PREFIX_PATH`/`CMAKE_MODULE_PATH` — which is where both Conan's
generated package files and Qt6's Android package live.

Qt6 itself adds a second wrinkle: unlike Qt5's single `CMAKE_PREFIX_PATH`
from the prior article, Qt6 for Android ships **one full install per ABI**
(`android_armv7/`, `android_arm64_v8a/`, `android_x86_64/`), each exposed
through a `QT_PATH_ANDROID_ABI_<abi>` variable when you're building for
multiple ABIs at once. QRLite's top-level `CMakeLists.txt` combines both
needs — Conan's per-ABI output directory and Qt6's per-ABI install — into one
manual prefix-path prepend, keyed on `CMAKE_ANDROID_ARCH_ABI`:

```cmake
if(ANDROID)
  set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)

  if(CMAKE_ANDROID_ARCH_ABI STREQUAL "armeabi-v7a")
    list(PREPEND CMAKE_PREFIX_PATH "${QT_PATH_ANDROID_ABI_armeabi-v7a}")
    list(PREPEND CMAKE_PREFIX_PATH "${CONAN_ARMEABI_V7A_DIR}")
    list(PREPEND CMAKE_MODULE_PATH "${CONAN_ARMEABI_V7A_DIR}/cmake")
  elseif(CMAKE_ANDROID_ARCH_ABI STREQUAL "arm64-v8a")
    list(PREPEND CMAKE_PREFIX_PATH "${QT_PATH_ANDROID_ABI_arm64-v8a}")
    list(PREPEND CMAKE_PREFIX_PATH "${CONAN_ARM64_DIR}")
    list(PREPEND CMAKE_MODULE_PATH "${CONAN_ARM64_DIR}/cmake")
  elseif(CMAKE_ANDROID_ARCH_ABI STREQUAL "x86_64")
    list(PREPEND CMAKE_PREFIX_PATH "${QT_PATH_ANDROID_ABI_x86_64}")
    list(PREPEND CMAKE_PREFIX_PATH "${CONAN_X86_64_DIR}")
    list(PREPEND CMAKE_MODULE_PATH "${CONAN_X86_64_DIR}/cmake")
  endif()
endif()

find_package(Qt6 COMPONENTS Core Gui Multimedia Qml Quick REQUIRED)
find_package(ZXing REQUIRED)
```

The comment sitting above this block in the real file reads
`# This is a hack to make multi-ABI builds work with Conan and Qt` — which is
an honest description. It exists because a single CMake *configure* only
ever targets one ABI (more on why below), but the *bundle* build re-invokes
CMake three times against the same source tree from a fourth, top-level
configure, and that fourth configure needs to know where each of the three
per-ABI Conan installs ended up. `CONAN_ARM64_DIR` and friends are just plain
cache variables, set to a sensible default here and overridden explicitly by
the bundle preset later.

## What the preset stack adds on top of a familiar chain

If you've read the prior post, most of `CMakePresets.json`'s shape will look
familiar: a `ci-ninja` base preset, `Debug`/`Release` variants, per-ABI
`android-*` presets carrying `ANDROID_ABI`. What's new here is Conan and
Qt6's cross-build story layered on top:

- **`conan-dependency-provider`** — the hidden preset from above, inherited
  by every configuration (desktop and Android alike) so Conan is always in
  the loop.
- **`conan-android-debug`/`conan-android-release`** — pick the matching
  Conan host/build profile pair per build type.
- **`QT_HOST_PATH`** — set as an *environment* variable (not a cache
  variable) on every Android preset, pointing at the desktop Qt install.
  Cross-compiled Qt for Android doesn't ship its own copy of tools like
  `androiddeployqt`, `qmlcachegen`, or `qt-cmake` itself — those need to
  *run* on the build machine, so Qt6's build system needs a host Qt to borrow
  them from even while linking against the Android one.

A single-ABI debug build looks exactly like the delta these two additions
suggest — same shape as the prior post, with Conan and a host Qt path now in
the mix:

```bash
cmake --preset ci-ninja-android-arm64-v8a-debug
cmake --build build_android_arm64-v8a --target apk
```

That produces `build_android_arm64-v8a/QRLiteApp/android-build/QRLite.apk` —
one ABI, installable directly with `adb install`, exactly as in the prior
post (see that article for the emulator/`adb` details, which don't change
here).

## From one APK to one bundle: why three ABIs means three builds

A `.apk` you `adb install` yourself can happily target one ABI. What the Play
Store wants is different: a single `.aab` that contains the app's shared
libraries for *every* ABI you support, with Google Play generating
per-device APKs from it at install time. That immediately raises the
question a lot of people trip over the first time they touch Qt-for-Android:
if the bundle needs three ABIs' worth of native code, why not just configure
CMake once with all three?

Because you can't. A CMake *configure* binds to exactly one toolchain, and
the Android NDK toolchain file is ABI-specific — `ANDROID_ABI` is a
configure-time setting, not something you can flip per-target within a
single build tree. There is no such thing as a single CMake configure that
produces `armeabi-v7a`, `arm64-v8a`, and `x86_64` object code
simultaneously. So the only way to get three ABIs' worth of native libraries
is to run three independent configure+build cycles — which is exactly what
QRLite's per-ABI presets (`android-armeabi-v7a`, `android-arm64-v8a`,
`android-x86_64`) are for, each with its own `binaryDir`:

```bash
cmake --preset ci-ninja-android-armeabi-v7a-debug
cmake --preset ci-ninja-android-arm64-v8a-debug
cmake --preset ci-ninja-android-x86_64-debug

cmake --build build_android_armeabi-v7a
cmake --build build_android_arm64-v8a
cmake --build build_android_x86_64
```

At this point you have three separate `build_android_<abi>/` trees, each
with its own `.so`, and each with its own Conan install directory
(`build_android_<abi>/conan/`) built against that ABI's host profile. Three
APKs' worth of native code — but Play Store bundles aren't "three APKs
concatenated," they're one Gradle-shaped Android project with all three
`.so` sets dropped into the right per-ABI `jniLibs` folders. Producing that
is a fourth, different kind of build.

## Tying it together: the bundle build

Qt6 has first-class support for this shape of build, but it's driven through
`qt-cmake` — Qt's own CMake wrapper — rather than plain `cmake`, and it needs
to know where all three of the per-ABI pieces (Qt installs *and* Conan
installs) actually live, since this configure isn't cross-compiling anything
itself; it's orchestrating the three that already ran. That's the
`android-all-archs` preset:

```json
{
    "name": "android-all-archs",
    "hidden": true,
    "inherits": ["android-ndk"],
    "cacheVariables": {
        "QT_ANDROID_ABIS": "x86_64;arm64-v8a;armeabi-v7a",
        "QT_ANDROID_BUILD_ALL_ABIS": "OFF"
    },
    "binaryDir": "build_android_bundle"
},
{
    "name": "Qt-android-all-archs",
    "hidden": true,
    "cacheVariables": {
        "QT_CHAINLOAD_TOOLCHAIN_FILE": "$env{ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake",
        "CONAN_ARM64_DIR": "${sourceDir}/build_android_arm64-v8a/conan",
        "CONAN_ARMEABI_V7A_DIR": "${sourceDir}/build_android_armeabi-v7a/conan",
        "CONAN_X86_64_DIR": "${sourceDir}/build_android_x86_64/conan",
        "QT_PATH_ANDROID_ABI_armeabi-v7a": "/opt/Qt/6.11.1/android_armv7/",
        "QT_PATH_ANDROID_ABI_arm64-v8a": "/opt/Qt/6.11.1/android_arm64_v8a/",
        "QT_PATH_ANDROID_ABI_x86_64": "/opt/Qt/6.11.1/android_x86_64/",
        "QT_HOST_PATH": "/opt/Qt/6.11.1/gcc_64/"
    },
    "environment": {
        "QT_HOST_PATH": "/opt/Qt/6.11.1/gcc_64/"
    }
}
```

This is the missing piece from the "hack" in the top-level `CMakeLists.txt`
earlier: `CONAN_ARM64_DIR`, `CONAN_ARMEABI_V7A_DIR`, and `CONAN_X86_64_DIR`
are set here explicitly, pointing back at the three builds that already ran.
`QT_ANDROID_BUILD_ALL_ABIS=OFF` combined with an explicit `QT_ANDROID_ABIS`
list tells Qt6 "don't try to build these yourself — I've already built them,
just assemble the bundle from what's on disk." Two details matter for
actually running this configure step:

- It has to be invoked with **`qt-cmake` from one of the Android Qt
  installs**, not plain `cmake` — `qt-cmake` is what wires in Qt6's Android
  packaging machinery (the `aab` target itself doesn't exist otherwise).
- `QT_ANDROID_MULTI_ABI_FORWARD_VARS` needs to include `ANDROID_PLATFORM` so
  the per-ABI Android platform level set in the `android-ndk` preset actually
  propagates into the bundle project — it's easy to lose quietly otherwise.

Put together, the full sequence — three cross-builds, then one bundle
assembly — is what QRLite's `build-android-bundle.sh` runs end to end:

```bash
cmake --preset ci-ninja-android-armeabi-v7a-debug
cmake --preset ci-ninja-android-arm64-v8a-debug
cmake --preset ci-ninja-android-x86_64-debug

cmake --build ./build_android_armeabi-v7a
cmake --build ./build_android_arm64-v8a
cmake --build ./build_android_x86_64

/opt/Qt/6.11.1/android_x86_64/bin/qt-cmake \
  --preset ci-ninja-android-all-archs-debug \
  -DQT_ANDROID_MULTI_ABI_FORWARD_VARS="ANDROID_PLATFORM"

cmake --build ./build_android_bundle/ --target aab
```

That last build produces
`build_android_bundle/QRLiteApp/android-build/build/outputs/bundle/debug/android-build-debug.aab`
— a single file containing native code for all three ABIs, ready for
signing. QRLite's CI (`.github/workflows/ci.yml`) runs the identical
sequence as a `build-android-bundle` job matrixed over debug/release, so the
same steps you'd run locally are exactly what's reproducible in a clean
container.

One more thing worth flagging if you're following along with your own
project: QRLiteApp's `CMakeLists.txt` sets
`QT_ANDROID_TARGET_SDK_VERSION 36`. Most Qt/Android tutorials and Stack
Overflow answers you'll find still assume an SDK version several years old
— Google's Play Store minimum target API requirement moves roughly once a
year, and Qt's own defaults lag behind it. Worth checking you're not
building against a target SDK version Play Store will reject before you get
to the upload step.

## What we have, and what's next

Starting from the previous post's single-ABI, Qt5, no-dependency-manager
baseline, we now have: Conan 2 resolving `zxing-cpp` and `Catch2` per-ABI
through a CMake dependency provider, `find_package()` correctly seeing both
Conan and Qt6 across an Android cross-compile, and a `qt-cmake`-driven bundle
step that turns three independent ABI builds into one `.aab`. That bundle is
Play Store-shaped but not yet Play Store-*ready* — it isn't signed, and there
is no upload key or CI wiring to a release track yet. Signing (`jarsigner`
vs. `apksigner`, managing the upload keystore, and turning
`.github/workflows/ci.yml`'s remaining jobs into an actual release pipeline)
is the subject of the next post.

The full, working set of `CMakeLists.txt` files, `CMakePresets.json`, the
`conanfile.txt`, and the CI workflow referenced throughout this post are all
in the [QRLite repository](https://github.com/bernedom/QRLite) — clone it,
open it in the shipped devcontainer, and `build-android-bundle.sh` will get
you the same `.aab` this post describes.
