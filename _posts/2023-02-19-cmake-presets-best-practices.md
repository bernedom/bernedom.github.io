--- 
layout: post
tags: cmake
title: Organizing CMake presets
description: CMake presets are a big help in how to configure CMake. This article shows how to set up and organize them.
image: /images/cmake-logo.png
hero_image: /images/cmake-logo.png
hero_darken: true
tags: cmake
--- 

**[CMake presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html) are arguably one of the biggest improvements in CMake since the introduction of targets in 2014.** In a nutshell, CMake presets contain information on how to configure, build, test and package a CMake project and they are a tremendous help when managing different configurations for various compilers and platforms. Instead of fiddling with various command-line options, presets are stored in a JSON file and can be used to configure CMake with a single command. This article shows how to set up and organize and use them so they are most effective and easy to maintain. 

# CMake presets in a nutshell

CMake presets were introduced to CMake with version 3.19, if you are using an older version I strongly recommend updating to a newer version, even if it is just for the sake of being able to use presets. As of early 2023, the built-in support in editors and IDEs for CMake presets is still in its infancy, but there is a noticeable push to accommodate them in most tools. 

{% include cmake-best-practices-ad.html %}

As mentioned earlier, CMake presets are a way to store information on how to configure, build, test and package a CMake project. The various presets are stored in JSON files that are named `CMakePresets.json` or `CMakeUserPresets.json` and are placed in the root of a CMake project. The former is intended to be checked into version control and the latter is intended to contain system-specific information for each individual user. Various types of presets describe the different steps of building a CMake project: 

* **Configure presets**: describe how to configure a CMake project. They specify the generator, toolchain file, CMake cache variables and the build directory among other options.
* **Build presets**: describe how to build a CMake project. They may specify the build targets and the configuration for multi-configuration toolchains such as MSVC or ninja-multi.
* **Test presets** describe the environment and conditions for running tests. They may specify the test executable and the test filter.
* **Package presets**: describe how to package a CMake project. They may specify the package type and the package destination.
* **Workflow presets**: describe a sequence of actions to be executed. They may specify the presets to be executed and the order in which they are executed.

The structure of a CMake preset file is as follows:

```json
{
    "version": 3,
    "cmakeMinimumRequired": {
        "major": 3,
        "minor": 21,
        "patch": 0
    },
    "configurePresets": [
        {
            // ...
        },
        {
            // ...
        },
        // Add more presets here
    ],
    "buildPresets": [
        {
         // ...
        },
        // ...
    ],
    "testPresets": [
        {
           //  ...
        },
        // ...
    ]

}
```

The command to configure a project using a preset is `cmake --preset <preset-name>` and to build with a preset use `cmake --build --preset <preset-name>`. 
Test presets can be invoked over CTest by using `ctest --preset <preset-name>` or with CMake with  `cmake --build --preset <preset-name> --target test`.
Unfortunately the `cpack` command line utility so far lacks preset support, so to package with a preset CMake has to be used: `cmake --build --preset <preset-name> --target package`.

While Test-, Package- and Workflow-presets are useful, in this article I will focus on organizing the configure- and build-presets as they are the most frequently used. For the full documentation on CMake presets see the [official CMake documentation](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html). 

# Organizing CMake presets

As projects grow - especially when they are targetet at multiple platforms - the number of CMake presets can grow quickly. This can make it hard to keep track of them and find the right one. To keep things organized, it is a good idea to get some organization into the presets, so it is easy to find the right preset for the platform and compiler you are using.

I generally recommend having presets for each compiler and platform and combining them by inheriting from them in further presets. This makes it easy to find the right preset and to keep the individual presets small and simple. I tend to use a naming scheme like this: `<ci>-<generator>-<toolchain>-<buildType>` where the prefix is either `ci` or `dev` depending on whether the preset is intended for CI or local development. Generally, all `ci` presets are located in the `CMakePresets.json` and are checked in, while `dev` presets tend at least partially to come from the `CMakeUserPresets.json`. Where they go is also dependent if it is a public project or not. Presets for public projects should be as generic as possible and not contain any information that is specific to a user or a CI environment, while in a project inside a company the presets might be more specific for a bit of extra convenience.
The generator is the CMake generator, the toolchain is a combination of the platform, compiler and operating system like `clang12-armv7-linux` and the build type is the build type. For multi-configuration generators like MSVC or ninja-multi, the build type is omitted and configured over build presets. 

{%include figure.html url="images/cmake-presets/Preset-Organisation.drawio.png" description="Example scheme how to organize presets for single configuration compilers"%}

Some example configuration presets that I use frequently in my projects are `ci-ninja-x86_64-linux-debug`, `ci-ninja-x86_64-linux-release`, `ci-msvc19-x86_64-windows`. Note that the MSVC preset does not specify the build type as it is a multi-configuration generator and thus the build type is configured in the build preset. 

It is good practice to mark any presets that should not be used to build the project standalone as `hidden`. This makes it easy to find the presets that are intended to be used. Generally, I recommend marking only presets that have the full definition of generator, toolchain and build type as visible. 

## Configuration Presets in detail

So what goes into which presets? A typical example for many of my CMake projects contains the following presets.

* **Standalone presets**: These can be aggregated with almost any other combination of presets. They do not define a build directory or a generator. They are all marked `hidden` and are intended to be used in other presets. Most of them are either defining cache variables or environment variables.
  * ccache-env (hidden): A preset that defines some environment variables for ccache. This is used in CI and dev builds where ccache is used to speed up the build.
  * clang-tidy (hidden): A preset that defines the clang-tidy checks to be used. This is used mainly in CI builds where clang-tidy is used to check the code.
  * [iwyu](https://include-what-you-use.org/) (hidden): A preset that defines the include-what-you-use checks to be used. This is used mainly in CI builds where include-what-you-use is used to check the code.
*  **Generator presets**: These presets to define the generator and the build directory. I usually also keep them `hidden` and use them in other presets.
   *  Ninja: My generator of choice when building for Linux and mac. This preset defines the build directory and the generator.
   *  MSVC: for building on windows
   *  Any other generator required to build on other platforms
* **Toolchain presets**: These contain specific compiler versions and flags. These presets are also marked `hidden` and are used in other presets. They might also contain library locations such as for Qt or Boost. I often prefix them with either `ci` if they contain information that is specific to the ci environment or the [devcontainer](https://softwarecraft.ch/using-devcontainers-with-cpp/) bundled with the project. These might (re-)define the build directory. 
  * gcc-flags: Defines the flags for gcc and clang such as `-Wall -Werror`
  * msvc-flags: Defines the flags for MSVC such as `/W4 /WX`
  * clang-sanitizer: Defines the flags for clang sanitizer such as `-fsanitize=address`
  * msvc-sanitizer: Defines the flags for MSVC sanitizer such as `/fsanitize=address`
  * android-ndk: Defines the toolchain file for the android ndk
  * Qt-5.15.2: Defines the location of the Qt libraries of a specific version
  * ... and more depending on the complexity and size of the project
* **build-type presets**: Defines the build type for single configuration presets. In addition to the default Debug, Release and RelWithDebInfo, I sometimes add coverage build types here. Usually, they define only cache variables or set options. For multi-config generators, I move the relevant information into the build presets.


<details>
<summary markdown="span">
An example `CMakePresets.json` to build a Qt project for linux, windows, android and webassembly might look like this (Click to expand). 
Note that this particular example does contain some file paths that are specific to the CI setup. To easily replicate build environments I recommend using [devcontainers](https://softwarecraft.ch/using-devcontainers-with-cpp/). This particular setup does only contain configure and build presets. 

</summary>

```json
{
    "version": 3,
    "cmakeMinimumRequired": {
        "major": 3,
        "minor": 21,
        "patch": 0
    },
    "configurePresets": [
        {
            "name": "ccache-env",
            "hidden": true,
            "environment": {
                "CCACHE_BASEDIR": "${sourceDir}",
                "CCACHE_SLOPPINESS": "pch_defines,time_macros"
            }
        },
        {
            "name": "emscripten",
            "hidden": true,
            "cacheVariables": {
                "CMAKE_EXE_LINKER_FLAGS_INIT": "-s WASM=1 -s USE_SDL"
            },
            "environment": {
                "CXX": "/opt/emsdk/emscripten/1.38.30/em++",
                "CC": "/opt/emsdk/emscripten/1.38.30/emcc"
            },
            "toolchain:": "emscripten",
            "binaryDir": "${sourceDir}/build_wasm"
        },
        {
            "name": "verbose-debug-output",
            "hidden": true,
            "cacheVariables": {
                "EXTENDED_DEBUG_OUTPUT_ENABLED": "ON"
            }
        },
        {
          "name": "qt-webassembly",
          "hidden": true,
          "cacheVariables": {
            "CMAKE_PREFIX_PATH": "/opt/Qt/5.14.1/android_wasm/",
            "CMAKE_FIND_ROOT_PATH_MODE_PACKAGE": "BOTH",
            "CMAKE_FIND_ROOT_PATH_MODE_LIBRARY": "BOTH",
          },

        },
        {
            "name": "android",
            "hidden": true,
            "toolchainFile": "/opt/android-ndk/build/cmake/android.toolchain.cmake",
            "cacheVariables": {
                "ANDROID_ABI": "armeabi-v7a",
                "ANDROID_PLATFORM": "23",
                "ANDROID_SDK": "/opt/android-sdk",
                "CMAKE_FIND_ROOT_PATH_MODE_PACKAGE": "BOTH",
                "CMAKE_FIND_ROOT_PATH_MODE_LIBRARY": "BOTH",
                "CMAKE_FIND_ROOT_PATH_MODE_INCLUDE": "BOTH",
                "OPENSSL_ROOT_DIR": "/opt/android_libs"
            },
            "environment": {
                "JAVA_HOME": "/usr/lib/jvm/java-1.8.0-openjdk-amd64",
                "ANDROID_SDK_ROOT": "/opt/android-sdk",
                "ANDROID_NDK_ROOT": "/opt/android-sdk"
            },
            "binaryDir": "${sourceDir}/build_android"
        },
        {
            "name": "Qt-desktop",
            "hidden": true,
            "cacheVariables": {
                "CMAKE_PREFIX_PATH": "/opt/Qt/5.14.1/gcc_64/"
            },
            "binaryDir": "${sourceDir}/build"
        },
        {
            "name": "Qt-android",
            "hidden": true,
            "cacheVariables": {
                "CMAKE_PREFIX_PATH": "/opt/Qt/5.14.1/android/"
            }
        },
        {
            "name": "ci-ninja",
            "displayName": "Ninja",
            "description": "build using Ninja generator",
            "inherits": [
                "ccache-env"
            ],
            "generator": "Ninja",
            "hidden": true
        },
        {
            "name": "ci-ninja-debug",
            "displayName": "Ninja Debug",
            "inherits": [
                "Qt-desktop",
                "ci-ninja",
                "verbose-debug-output"
            ],
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Debug"
            }
        },
        {
            "name": "ci-ninja-wasm-debug",
            "displayName": "Ninja Webassembly Debug",
            "inherits": [
                "ci-ninja",
                "qt-webassembly",
                "emscripten"                
            ],
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Debug"
            }
        },
        {
            "name": "ci-ninja-debug-unittest",
            "displayName": "Ninja Debug for Unit Tests",
            "inherits": [
                "Qt-desktop",
                "ci-ninja",
                "verbose-debug-output"
            ],
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Debug"
            }
        },
        {
            "name": "ci-ninja-release",
            "displayName": "Ninja Release",
            "inherits": [
                "Qt-desktop",
                "ci-ninja"
            ],
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Release"
            }
        },
        {
            "name": "ci-ninja-android-debug",
            "displayName": "Ninja Android Debug",
            "inherits": [
                "Qt-android",
                "ci-ninja",
                "android",
                "verbose-debug-output"
            ],
            "cacheVariables": {
                "CMAKE_BUILD_TYPE": "Debug"
            }
        },
        {
            "name" : "ci-windows-msvc2017",
            "displayName": "MSVC 2017",
            "generator" : "Visual Studio 15 2017",
            "binaryDir": "${sourceDir}/build",
            "condition": {
                "type": "equals",
                "lhs": "${hostSystemName}",
                "rhs": "Windows"
            }

        },
    ],    
    "buildPresets": [
        {
            "name": "ci-msvc2017-debug",
            "displayName" : "MSVC 2017 Debug",
            "configurePreset" : "ci-windows-msvc2017",
            "configuration": "Debug",
            "condition": {
                "type": "equals",
                "lhs": "${hostSystemName}",
                "rhs": "Windows"
            }
        },
        {
            "name": "ci-msvc2017-release",
            "displayName" : "MSVC 2017 release",
            "configurePreset" : "ci-windows-msvc2017",
            "configuration": "Release",
            "condition": {
                "type": "equals",
                "lhs": "${hostSystemName}",
                "rhs": "Windows"
            }
        }
    ],
}

```

</details>

Overall this setup usually gives me a very good mix of being open enough to be used in different environments and specific enough to be conveniently useful. The downside is that this can lead to a lot of presets to manage, so it might be helpful to split these up into multiple files and use includes to manage them.

## Presets in real life

in my opinion CMake presets are one of the most powerful features of CMake and a great addition to the tool. Especially if you're working with an editor or IDE that supports them natively it reduces the complexity of using CMake drastically as I no longer have to memorize the specific options and flags for each project. Presets are also a great way to keep the `CMakeLists.txt` clean and agnostic the build environment. By having the presets the temptation to put specific compiler flags or other environment-specific information into the `CMakeLists.txt` is greatly reduced - which is a very good thing when it comes to maintainability. The downside is of course that the complexity handling of multi-platform projects is not reduced but just shifted to a different file and that one now has to manage not just the `CMakeLists.txt` but also the preset files. 

Overall I think that the benefits of using CMake presets outweigh the downsides and I would recommend using them in every project - whether you follow my strategy for organizing them or find your own way to do it.






