---
layout: post
title: Handling CMake Presets to build a project
description: CMake presets are a big help on how to configure CMake. This article shows how to set up and organize them.
thumbnail: images/qml_on_android/cmake-logo.png
---

**[CMake presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html) are arguably one of the biggest improvements in CMake since the introduction of targets.** They are a big help for managing different configurations for CMake and can be of tremendous help for handling various compilers and platforms. In a nutshell, CMake presets contain information on how to configure, build, test and package a CMake project. They are stored in a JSON file and can be used to configure CMake with a single command. This article shows how to set up and organize and use them so they are most effective and easy to maintain. 

# CMake presets in a nutshell

CMake presets are a way to store information on how to configure, build and test a CMake project. They are stored in JSON files that can be named `CMakePresets.json` or `CMakeUserPresets.json`. The former is intended to be checked into version control and the latter is intended to be used by the user and is often very system specific. The files are located at the root of the CMake project. There are various types of presets that describe the different steps of building a CMake project: 

* **Configure presets**: describe how to configure a CMake project. They specify the generator, toolchain file, CMake cache variables and the build folder among other options.
* **Build presets**: describe how to build a CMake project. They may specify the build targets and the configuration for multi-configuration toolchains such as MSVC or ninja-multi.
* **Test presets**: describe the envoronment and conditions for running tests. They may specify the test executable and the test filter.
* **Package presets**: describe how to package a CMake project. They may specify the package type and the package destination.
* **Workflow presets**: describe a sequence of actions to be executed. They may specify the presets to be executed and the order in which they are executed.

While Test, Package and especially workflow presets are useful, in this article we will focus on organizing the configure and build presets as they are the most important ones for building the project. For the full documentation on CMake presets see the [official CMake documentation](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html). 

{% include cmake-best-practices-ad.html %}



{%include figure.html url="images/cmake-presets/Preset-Organisation.drawio.png" description="CMake presets are a big help on how to configure CMake."%}