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
* [Conan](https://conan.io/) version 2.0 or newer (Optionally, if you want to use conan as a dependency provider to install Catch2)
* [VSCode](https://code.visualstudio.com/) with the following extensions:
  * [CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools) to run CMake in VSCode
  * [Test Explorer UI](https://marketplace.visualstudio.com/items?itemName=hbenl.vscode-test-explorer) to get a nice UI for your tests
  * [CMake Test Adapter](https://marketplace.visualstudio.com/items?itemName=fredericbonnet.cmake-test-adapter) to run your tests in the test explorer
* [Catch2](https://github.com/catchorg/Catch2) as a test runner. (This is optional if you're using Conan as a dependency provider)
* [Ninja](https://ninja-build.org/) as a build system (Optional, but recommended for faster builds)

An example project to be used with this setup can be found [here](https://github.com/bernedom/CMakeConanCatchTemplate). Once you have installed the required tools you can clone the repository and open it in VSCode, be sure to also pull the submodule for the conan dependency provider integration. 
Alternatively you can create a new project on your own, the steps to set up a C++ project with full testing integration are described below.

The project structure is as follows:

```bash
.
├── cmake-conan # Submodule for the conan dependency provider
│   ├── ...
├── CMakeLists.txt # Root CMakeLists.txt
├── src # Source files
├── CMakePresets.json # CMake presets to use Conan
├── conanfile.txt # Conan file to install Catch2
└── test 
    ├── CMakeLists.txt # CMakeLists.txt for the test executable & discovery
    └── src # Test source files
        └── example_test.cpp
```

If everything is set up correctly you should see the test explorer in the sidebar of VSCode.


