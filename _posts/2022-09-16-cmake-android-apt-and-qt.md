---
layout: post
title: CMake line by line - Building and Android APK with Qt5
description: A line by line explanation of how to build an Android APK with CMake for a Qt5/QML application using the Android NDK and SDK.
thumbnail: images/cmake-logo.png
---

**CMake is very powerful, but it can be tough to figure out.** While the documentation of CMake is very detailed, it is often hard to figure out how to tie the individual details together. If you build standalone C++ applications, chances are that you have to build a mobile version of it. This post will walk through the CMakeLists.txt file for a Qt5/QML application that builds an Android APK. A major player for building GUI applications with C++ is Qt, while Qt6 is out and provides some additiona to build for android, Qt5 is still widely used, so this example focusses on Qt5 but the technique should also aplly to Qt6.

# What you need

In order to build an Android APK, you need the following:

* [Android SDK](https://developer.android.com/studio) - Either install it via Android Studio or download it from the website.
* [Android NDK](https://developer.android.com/ndk) version 20 or newer - Either install it via Android Studio or download it from the website.
* [Qt5 for Android](https://www.qt.io/download-qt-installer) Version 5.15 - Either install it with the installer, build it yourself or use [aqtinstall](https://github.com/miurahr/aqtinstall) to install it
* [CMake](https://cmake.org/) at least 3.21



# The CMakeLists.txt
