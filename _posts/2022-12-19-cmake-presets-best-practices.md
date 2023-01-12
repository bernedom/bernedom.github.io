---
layout: post
title: Good practices for organizing CMake presets
description: CMake presets are a big help on how to configure CMake. This article shows how to set up and organize them.
thumbnail: images/cmake-logo.png
---

**[CMake presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html) are arguably one of the biggest improvements in CMake since the introduction of targets.** They are a big help for managing different configurations for CMake and can be of tremendous help for handling various compilers and platforms. In a nutshell, CMake presets contain information on how to configure, build, test and package a CMake project. They are stored in a JSON file and can be used to configure CMake with a single command. This article shows how to set up and organize and use them so they are most effective and easy to maintain. 

# CMake presets in a nutshell

CMake presets are a way to store information on how to configure, build and test a CMake project. They are stored in JSON files that can be named `CMakePresets.json` or `CMakeUserPresets.json`. The former is intended to be checked into version control and the latter is intended to be used by the user and is often very system specific. The files are located at the root of the CMake project. There are various types of presets that describe the different steps of building a CMake project: 

* **Configure presets**: describe how to configure a CMake project. They specify the generator, toolchain file, CMake cache variables and the build folder among other options.
* **Build presets**: describe how to build a CMake project. They may specify the build targets and the configuration for multi-configuration toolchains such as MSVC or ninja-multi.
* **Test **presets**describe the environment and conditions for running tests. They may specify the test executable and the test filter.
* **Package presets**: describe how to package a CMake project. They may specify the package type and the package destination.
* **Workflow presets**: describe a sequence of actions to be executed. They may specify the presets to be executed and the order in which they are executed.

While Test-, Package- and Workflow-presets are useful, in this article we will focus on organizing the configure and build presets as they are the most important ones for building the project. For the full documentation on CMake presets see the [official CMake documentation](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html). 

{% include cmake-best-practices-ad.html %}

# Organizing CMake presets

As projects grow, especially when they are cross-platform, the number of CMake presets can grow quickly. This can make it hard to keep track of them and to find the right one. To keep things organized, it is a good idea to get some organization into the presets, so it is easy to find the right preset for the platform and compiler you are using.

I generally recommend having presets for each compiler and platform and combining them by using further presets. This makes it easy to find the right preset and to keep the individual presets small and simple. I tend to use a naming scheme like this: `<ci>-<generator>-<toolchain>-<buildType>` where the prefix is either `ci` or `dev` depending on whether the preset is intended for CI or local development. Generally, all `ci` presets are located in the `CMakePresets.json` and are checked in, while `dev` presets tend at least partially to come from the `CMakeUserPresets.json`. 
The generator is the CMake generator, the toolchain is a combination of the platform, compiler and operating system like `clang12-armv7-linux` and the build type is the build type. For multi-configuration generators like MSVC or ninja-multi, the build type is omitted and configured over build presets. 

{%include figure.html url="images/cmake-presets/Preset-Organisation.drawio.png" description="Example scheme how to organize presets for single configuration compilers"%}

Some example configuration presets that I use frequently in my projects are `ci-ninja-x86_64-linux-debug`, `ci-ninja-x86_64-linux-release`, `ci-msvc19-x86_64-windows`. Note that the msvc preset does not specify the build type as it is a multi-configuration generator and thus the build type is configured in the build preset. 

It is good practice to mark any presets that should not be used to build the project standalone as `hidden`. This makes it easy to find the presets that are intended to be used. Generally I recommend to mark only presets that have the full definition of prefix, generator, toolchain and build type as visible. 

## Configuration Presets in detail

So what goes into which presets. A typical preset for my CMake projects contains the following presets.  

* **Standalone presets**: These can be aggregated with almost any other combination of presets. They do not define a build directory or a generator. They are all marked `hidden` and are intended to be used in other presets. Most of them are either defining cache variables or environment variables.
  * ccache-env (hidden): A preset that defines some environment variables for ccache. This is used in CI and dev builds where ccache is used to speed up the build.
  * clang-tidy (hidden): A preset that defines the clang-tidy checks to be used. This is used mainly in CI builds where clang-tidy is used to check the code.
 *  [iwyu](https://include-what-you-use.org/): A preset that defines the include-what-you-use checks to be used. This is used mainly in CI builds where include-what-you-use is used to check the code.
*  **Generator presets**: These presets define the generator and the build directory. I usually also keep them `hidden` and use them in other presets.
   *  Ninja: My generator of choice when building for linux and mac. This preset defines the build directory and the generator.
   *  MSVC: for building on windows
   *  Any other generator required to build on other platforms
* **Toolchain presets**: These contain specific compiler versions and flags. These presets are also marked `hidden` and are used in other presets. They might also contain library locations such as for Qt or Boost. I often prefix them with either `ci` if they contain information that is specific for the ci environment or the [devcontainer](https://dominikberner.ch/using-devcontainers-with-cpp/) bundled with the project. These might (re-)define the build directory. 
  * gcc-flags: Defines the flags for gcc and clang such as `-Wall -Werror`
  * msvc-flags: Defines the flags for MSVC such as `/W4 /WX`
  * clang-sanitizer: Defines the flags for clang sanitizer such as `-fsanitize=address`
  * msvc-sanitizer: Defines the flags for MSVC sanitizer such as `/fsanitize=address`
  * android-ndk: Defines the toolchain file for the android ndk
  * Qt-5.15.2: Defines the location of the Qt libraries of a specific version
  * ... and more depending on the complexity and size of the project
* **build-type presets**: Defines the build type for single configuration presets. In addition to the default Debug, Release and RelWithDebInfo, I sometimes add coverage build types here. Usually they define only cache variables. 
   
   




The downside is that this can lead to a lot of presets to manage, so it might be helpful to split these up into multiple files and use includes to manage them.