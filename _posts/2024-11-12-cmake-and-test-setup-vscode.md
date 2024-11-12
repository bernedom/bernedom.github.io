---
layout: post
title:  "Setting up CMake and Unit Testing for C++ in VSCode"
description: "Setting up CMake and unit testing for C++ is a common task for developers. With the test explorer integration of VScode this becomes even easier."
thumbnail: images/cmake-conan-logo.png
---

**The lack of easy integration of testing is one of the main reasons why it is often not done in C++ projects.** By leveraging modern tools and features such as [CMake dependency providers with conan](https://dominikberner.ch/conan-as-cmake-dependency-provider/)] the [VSCode test explorer](https://marketplace.visualstudio.com/items?itemName=hbenl.vscode-test-explorer) and a modern unit testing framework such as [Catch2](https://github.com/catchorg/Catch2) having easy accesible testing in your editor is a breeze. 


## What you need to get started

To get started you need to have the following tools installed:

* [CMake](https://cmake.org/) version 3.24 or newer
* [Conan](https://conan.io/) version 2.0 or newer (This requires python 3)
* [VSCode](https://code.visualstudio.com/) with the following extensions:
  * [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
  * [Test Explorer UI](https://marketplace.visualstudio.com/items?itemName=hbenl.vscode-test-explorer)

An example project to be used with this setup can be found [here](https://github.com/bernedom/CMakeConanCatchTemplate). Once you have installed the required tools you can clone the repository and open it in VSCode (or create your own project).

The project structure is as follows:

```
.
├── cmake-conan
│   ├── ...
├── CMakeLists.txt
├── CMakePresets.json
├── conanfile.txt
├── README.md
└── test
    ├── CMakeLists.txt
    └── src
        └── example_test.cpp


```
