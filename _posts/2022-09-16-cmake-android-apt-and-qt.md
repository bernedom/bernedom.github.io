---
layout: post
title: CMake line by line - Building and Android APK with Qt5
description: A line by line explanation of how to build an Android APK with CMake for a Qt5/QML application using the Android NDK and SDK.
thumbnail: images/qml_on_android/cmake-android-qt-logo.png
---

**CMake is very powerful, but it can be tough to figure out.** While the documentation of CMake is very detailed, it is often hard to figure out how to tie the individual details together. If you build standalone C++ applications, chances are that you have to build a mobile version of it. This post will walk through the CMakeLists.txt file for a Qt5/QML application that builds an Android APK. A major player for building GUI applications with C++ is Qt, while Qt6 is out and provides some additiona to build for android, Qt5 is still widely used, so this example focusses on Qt5 but the technique should also aplly to Qt6.

# What you need

In order to build an Android APK, you need the following:

* [Android SDK](https://developer.android.com/studio) and [Android SDK Tools](https://developer.android.com/studio/releases/platform-tools) - Either install it via Android Studio or download it from the website.
* [Android NDK](https://developer.android.com/ndk) version 20 or newer - Either install it via Android Studio or download it from the website.
* [Qt5 for Android](https://www.qt.io/download-qt-installer) Version 5.15 - Either install it with the installer, build it yourself or use [aqtinstall](https://github.com/miurahr/aqtinstall) to install it.
* [CMake](https://cmake.org/) at least version 3.21

Since the dependencies are quite heavy for building an Android APK with CMake, I recommend using [development containers](https://dominikberner.ch/using-devcontainers-with-cpp/) to set up your development environment. This way you can use the same environment on your local machine and on your CI server.

{% include cmake-best-practices-ad.html %}

# Project setup 

In a nutshell, running a C++/Qt Application on Android works by wrapping the C++ application in Java code. This Java code is then compiled into an Android APK, the instructions for it are provided by a AndroidManifest.xml. Under the hood, the C++ code is compiled into a shared library that is then loaded by the Java code at runtime. The C++ code is compiled with the Android NDK, while the Java code is compiled with the Android SDK. The CMake toolchain file for Android is provided by the Android NDK and is used to configure the C++ compiler and linker. 

{%include  figure.html url="images/qml_on_android/emulator.gif" description="The sample QML application running in the android emulator" %}

The example builds a small slideshow application that rotates through a set of image. All the code for this example can be found on [GitHub](https://github.com/bernedom/CMakeQtAPK/). The project is structured as follows:

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
# CMakeLists.txt

<details>
<summary markdown="span">
Click here to expand the full CMakePresets.json
</summary>

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
</details>

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
  set_target_properties(QMLDesktopExample PROPERTIES LIBRARY_OUTPUT_NAME CMakeQtAPKExample)
  add_dependencies(apk QMLDesktopExample)
endif()

target_sources(QMLDesktopExample PRIVATE src/main.cpp src/slideshow.cpp src/qml/qml.qrc)
target_link_libraries(QMLDesktopExample PRIVATE Qt5::Core Qt5::Quick)


```

</details>