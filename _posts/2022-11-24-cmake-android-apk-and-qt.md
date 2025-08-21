---
layout: post
title: CMake line by line - Building and Android APK with Qt5
description: A line by line explanation of how to build an Android APK with CMake for a Qt5/QML application using the Android NDK and SDK.
image: /images/qml_on_android/cmake-android-qt-logo.png
hero_image: /images/qml_on_android/cmake-android-qt-logo.png
hero_darken: true
---

**If you build GUI applications with C++ and Qt, chances are that you have to create a mobile version of it.** While the discussion, if Qt and C++ or the native Android SDK is the right technology to use is certainly worth a tought, there are situations where it makes sense to stick with Qt and C++. This article illustrates line by line how to build a C++/Qt application for android with *CMake* and how to pack it into an android APK. 

This post will walk through the `CMakeLists.txt` file to build a Qt application for desktop and android and then pack it into an APK.

# What you need

To build an Android APK, you need the following:

* [Android SDK](https://developer.android.com/studio) and [Android SDK Tools](https://developer.android.com/studio/releases/platform-tools) - Either install it via Android Studio or download it from the website.
* [Android NDK](https://developer.android.com/ndk) version 20 or newer - Either install it via Android Studio or download it from the website.
* [Qt5 for Android](https://www.qt.io/download-qt-installer) Version 5.15 - Either install it with the installer, build it yourself or use [aqtinstall](https://github.com/miurahr/aqtinstall) to install it[^1].
* [CMake](https://cmake.org/) at least version 3.21

The example project used in this article can be found on [GitHub](https://github.com/bernedom/CMakeQtAPK/).

Since the dependencies for building an Android APK with CMake are quite heavy, I recommend using [development containers](https://softwarecraft.ch/using-devcontainers-with-cpp/) to set up your development environment. This way you can use the same environment on your local machine and your CI server.

{% include cmake-best-practices-ad.html %}

# Setting up the project

In a nutshell, running a C++/Qt Application on Android works by wrapping the C++ application in Java code. The Java code, all dependencies and resources are then packed into an *Android APK*. Under the hood, the C++ code is compiled into a shared library that is then loaded by the Java code at runtime. The C++ code is compiled and linked against the libraries from the Android Native Development Kit (*NDK*), while the Java code is built on the Android *SDK*. Conveniently the NDK provides a toolchain file for CMake to configure the C++ compiler and set the sysroot. 
Qt for android contains a template for the `AndroidManifest.xml` the Qt directory under `src/android/templates` which can be copied to the source folder. 

The example builds a small slideshow application that rotates through a set of images. All the code for this example can be found on [GitHub/bernedom/CMakeQtAPK](https://github.com/bernedom/CMakeQtAPK/). 

{%include  figure.html url="images/qml_on_android/emulator.gif" description="The sample QML application running in the android emulator" %}

The project is structured as follows:

```
├── android
│   └── AndroidManifest.xml
├── CMakeLists.txt
├── CMakePresets.json
└── src
    ├── main.cpp
    ├── qml
    │   ├── <various qml resources>
    │   ├── main.qml
    │   └── qml.qrc
    ├── slideshow.cpp
    └── slideshow.h
```

The `src` folder contains all C++ sources and Qml files and resources to build the app. The `android` folder contains the android-specific files, in our case only the `AndroidManifest.xml` file. The `CMakeLists.txt` file contains the build instructions for the project. The `CMakePresets.json` file contains the build configurations for the project. 

So let's look at the CMake code to build an APK. 

# Building an APK with CMake

## Finding and configuring CMake to use Android and Qt

To build for Android, CMake needs to know the location of a java compiler, the Android NDK and SDK as well as the Qt location. Additionally, the Android target platform and ABI have to be specified. I prefer to pass configuration options to CMake by using [CMake presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html), which are available from CMake 3.19. Alternatively, the options can be passed to CMake via the command line or by setting environment variables. Avoid hard coding the values in the `CMakeLists.txt` as it makes it harder to build the project on different machines.

The CMake presets are defined in the `CMakePresets.json` file. The presets are defined in a JSON file and can be used to configure CMake:

```json
...
"configurePresets:" [
  {
    "name": "android",
    "toolchainFile": "/opt/android-ndk/build/cmake/android.toolchain.cmake",
    "cacheVariables": {
        "ANDROID_ABI": "armeabi-v7a",
        "ANDROID_PLATFORM": "23",
        "ANDROID_SDK": "/opt/android-sdk",
        "CMAKE_FIND_ROOT_PATH_MODE_PACKAGE": "BOTH",
        "ANDROID_BUILD_ABI_armeabi-v7a" : "ON"
    },
    "environment": {
        "JAVA_HOME": "/usr/lib/jvm/java-1.8.0-openjdk-amd64",
        "ANDROID_SDK_ROOT": "/opt/android-sdk",
        "ANDROID_NDK_ROOT": "/opt/android-ndk",
        "CMAKE_PREFIX_PATH": "/usr/local/Qt/android"
    },
    "binaryDir": "${sourceDir}/build_android"
  }  
]
...
```

The `name` field is used to identify the preset and the `toolchainFile` field points to the toolchain file provided by the Android NDK. This toolchain file tells CMake to use the clang compiler from the NDK to cross-compile and changes the search paths to the libraries to the sysroot included with the NDK.
The `cacheVariables` field is used to pass configuration options to CMake. In this case, we set the ABI to `armeabi-v7a`, the target platform to Android 6.0 (API level 23) and the location of the Android SDK. 
Additionally, we set the `CMAKE_FIND_ROOT_PATH_MODE_PACKAGE` to `BOTH` to make sure that CMake searches for packages in the sysroot and in the host system. This is needed to find the Qt libraries which are outside the sysroot. The `ANDROID_BUILD_ABI_armeabi-v7a` variable is used to enable building for the armv7 ABI in the toolchain file.
The `environment` field is used to set environment variables that are used by the toolchain file. the `JAVA_HOME` variable is used to find the java compiler, the `ANDROID_SDK_ROOT` and `ANDROID_NDK_ROOT` variables are used to find the Android SDK and NDK and the `CMAKE_PREFIX_PATH` variable is used to find the Qt libraries.
The `binaryDir` field is used to set the build directory for the preset. The `${sourceDir}` variable is a CMake variable that is replaced by the path to the source directory. 

With the environment set up, let's have a look at the `CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.21)

project(
  CMakeQtAPKExample
  VERSION 1.0
  DESCRIPTION
    "An example repository to showcase how to build a simple C++ android app with Qt/QML and CMake"
  LANGUAGES CXX)

find_package(Qt5 REQUIRED COMPONENTS Core Quick)
set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android" CACHE INTERNAL "" FORCE)


set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

if(NOT ANDROID)
  add_executable(QMLDesktopExample)
elseif(ANDROID)
  add_library(QMLDesktopExample SHARED)
  find_package(Qt5 REQUIRED AndroidExtras)
  target_link_libraries(QMLDesktopExample PRIVATE Qt5::AndroidExtras)
  set_target_properties(QMLDesktopExample PROPERTIES LIBRARY_OUTPUT_NAME ${PROJECT_NAME})
  add_dependencies(apk QMLDesktopExample)
endif()

target_sources(QMLDesktopExample PRIVATE src/main.cpp src/slideshow.cpp src/qml/qml.qrc)
target_link_libraries(QMLDesktopExample PRIVATE Qt5::Core Qt5::Quick)

```

The first line `cmake_minimum_required(VERSION 3.21)` sets the minimum required CMake version to 3.21. since this project is using CMake presets, this is the minimum required version. 


The call to `project()` sets up the basic project information. In this case, the project is called `CMakeQtAPKExample` and we tell CMake that it is a C++ project by setting the `LANGUAGES` to `CXX`. Qt will later use the project name for the generated APK. 

Before we start defining our application, tell CMake to look for the necessary Qt libraries with the call to `find_package(Qt5 REQUIRED COMPONENTS Core Quick)`. This tells CMake to look for the package `Qt5` which is required for building this project, and inside the package the modules `Core` and `Quick` should be present. If any of the modules or the package itself is not found, CMake will stop with an error. Since Qt for android is usually not installed in the default location, we added the path to Qt to the `CMAKE_PREFIX_PATH` variable in the `CMakePresets.json`. 
Next, we tell CMake where to find the Android-specific files by setting the `ANDROID_PACKAGE_SOURCE_DIR` variable to the `android` subfolder. Since this is a very simple project the directory only contains the `AndroidManifest.xml` but for more complex projects `build.gradle` and other gradle scripts, as well as custom java code, can be placed there. You'll notice that this variable is set as an internal cache variable that will be force-overwritten by each configuration step. This is needed so the Qt AndroidExtras module is forced to use our custom `AndroidManifest.xml` file instead of the generated one. This is a somewhat hacky solution caused by the Qt Android extras from Qt5 not respecting the variable otherwise. 

The next two lines `set(CMAKE_AUTOMOC ON)` and `set(CMAKE_AUTORCC ON)` tell CMake to automatically generate the `moc`-files and compile any `qrc` files attached to any CMake target. 

A typical use case is that the same code is used for desktop and mobile. In this case, we can use the `if`-statement to check if we are building for Android or not. If we are building for a desktop, a regular executable is created by defining the target with `add_executable`. 

If we are building for Android, we create a target that creates a shared library with `add_library(QMLDesktopExample SHARED)`. The library has to be shared, so it can be dynamically loaded by the generated java code on android. This is different from regular library projects, where we would let the developer choose if a library target should be built as a static or dynamic lib.

Next, we search the `AndroidExtras` module from Qt with another `find_package` call. The `AndroidExtras` will do most of the android specific stuff in CMake. It will generate a `android_deployment_settings.json` file used to pack the application which will be placed in the build directory. The AndroidExtras will also generate a target called `apk` which can later be used for packaging the application for deployment to android. Additionally, there will be other similar targets such as the `aab` for building android app bundles. Unfortunately the [documentation for the [AndroidExtras module](https://doc.qt.io/qt-5/android-building.html) is very slim, so you will have to look at the source code if you want to find out more.

The `target_link_libraries` call links the `Qt5::AndroidExtras` module to our application target which will add any dependencies needed to run the code on android. 

Since the `AndroidExtras` will automatically name the APK the same as the project name and expects the library to be named the same, we set the `LIBRARY_OUTPUT_NAME` to the variable `${PROJECT_NAME}` which contains the name of the project (`CMakeAPKExample`). Note that we only change the name of the output file and not the name of the target itself. 

Finally, a dependency on the `apk` target is added to the `QMLDesktopExample` target with the call to `add_dependencies(apk QMLDesktopExample)`. This will ensure that when the `apk` target is built, then our library target will also be built. The `apk` target is provided by the Qt `AndroidExtras`. And that is all that is needed regarding the Android-specific CMake code. 

So now the target is set up, we only need to add the C++ sources and Qml resources to it. This happens in the next line `target_sources(QMLDesktopExample PRIVATE src/main.cpp src/slideshow.cpp src/qml/qml.qrc)`. The `PRIVATE` keyword tells CMake that the files are only used by the target itself and not by any other target. And lastly, the `target_link_libraries`` call links the `Qt5::Core` and `Qt5::Quick` modules to our application target which will add any dependencies needed to run the code.

## Building the APK

Now that we have the CMake code ready, we can build the APK. To configure and build the example project, we can use the `cmake` command line tool and the preset we defined like this:

```bash

cmake --preset=android -S <Path_To_CMakeLists.txt>
cmake --build build_android --target apk

```

This will first configure the project and then build the APK. The APK will be located in the `build_android` folder as defined in our preset.

Since Qt itself and the Android NDK and SDK are quite heavy dependencies I recommend using [containerized build](https://softwarecraft.ch/using-devcontainers-with-cpp/) environments](https://softwarecraft.ch/using-devcontainers-with-cpp/) to build the project. This will ensure that the build-environment is always the same and that your OS is not polluted with the dependencies. This comes in especially handy as it is often the case that one needs to build for different android versions and installing everything directly into the OS can be a hassle. 

## Running the APK

The APK can now be run on any supported android device by either copying the APK to the device or android emulator or by using the `adb` tool. To install it with the `adb` tool USB debugging has to be enabled on the android device, we can use the following command:

```bash
adb usb
adb install -r <Path_To_APK>
``` 

## Conclusion

While it needs a bit of effort to set up, building and running simple Qt applications on Android is not that hard thanks to the Qt AndroidExtras module that does most of the work. There is more to releasing software on Android, such as publishing on the play store and signing the generated APK as well as publishing for the various android versions out there. However, this post should give you a good starting point to get started with Qt on Android and hopefully, you will be able to build your own Qt applications for Android. Have fun running stuff on Android!

---

[^1]: While Qt6 is out and provides some additional features to build for android, Qt5 is still widely used, so this example focuses on Qt5 but the technique should also apply to Qt6.