--- 
layout: post
title: "C++, CMake, Conan and a Play Store: Building a Multi-ABI Qt6 Android App Bundle"
description: "How to use C++, CMake, and Conan as a CMake dependency provider along with a three-way Qt6 cross-build to produce a single Android App Bundle from one CMake project."
image: /images/qml_on_android/cmake-android-qt-logo.png
hero_image: /images/qml_on_android/cmake-android-qt-logo.png
hero_darken: true
tags: android qt6 cmake
lang: en
author: Dominik Berner
---

**C++ and Qt are a powerful combination for cross-platform development, but building for Android introduces unique challenges.** While for a long time it was enough to just build the software and [wrap it into an apk](/cmake-android-apk-and-qt/), modern Android development often requires handling multiple ABIs, integrating with Java tooling, and managing dependencies in a cross-compiled environment. This sounds tough, but by combining [CMake](https://cmake.org/), [Conan](https://conan.io/), and [Qt6](https://www.qt.io/)'s cross-build capabilities, it becomes manageable. Let's see how it all comes together.

[QRLite](https://github.com/bernedom/QRLite) is a small, local-only and ad-free app for reading QR-Codes that runs on Desktop and Android. It is a C++/Qt6 Android app, using [CMake presets](/cmake-presets-best-practices/), [Conan 2 as a CMake dependency provider](/conan-as-cmake-dependency-provider/), and Qt6's own `qt-cmake` tooling to go from source to a single installable `.aab` (Android App Bundle) covering arm and x86 architectures.[^1]
 
Let's see how it all comes together.

## The high level build process for multi-ABI Android App Bundles

[The basic setup for a Qt/CMake Android build is covered a previous post](/cmake-android-apk-and-qt/). That post covers NDK/SDK installation, environment variables, basic `CMakePresets.json` anatomy, and `adb install`. All are still valid, and we
won't repeat it here. However this time, we have some dependencies to manage, and this
post picks up from there and adds Conan 2 + Qt6, then we go all the way to
creating a multi-ABI bundle. 

Before we dive into the details of Conan and Qt integration, let's outline the high-level steps involved in building a multi-ABI Android App Bundle with CMake. At the baseline, an aab file is essentially a collection of packages for different plattforms, so the process of building one with C++ involves:

- Configuring CMake for each target ABI.
- Fetching and resolving dependencies for each ABI.
- Building the project for each ABI.
- Collecting the resulting binaries and resources.
- Packaging them into a single `.aab` file.

While there exist the `qt-cmake` wrapper to simplify Qt-specific configuration for Android, the underlying challenge of building for multiple ABIs remains. Each ABI still requires a separate CMake configuration and build step. Also qt-cmake has a few quirks and additional steps compared to plain CMake and if your stack is not Qt-centric, plain CMake is often easier to work with. So the approach here is to use plain CMake for building and testing and only use `qt-cmake` when necessary for packaging the final `.aab`.
Let's walk through each of these steps in more detail. 

## The dependency problem: Conan as a CMake dependency provider

QRLite depends on [zxing-cpp](https://github.com/zxing-cpp/zxing-cpp) for QR
decoding and [Catch2](https://github.com/catchorg/Catch2) for its test suite, which will not be bundled into the final Android App Bundle.

To manage these dependencies across multiple ABIs, we need a tool that understands both CMake and cross-compilation.
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
vendors as a git submodule at `cmake-conan/`. In [`CMakePresets.json`](https://github.com/bernedom/QRLite/blob/main/CMakePresets.json) this
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
dependencies look like any other CMake package to `find_package()`. For a more in-depth explanation, see the [Article @Conan as CMake Dependency Provider"](/conan-as-cmake-dependency-provider/).

### Host and build profiles

Once you're cross-compiling, "what compiler and settings should this
dependency be built with" stops having one answer, Conan needs to know about
*two* toolchains at once:

- the **build profile**: the machine actually running the compiler (your
  desktop/CI container, x86_64 Linux, system GCC/Clang)
- the **host profile**: the machine the binary will *run on* (an Android
  device — a given ABI, the NDK's Clang, `libc++`, a minimum API level)

For a desktop build these happen to be the same, so Conan defaults quietly
work. For Android they diverge on almost every axis: `arch`, `os`,
`compiler`, `compiler.libcxx`, even `compiler.version` (the NDK ships its own
Clang, not whatever `clang`). [QRLite's
devcontainer](/using-devcontainers-with-cpp/) and CI image (`bernedom/qtandroidbuilder`) ship pre-built Conan
profiles for exactly this split, one host profile per Android ABI/build type
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
"normal" one, plain `os=Linux`, system C++-Compiler. CMakePresets.json wires the pair
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
That's correct behaviour for system libraries, but it also means CMake will
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
`CMAKE_PREFIX_PATH`/`CMAKE_MODULE_PATH`, which is where both Conan's
generated package files and Qt6's Android package live.

Qt6 itself adds a second wrinkle: unlike Qt5's single `CMAKE_PREFIX_PATH`
from the prior article, Qt6 for Android ships **one full install per ABI**
(`android_armv7/`, `android_arm64_v8a/`, `android_x86_64/`), each exposed
through a `QT_PATH_ANDROID_ABI_<abi>` variable when you're building for
multiple ABIs at once. QRLite's top-level `CMakeLists.txt` combines Conan's per-ABI output directory and Qt6's per-ABI install into one manual prefix-path prepend, keyed on `CMAKE_ANDROID_ARCH_ABI`:

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

This is a bit of a workaround to make multi-ABI builds work with Conan and Qt and it would be nicer, if this would be covered by one of the presets, but so far this did not work out as we see later. This hack exists because a single CMake *configure* only
ever targets one ABI, but when creating the *bundle*, `qt-cmake` re-invokes
CMake three times against the same source tree from a fourth, top-level
configure, and that fourth configure needs to know where each of the three
per-ABI Conan installs ended up. `CONAN_ARM64_DIR` and friends are just plain
cache that are passed to the dependency provider and ultimately used by the bundle preset to locate each ABI's Conan install.

## From one APK to one bundle: why three ABIs means three builds

If you're building an `.apk` you `adb install` yourself can happily target one ABI. What the Play Store wants is different: a single `.aab` that contains the app's shared
libraries for *every* ABI you support, with Google Play generating
per-device APKs from it at install time. While CMake is great for cross-compiling it cannot build for more than one ABI at a time. A shortcoming that regularly sparks dicussions in the community.

And unfortunately, the android configuration such as `ANDROID_ABI` are configure-time settings. So the only way to get three ABIs' worth of native libraries
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
APKs' worth of native code, but Play Store bundles aren't "three APKs
concatenated," they're one Gradle-shaped Android project with all three
`.so` sets dropped into the right per-ABI `jniLibs` folders. Producing that
is a fourth, different kind of build.

## Tying it together: the bundle build

Qt6 has first-class support for aab of build, but it's driven through
`qt-cmake` rather than plain `cmake`, and it needs
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
list tells Qt6 "don't try to build these yourself, I've already built them,
just assemble the bundle from what's on disk." Two details matter for
actually running this configure step:

- It has to be invoked with **`qt-cmake` from one of the Android Qt
  installs**, not plain `cmake`. `qt-cmake` is what wires in Qt6's Android
  packaging machinery (the `aab` target itself doesn't exist otherwise).
- `QT_ANDROID_MULTI_ABI_FORWARD_VARS` needs to include `ANDROID_PLATFORM` so
  the per-ABI Android platform level set in the `android-ndk` preset actually
  propagates into the bundle project.

Put together, the full sequence looks like this:

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
`build_android_bundle/QRLiteApp/android-build/build/outputs/bundle/debug/android-build-debug.aab`, a single file containing native code for all three ABIs, ready for
signing. 

One more thing worth flagging if you're following along with your own
project: QRLiteApp's `CMakeLists.txt` sets
`QT_ANDROID_TARGET_SDK_VERSION 36`. Most Qt/Android tutorials and Stack
Overflow answers you'll find still assume an SDK version several years old, but Google's Play Store minimum target API requirement moves roughly once a
year, and Qt's own defaults lag behind it. Worth checking you're not
building against a target SDK version Play Store will reject before you get
to the upload step.

## What we have, and what's next

So at this point, we have Conan 2 resolving `zxing-cpp` and `Catch2` per-ABI
through a CMake dependency provider, `find_package()` correctly seeing both
Conan and Qt6 across an Android cross-compile, and a `qt-cmake`-driven bundle
step that turns three independent ABI builds into one `.aab`.

At this point you can sign the `.aab` and upload it to the Google Play Store (or any derivative app store) for distribution. While creating an `.aab` is a step up in complexity compared to a single-ABI APK, it simplifies distribution and ensures that users get the best possible version of your app for their device, so it is generally worth the extra effort. 

---
[^1]: The full, working set of `CMakeLists.txt` files, `CMakePresets.json`, the `conanfile.txt`, and a ready-made devcontainer are all in the [QRLite repository](https://github.com/bernedom/QRLite). QRLite is currently available as a closed beta on the Google Play Store.