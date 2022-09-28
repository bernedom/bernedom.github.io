---
layout: post
title: CMake line by line - Building and Android APK with Qt5
description: A line by line explanation of how to build an Android APK with CMake for a Qt5/QML application using the Android NDK and SDK.
thumbnail: images/qml_on_android/cmake-android-qt-logo.png
---

**Ever wondered how to build an android app with C++ and Qt?** Well wonder no more, here is a line by line explanation to get you started. Nowadays, if you build standalone C++/Qt/QML applications, chances are high that you have to build a mobile version of it or at least have to provide some some parts of it for mobile. While the discussion if this should be done using Qt and C++ or the native Android SDK is something to consider there are situations where it certainly makes sense to use Qt and C++ for the mobile version. In this post I will show you how to build an Android APK with CMake for a Qt5/QML application using the Android NDK and SDK. 

CMake is very powerful, but it can be tough to figure out. While the documentation of CMake is very detailed, it is often hard to figure out how to tie the individual details together. This post will walk through the CMakeLists.txt file for a Qt5/QML application that builds an Android APK. There is a lot more to building and maintaining a project on mobile like signing your APK and uploading it to the Play Store, but this post focusses only on building a first APK to get you started.



# What you need

In order to build an Android APK, you need the following:

* [Android SDK](https://developer.android.com/studio) and [Android SDK Tools](https://developer.android.com/studio/releases/platform-tools) - Either install it via Android Studio or download it from the website.
* [Android NDK](https://developer.android.com/ndk) version 20 or newer - Either install it via Android Studio or download it from the website.
* [Qt5 for Android](https://www.qt.io/download-qt-installer) Version 5.15 - Either install it with the installer, build it yourself or use [aqtinstall](https://github.com/miurahr/aqtinstall) to install it[^1].
* [CMake](https://cmake.org/) at least version 3.21

Since the dependencies are quite heavy for building an Android APK with CMake, I recommend using [development containers](https://dominikberner.ch/using-devcontainers-with-cpp/) to set up your development environment. This way you can use the same environment on your local machine and on your CI server.

{% include cmake-best-practices-ad.html %}

# Project setup 

In a nutshell, running a C++/Qt Application on Android works by wrapping the C++ application in Java code. This Java code is then compiled into an Android APK, the instructions for it are provided by a AndroidManifest.xml. Under the hood, the C++ code is compiled into a shared library that is then loaded by the Java code at runtime. The C++ code is compiled with the Android NDK, while the Java code is compiled with the Android SDK. The CMake toolchain file for Android is provided by the Android NDK and is used to configure the C++ compiler and linker. 

{%include  figure.html url="images/qml_on_android/emulator.gif" description="The sample QML application running in the android emulator" %}

The example builds a small slideshow application that rotates through a set of image. All the code for this example can be found on [GitHub/bernedom/CMakeQtAPK](https://github.com/bernedom/CMakeQtAPK/). The project is structured as follows:

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

So let's look at the CMake code to build an APK. 

# Building an APK with CMake

## Finding and configuring CMake to use Android and Qt

In order to build for Android, CMake needs to be pointed to the location of the java compiler, Android NDK and SDK as well as the Qt location. Additionally the Android target platform and ABI have to be specified. To acutally build CMake projects the Android NDK provides a convenient toolchain that set the C++ compiler and linker to the one included in the Android NDK. I prefer to pass these configuration options to CMake by using [CMake presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html), which are available from CMake 3.19. Alternatively the options can be passed to CMake via the command line or by setting environment variables. Avoid hardcoding the values in the `CMakeLists.txt` as it makes it harder to build the project on different machines.

The CMake presets are defined in the `CMakePresets.json` file. The presets are defined in a JSON file and can be used to configure CMake. The presets are defined as follows:


```Json
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
},
```

The `name` field is used to identify the preset. The `toolchainFile` field points to the toolchain file provided by the Android NDK. The `cacheVariables` field is used to pass configuration options to CMake. The `environment` field is used to set environment variables that are used by CMake. The `binaryDir` field is used to specify the build directory. The `${sourceDir}` variable is a CMake variable that is replaced by the path to the source directory. The `binaryDir` field is required if the build directory is not the default `build` directory. Since the Qt libaries are not in the sysroot provided by the Android NDK, the `CMAKE_FIND_ROOT_PATH_MODE_PACKAGE` variable has to be set to `BOTH` in order to find the Qt libraries. 

With the environment set up, let's have a look at the `CMakeLists.txt`

<details>
<summary markdown="span">
Click here to expand the full `CMakeLists.txt`
</summary>

```cmake

cmake_minimum_required(VERSION 3.21)

project(
  CMakeQtAPKExample
  VERSION 1.0
  DESCRIPTION
    "An example repository to showcase how to build a simple C++ android app with Qt/QML and CMake"
  LANGUAGES CXX)

find_package(Qt5 REQUIRED COMPONENTS Core Quick QuickWidgets Gui NO_CMAKE_FIND_ROOT_PATH)
set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")


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
</details>

First the `project` is set up, in our case it is called `CMakeQtAPKExample` and we tell CMake that it is a C++ project by setting the `LANGUAGES` to `CXX`. 

The first thing is to find the Qt libraries with the call to `find_package(Qt5 REQUIRED COMPONENTS Core Quick QuickWidgets Gui NO_CMAKE_FIND_ROOT_PATH)`. **@todo check NO_CMAKE_FIND_ROOT**  This tells CMake to look for the package `Qt5` which is required for building this project, and inside the package the modules `Core`, `Quick`, `QuickWidgets` and `Gui` should be present. If any of the modules or the package itself is not found, CMake will stop with an error. Since Qt for android is usually not installed in the default location, we added the path to Qt to the `CMAKE_PREFIX_PATH` variable in the `CMakePresets.json`. 

Next we tell CMake where to find the Android specific files such as the `AndroidManifest.xml`. **@TODO Tell where to get it**

The next two lines `set(CMAKE_AUTOMOC ON)` and `set(CMAKE_AUTORCC ON)` tell CMake to automatically generate the `moc`-files and compile any `qrc` files attached in any target. 

A typical use case is that the same code is used for desktop and mobile. In this case we can use the `if`-statement to check if we are building for Android or not. If we are building for a desktop, we just create a regular executable by defining the target with `add_executable`. 

If we are building for Android, the same target is added as a shared library with `add_library(QMLDesktopExample SHARED)`. The library has to be shared, so it can be dynamically loaded by the generated java code on android. This is a difference to a regular library project, where we would let the user chose if a library target should be built as a static or dynamic lib.

Next we add the `AndroidExtras` module from Qt with a `find_package` call. The `AndroidExtras` package will do most of the android specific stuff in CMake. It will copy and generate a **JSON** file used to pack the application. This will generate a target called `apk` which can later be used for packaging the application for deployment to android. Additionally there will be other similar targets such as the `aab` for building android app bundles.

The `target_link_libraries` call links the `Qt5::AndroidExtras` module to our application target which will add any dependencies needed to run the code on android. 

Since the `AndroidExtras` will name the APK the same as the project name, we set the `LIBRARY_OUTPUT_NAME` to the variable `${PROJECT_NAME}` which contains the name of the project (`CMakeAPKExample`). Note that we only change the name of the output-file and not the name of the target itself. 

Finally a dependency to the `apk` target is added to the `QMLDesktopExample` target. This will ensure that when the `apk` target is built, then our library target will also be built. The `apk` target is provided by the Android NDK and is used to build the APK. And that is all that is needed in regard to the Android specific CMake code. 

The next line `target_sources(QMLDesktopExample PRIVATE src/main.cpp src/slideshow.cpp src/qml/qml.qrc)` tells CMake which files should be compiled in the target. The `PRIVATE` keyword tells CMake that the files are only used by the target itself and not by any other target. And lastly the `target_link_libraries` call links the `Qt5::Core` and `Qt5::Quick` modules to our application target which will add any dependencies needed to run the code.

## Building the APK

Now that we have the CMake code ready, we can build the APK. To configure and build the example project, we can use the `cmake` command line tool and the preset we defined like this:

```bash

cmake --preset=android -S <Path_To_CMakeLists.txt>
cmake --build build_android --target apk

```

This will first configure the project and then build the APK. The APK will be located in the `build_android` folder as defined in our preset.

Since Qt itself and the Android NDK and SDK are quite heavy dependencies I recommend to use [containerized build environments](https://dominikberner.ch/using-devcontainers-with-cpp/) to build the project. This will ensure that the build environment is always the same and that your OS is not polluted with the dependencies dependencies. This comes in especially handy as it is often the case that one needs to build for different android versions and installing everythin directly into the OS can be a hassle. 

## Running the APK

The APK can now be run on any supported android device by either copying the APK to the device and installing it or by using the `adb` tool. 

**signing** disclaimer

[^1]: While Qt6 is out and provides some additional features to build for android, Qt5 is still widely used, so this example focusses on Qt5 but the technique should also apply to Qt6.