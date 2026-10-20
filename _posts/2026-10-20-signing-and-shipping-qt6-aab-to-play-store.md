---
layout: post
title: "From App Bundle to Play Store: Signing and Shipping a Qt6 Android App with GitHub Actions"
description: "How QRLite turns its multi-ABI Qt6 Android App Bundle into a signed release that lands on the Google Play internal track on every GitHub release."
image: /images/qml_on_android/cmake-android-qt-logo.png
hero_image: /images/qml_on_android/cmake-android-qt-logo.png
hero_darken: true
tags: android qt6 cmake github-actions ci
lang: en
author: Dominik Berner
---

**When creating C++/Qt6 Android apps, building and packaging is only half the battle. True delivery needs signing and distributing the app to the Play Store.** In the [last post](https://softwarecraft.ch/publishing-android-aab-qt6-and-cmake/) we went from a single-ABI APK to a multi-ABI Android App Bundle (`.aab`) for [QRLite](https://github.com/bernedom/QRLite), our small C++/Qt6 QR code scanner[^1]. We used CMake presets, Conan 2 as a dependency provider, and `qt-cmake` to merge the separate per-ABI builds into one bundle. At the end we had a valid `.aab` on disk. Google Play still won't accept it, though, because it isn't signed, and nothing gets it from the build machine into the Play Console.

This post closes that gap. **We take the bundle build into CI, sign the result with an upload key, and push it to the Play Store's internal test track, all triggered by creating a GitHub release.** None of the steps are complicated on their own. Most of the work is in the one-time setup around them (keystores, service accounts, the first manual upload) and in knowing which Android tool applies to which file type. Let's see how it all comes together.

## The pipeline at a glance

QRLite's whole build lives in a single GitHub Actions workflow, `.github/workflows/ci.yml`. The jobs that matter for releasing are a chain:

1. **`build-android-bundle`** builds the per-ABI builds, merges them into an `.aab`, and uploads it as a workflow artifact.
2. **`sign-android-bundle`** downloads the unsigned bundle, signs it with the upload key, verifies the signature, and uploads the signed bundle as a new artifact.
3. **`deploy-to-play-store`** downloads the signed bundle and pushes it to Google Play.

Each job declares the previous one in `needs:`, so a failed build never gets signed and a failed signature never gets uploaded. Only the first job runs on every push. Signing and deployment are gated on release events:

```yaml
on:
  push:
  pull_request:
    branches:
      - main
  release:
    types: [created]
```

Building the bundle on every push is cheap insurance: if a change breaks the multi-ABI build, we find out on the pull request, not on release day.

## Bundling the single builds in CI

The previous post already covered *how* the bundle build works, so here we only look at what changes when it runs in CI. All jobs run inside the same container image we use as a devcontainer locally (`bernedom/qtandroidbuilder`), which ships the NDK, the Android SDK, Qt for all Android ABIs, and Conan. That means the CI steps map one-to-one onto what `build-android-bundle.sh` does on a developer machine.

```yaml
  build-android-bundle:
    runs-on: ubuntu-24.04
    container:
      image: bernedom/qtandroidbuilder:latest

    strategy:
      matrix:
        build_type: [debug, release]
    steps:
      - name: Checkout code
        uses: actions/checkout@v7
        with:
          fetch-depth: 0
          submodules: recursive
      - name: Configure arm64-v8a
        run: cmake --preset ci-ninja-android-arm64-v8a-${{ matrix.build_type }}
      - name: build arm64-v8a
        run: cmake --build build_android_arm64-v8a
      - name: Configure x86_64
        run: cmake --preset ci-ninja-android-x86_64-${{ matrix.build_type }}
      - name: build x86_64
        run: cmake --build build_android_x86_64

      - name: Configure Android App Bundle
        run: /opt/Qt/6.11.1/android_x86_64/bin/qt-cmake --preset ci-ninja-android-all-archs-${{ matrix.build_type }} -DQT_ANDROID_MULTI_ABI_FORWARD_VARS="ANDROID_PLATFORM"
      - name: Build Android App Bundle
        run: cmake --build build_android_bundle --target aab
```

CI builds `arm64-v8a`, which covers practically every Android phone and tablet sold in recent years, and `x86_64`, which covers emulators and x86-based Chromebooks. A few details are worth pointing out:

**The single-ABI builds come first for a reason.** The bundle preset doesn't resolve dependencies on its own. It points at the Conan output of the per-ABI build directories through `CONAN_ARM64_DIR`, `CONAN_X86_64_DIR`, and so on. If you skip the per-ABI configure and build, the bundle configure can't find `zxing-cpp` for the respective ABI. Running them as separate, named steps also makes it obvious in the Actions log which architecture broke.

**`QT_ANDROID_MULTI_ABI_FORWARD_VARS` is easy to miss.** For a multi-ABI build, Qt configures the additional ABIs as sub-builds, and only a small, fixed set of CMake variables is passed down to them. `ANDROID_PLATFORM` (the minimum API level, `31` in our presets) isn't part of that set. Without forwarding it explicitly, the sub-builds fall back to the NDK's default API level, and you end up with native libraries in the same bundle that were built against different platform levels. That's the kind of mismatch that works on your test device and fails somewhere else.

**The Qt path is spelled out in the workflow.** We call `qt-cmake` by its absolute path in the container. That's pragmatic, but it means the Qt version now appears in two places, in `CMakePresets.json` and in `ci.yml`. When you bump Qt, bump both.

### Handing the bundle to the next job

The bundle ends up deep inside Gradle's output tree. The path follows the pattern `build/outputs/bundle/<build type>/android-build-<build type>.aab` below the Android build directory Qt generates:

```yaml
      - name: Upload AAB artifact
        if: matrix.build_type == 'release'
        uses: actions/upload-artifact@v7
        with:
          name: qrlite-aab-${{ matrix.build_type }}
          path: ./build_android_bundle/QRLiteApp/android-build/build/outputs/bundle/${{ matrix.build_type }}/android-build-${{ matrix.build_type }}.aab
          retention-days: 7
```

Both debug and release bundles are built through the matrix, so a broken debug configuration still fails the pipeline. Only the release bundle is uploaded as an artifact, because it's the only one that continues down the chain. A short `retention-days` keeps unsigned build output from piling up in the repository's storage quota.

## Signing: upload key vs. app signing key

Before writing any CI code it helps to be clear about *which* key we're actually dealing with, because Google Play uses two.

With **Play App Signing**, which is mandatory for new apps published as `.aab`, Google holds the *app signing key*. That's the key that signs the APKs Play generates from your bundle and delivers to devices. You never see it. What you hold is the **upload key**. You sign the bundle with it, and Play uses it only to verify that the upload really came from you. Then it strips your signature and re-signs with the app signing key.

The nice consequence: if the upload key leaks or gets lost, it's annoying but not fatal. You can ask Google to register a new upload key, and users keep receiving updates. If you lost the actual app signing key in the old self-signed model, that was the end of updates for that package name.

### Creating the upload keystore

The upload key is a plain Java keystore, created once with `keytool`, which ships with every JDK:

```bash
keytool -genkeypair -v \
  -keystore upload-key.jks \
  -alias upload \
  -keyalg RSA -keysize 2048 \
  -validity 10000
```

`keytool` asks for a store password, a key password, and the certificate's distinguished name fields. Pick a long validity: Google requires the key to be valid well beyond any realistic app lifetime. If you'll ever need to register or reset the upload key with Google, export its public certificate as PEM:

```bash
keytool -export -rfc -keystore upload-key.jks -alias upload -file upload_certificate.pem
```

### `apksigner` vs. `jarsigner`

This is the bit that trips people up, because the Android SDK documentation leans heavily on `apksigner`. The rule is simple:

- **APKs** are signed with `apksigner`. It applies the APK Signature Scheme
v2/v3/v4 that modern Android devices verify on install.
- **App Bundles** are signed with `jarsigner`, the classic JAR signing tool
from the JDK. `apksigner` doesn't support `.aab` files. Play only checks the upload signature and re-signs the generated APKs anyway, so the older JAR signature scheme is all that's needed.

QRLite's workflow actually uses both. The per-ABI `build-android` job signs its standalone release APKs with `apksigner`, which is handy for sideloading test builds. The bundle pipeline uses `jarsigner`. If you ever see a Play Console error saying your bundle isn't signed even though "signing succeeded", check which of the two tools you ran on which file.

### Keeping the keystore out of the repository

The keystore and its passwords are the one thing in this pipeline that must never end up in version control, not even in a private repository. Repositories get forked, cloned onto laptops, and mirrored, and Git history never forgets. **The keystore, its passwords, and the key alias live exclusively as CI secrets.** Add `*.jks` and similar files to `.gitignore` early, before an innocent `git add -A` picks them up.

GitHub Actions secrets are strings, while a keystore is a binary file. The usual trick is to base64-encode it once on your machine:

```bash
base64 -w0 upload-key.jks
```

Then paste the output into a repository secret. QRLite uses four secrets for signing and deployment:

| Secret | Contents |
|--------|----------|
| `UPLOAD_KEYSTORE_BASE64` | The base64-encoded `.jks` file |
| `UPLOAD_KEYSTORE_PASSWORD` | Store and key password (the same value here) |
| `UPLOAD_KEYSTORE_ALIAS` | The key alias inside the keystore |
| `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` | The Play API service account key, more on that below |

Once the secrets are stored, delete local copies you don't need and keep the original keystore in a password manager or another secure backup.

### The signing job

With the secrets in place, the signing job itself is short:

```yaml
  sign-android-bundle:
    runs-on: ubuntu-24.04
    if: github.event_name == 'release'
    container:
      image: bernedom/qtandroidbuilder:latest

    needs: build-android-bundle

    steps:
      - name: Checkout code
        uses: actions/checkout@v7
        with:
          fetch-depth: 0
          submodules: recursive

      - name: Download release AAB artifact
        uses: actions/download-artifact@v8
        with:
          name: qrlite-aab-release

      - name: Decode upload key
        run: echo "${{ secrets.UPLOAD_KEYSTORE_BASE64 }}" | base64 -d > upload-key.jks

      - name: Sign Android App Bundle
        run: |
          jarsigner -keystore ./upload-key.jks -storepass '${{ secrets.UPLOAD_KEYSTORE_PASSWORD }}' -keypass '${{ secrets.UPLOAD_KEYSTORE_PASSWORD}}' ./android-build-release.aab ${{ secrets.UPLOAD_KEYSTORE_ALIAS}}

      - name: Verify signature
        run: |
          jarsigner -verify -verbose -certs ./android-build-release.aab

      - name: Upload signed AAB artifact
        uses: actions/upload-artifact@v7
        with:
          name: qrlite-signed-aab-release
          path: ./android-build-release.aab
          retention-days: 7
```

Why a separate job instead of a final step in the build job? Two reasons. First, **the keystore only gets decoded in a job that runs on release events**. Pushes and pull requests never touch the secret at all, which keeps the attack surface small. Second, the split leaves an unsigned and a signed artifact side by side, which makes it easy to tell "the build is broken" apart from "the signing is broken".

`jarsigner` signs in place, so the downloaded file becomes the signed one. The verification step is cheap and catches the most common mistake early: a wrong alias or password usually makes `jarsigner` fail loudly, but `-verify -certs` also prints the certificate. That lets you confirm in the log that the bundle was signed with the key you expect, and not a debug key that slipped in from somewhere.

GitHub masks secret values in the logs, so the passwords on the command line don't show up in the output. The decoded `upload-key.jks` only exists on the ephemeral runner and disappears with it.

## Uploading to the Play Store

The last job talks to the Google Play Developer API. Before CI can do that, there's some one-time clicking to do in the Play Console and the Google Cloud Console.

### One-time setup

**The first upload has to be manual.** The Play Developer API can't create an app. It can only publish new releases of an app that already exists. So create the app in the Play Console, fill in the mandatory store listing and content questionnaires, and upload the first signed bundle by hand to a testing track. This is also where you opt into Play App Signing and register your upload key.

**Create a service account.** In the Google Cloud Console, pick (or create) a project, enable the *Google Play Android Developer API*, create a service account, and generate a JSON key for it. That JSON file is what goes into the `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` secret, verbatim. The same rules as for the keystore apply: it's a credential, so it belongs in CI secrets and nowhere else.

**Grant the service account access in Play.** In the Play Console, under *Users and permissions*, invite the service account's email address like a regular user. Give it access to the app and the permissions to manage testing track releases. Permission changes can take a while to propagate. If the first automated upload fails with an authorization error right after setup, waiting a bit and re-running the job often fixes it.

### The deploy job

With that in place, the job uses the community action [`r0adkll/upload-google-play`](https://github.com/r0adkll/upload-google-play), which wraps the Play Developer API's edit/upload/commit dance:

```yaml
  deploy-to-play-store:
    runs-on: ubuntu-24.04
    if: github.event_name == 'release'
    needs: sign-android-bundle

    steps:
      - name: Download signed AAB artifact
        uses: actions/download-artifact@v8
        with:
          name: qrlite-signed-aab-release

      - name: Upload to Google Play (internal track)
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.GOOGLE_PLAY_SERVICE_ACCOUNT_JSON }}
          packageName: ch.softwarecraft.qrlite
          releaseFiles: android-build-release.aab
          track: internal
```

Note that this job doesn't need the build container. It doesn't compile or sign anything, so it runs directly on the stock Ubuntu runner and starts a lot faster.

We deliberately publish to the **internal** track. Internal testing releases are available to the testers within minutes and skip most of the review delay. Promoting a release to closed testing or production then remains a conscious decision in the Play Console, not something a mistyped tag can trigger. Once you trust the pipeline, switching `track` to `alpha`, `beta`, or `production`, or adding a staged rollout via the action's `userFraction` input, is a one-line change.

The `packageName` has to match `QT_ANDROID_PACKAGE_NAME` in the app's `CMakeLists.txt` exactly. It's the identity of the app on Play and can never change after the first upload.

## Pitfalls and lessons learned

A few things that cost us time and are worth knowing upfront:

**The version code has to go up on every upload.** Play rejects any bundle whose `versionCode` it has already seen, on *any* track. In QRLite the version code is currently a hard-coded target property:

```cmake
set_target_properties(
  QRLite
  PROPERTIES QT_ANDROID_PACKAGE_NAME "ch.softwarecraft.qrlite"
             QT_ANDROID_APP_ICON "src/qml/images/icon.png"
             QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
             QT_ANDROID_TARGET_SDK_VERSION 36
             QT_ANDROID_VERSION_CODE 6)
```

That means a manual "bump version code" commit before each release, which is easy to forget. The git history of QRLite has a few of those. The obvious improvement is to turn it into a cache variable, set from CI, for example from `github.run_number` or from a counter derived from the release tag. That's on our list.

**Target SDK requirements move.** Google raises the minimum target API level for new apps and updates roughly once a year. We set `QT_ANDROID_TARGET_SDK_VERSION 36` explicitly, rather than relying on Qt's default, which tends to lag behind. If uploads start getting rejected after months of working fine, check this first.

**Draft apps only accept draft releases.** If the app has never been published to any track for review, the API refuses to create a completed release ("Only releases with status draft may be created on draft app"). Either finish the first manual release in the Console first, or set the action's `status: draft` until you have.

**Versions in two places drift.** The Qt version shows up both in `CMakePresets.json` and in the hard-coded `qt-cmake` path in `ci.yml`. Updating the devcontainer image without updating both gives you confusing "Qt not found" errors in exactly one job.

## Wrap-up

Over this series, QRLite went from a single-ABI debug APK to a fully automated release pipeline. Conan 2 resolves C++ dependencies per ABI through a CMake dependency provider. The per-ABI Qt6 builds are merged into one App Bundle by `qt-cmake`. And with this post, **the bundle is signed with an upload key that lives only in CI secrets and pushed to the Play Store's internal track, all from clicking "Publish release" on GitHub.**

The individual pieces are standard Android tooling. The work lies in making a C++/CMake/Conan build and a Gradle-shaped packaging world agree with each other, and in getting the one-time setup right. Once that's done, shipping a new version is no longer a chore that takes half a day. It's a tag.

---

*If you're struggling with building, packaging, or shipping C++ applications to Android or other platforms, [get in touch](https://softwarecraft.ch/contact/). We help teams set up build and deployment pipelines that just work.*

[^1]: The full workflow, `CMakePresets.json`, and all `CMakeLists.txt` files
referenced in this post are in the [QRLite repository](https://github.com/bernedom/QRLite). QRLite is currently in closed beta on Google Play.
