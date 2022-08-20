---
layout: post
title: CMake line by line - creating a header-only library
thumbnail: images/cmake-logo.png
---

**CMake can be hard to figure out.** I love CMake, but unfortunately, its documentation is more focused on completeness than on providing hands-on-examples. Since I found it hard to find a comprehensive example of how a header-only library can be set up, I decided to provide an example of a CMakeLists.txt file for such a library here and analyze it line by line. The example is taken from [SI, a header-only library that provides strongly typed physical units](https://github.com/bernedom/SI).
In order to keep the CMake file as small as possible, a few possible optimizations are omitted. Notably, I stripped any information relating to testing out of the project.

{% include cmake-best-practices-ad.html %}

# Using a header-only library 

The usage of our header-only library should be as simple as calling `find_package` and then using `target_link_library` on it. See [here for a full example](https://github.com/bernedom/SI/blob/master/test/installation-tests/CMakeLists.txt)

# Overview

In order to make the interface library usable, the following things have to be done. 

1. Set up the cmake project
1. Define the library to be built as a header-only library and adding files
1. Define installation properties
1. Specify which files to copy into the installation directory

<details>
<summary markdown="span">
For a quick overview: Click here to expand the full CMakeLists.txt
</summary>

```cmake
cmake_minimum_required(VERSION 3.12)

project(
  "SI"
  VERSION 1.0.1
    DESCRIPTION
    "A header-only c++ library that provides type safety and user defined literals for handling pyhsical values defined in the International System of Units."
    HOMEPAGE_URL  "https://github.com/bernedom/SI")

include(GNUInstallDirs)

add_library(SI INTERFACE)

# Adding the install interface generator expression makes sure that the include
# files are installed to the proper location (provided by GNUInstallDirs)
target_include_directories(
  SI
  INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_compile_features(SI INTERFACE cxx_std_17)

enable_testing()
add_subdirectory(test)

# locations are provided by GNUInstallDirs
install(TARGETS SI
        EXPORT SI_Targets
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

include(CMakePackageConfigHelpers)
write_basic_package_version_file("SIConfigVersion.cmake"
                                 VERSION ${PROJECT_VERSION}
                                 COMPATIBILITY SameMajorVersion)

configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/cmake/SIConfig.cmake.in"
  "${PROJECT_BINARY_DIR}/SIConfig.cmake"
  INSTALL_DESTINATION
  ${CMAKE_INSTALL_DATAROOTDIR}/SI/cmake)

install(EXPORT SI_Targets
        FILE SITargets.cmake
        NAMESPACE SI::
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/SI/cmake)

install(FILES "${PROJECT_BINARY_DIR}/SIConfig.cmake"
              "${PROJECT_BINARY_DIR}/SIConfigVersion.cmake"
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/SI/cmake)

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/SI DESTINATION include)
```
</details>

# Setting up the project 

The first line of all CMake files is the minimum required version. Here I used version `3.12` Generally I try to pick the lowest version number that supports all the features I'm using. As SI is using C++17 features, I chose 3.12 because it supplies the necessary keywords and allows to define targets without specifying the source files upfront.

```cmake
cmake_minimum_required(VERSION 3.12)
```

The next line denotes the name of the project `"SI"` in our case and the version (1.0.1) of the package. Generally, usage of [semantic versioning](https://semver.org/) is recommended. Then there is a package description and the link to the project homepage, which is the github repo in this case.

```cmake
project("SI" VERSION 1.0.1
             DESCRIPTION "A header-only c++ library that provides type safety and user defined literals for handling pyhsical values defined in the International System of Units."
             HOMEPAGE_URL "https://github.com/bernedom/SI")
```

Since this library will be platform independent but still be installable following best practices, before we wet anything up, we include [`GNUInstallDirs`](https://cmake.org/cmake/help/latest/module/GNUInstallDirs.html) (included in CMake) which will provide us with a set of variables containing installation directories for various artifacts. The variables will be used later. 

```cmake
include(GNUInstallDirs)
```  

# Defining how to "build" the header-only library

`add_library` tells CMake that we want to build a library and to set up the [logical target](https://cmake.org/cmake/help/v3.14/manual/cmake-buildsystem.7.html) with the name *SI*. The target name is important to remember, as all further options for building and installing are tied to it. The [keyword `INTERFACE`](https://cmake.org/cmake/help/v3.14/manual/cmake-buildsystem.7.html#interface-libraries) makes our target a header-only library that does not need to be compiled. 

```cmake
add_library(SI INTERFACE)
```

So far the target of the library is set up, but it does not contain any files yet. `target_inlcude_directories` lets us add them. The first parameter `SI` is again the target name, next the keyword `INTERFACE` tells CMake that the files are to be exposed in the library interface, which means they are publicly visible when using the library. What follows is a list of include directories wrapped in [generator expressions](https://cmake.org/cmake/help/v3.14/manual/cmake-generator-expressions.7.html#manual:cmake-generator-expressions(7)). The Generator expressions are evaluated at the time when the build system is generated and allowed to have different values for when the library is used directly over CMake or when it is installed. 

`$<BUILD_INTERFACE:SI_SOURCE_DIR}/include>` tells CMake that if the library is used directly by another CMake target (such as when building tests for the library or when it is included as a subdirectory), then the include path is `${PROJECT_SOURCE_DIR}/include}` which is a nested variable. `${CMAKE_CURRENT_SOURCE_DIR}` contains an automatically generated variable that points to the directory in which the CMakeLists.txt that is currently passed lies. This expands to `/directory/that/contains/CmakeList.txt/include`

`$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>` defines the path if the project is installed. The paths are relative to the install-root chosen when installing projects. The variable `CMAKE_INSTALL_INCLUDEDIR` is provided by the `GNUInstallDirs` package included above. The target path for installation can be set by setting the `CMAKE_INSTALL_PREFIX` variable. 

```cmake
target_include_directories(
  SI
  INTERFACE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
```

As the code of the SI-library uses some features of the C++17 standard, this dependency is passed along using `target_compile_features`. This specifies compiler features to be enabled in a compiler-agnostic way. Again the target is the by now familiar `SI` and the keyword `INTERFACE` again marks this feature to be exposed and required when using the library. `cxx_std_17` is the catch-all feature to enable the whole C++17 standard, here individual features such as use of `constexpr` or `auto` could also be specified. 

If a compiler does not support the specified feature, building the library will fail. 

```cmake
target_compile_features(SI INTERFACE cxx_std_17)
```

# Installation instructions
By this point, the project itself is set up and can be built locally. However, it cannot yet be installed in the system. For this, we specify where to install by using the [`install` command](https://cmake.org/cmake/help/latest/command/install.html).

First CMake needs to know which targets to install so the library target is passed as `TARGETS SI`. 
The `EXPORT` associates the installation with an export-form named `${PROJECT_NAME}_Targets`, built using the variable `${PROJECT_NAME}` that contains the project name. This export is defined later in an `install(EXPORT...)` call. 
 
Next, the folders for the installation artifacts are set. The folder names are relative to what the user defines in the `CMAKE_INSTALL_PREFIX` variable.

* `ARCHIVE` - All files that are neither executables, shared libraries (.so), header files. 
* `LIBRARY` - All shared libraries (.so/.dll) files, typically all binaries produced by a call to `add_library`
* `RUNTIME` - All executables built by an `add_excutable` call
* `INCLUDE` - All public header files, which is omitted here because the `INSTALL_INTERFACE` already specifies this.

The target paths are again provided by `GNUInstallDirs`

```cmake
install(TARGETS SI
        EXPORT ${PROJECT_NAME}_Targets
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
```

The next two lines are a shortcut to avoid having to write the boilerplate CMake code to manage version comparison. First, the CMake package containing the macros parsing versions is included. This is delivered with the standard CMake installations since 3.5. Then the macro `write_basic_package_version_file` is called and instructed to create a file `SIConfigVersion.cmake`. The version specified is the one supplied in the `project` directive at the beginning of the file and since semantic versioning is used versions of the same major digit are considered compatible. 

```cmake
include(CMakePackageConfigHelpers)
write_basic_package_version_file("SIConfigVersion.cmake"
                                 VERSION ${PROJECT_VERSION}
                                 COMPATIBILITY SameMajorVersion)
```

After setting up the version, another CMake macro `configure_package_config_file` is called, to generate the configuration file which CMake uses for using an installed package.
<details>
<summary markdown="span">
 The content of the input file `SIconfig.cmake.in` (It's quite simple). 
</summary>

```cmake
@PACKAGE_INIT@

include("${CMAKE_CURRENT_LIST_DIR}/@PROJECT_NAME@Targets.cmake")
check_required_components("@PROJECT_NAME@")
```

</details>

All the placeholders marked with `@` in the input file are replaced with the explicit values and the file is written to the target `.cmake` file. 
By specifying `INSTALL_DESTINATION` CMake is told where to place it when creating the installation artifact. Usually these go to `/usr/share` or similar, but since the exact path is provided by `GNUInstallDirs` we do not have to care. The `${PROJECT_NAME}` variables are placeholders and contain the name specified in the call to `project()`.

```cmake
configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION
  ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)
```

## Selecting targets and files to install

After setting up the configuration for installing the library, the files to be installed can be passed to CMake by using the `install` function. 

First, the file containing the installation targets as defined above is created and copied to the installation folder. The `EXPORT` keyword at the beginning tells CMake to export the installation targets which are defined in the file `SITargets.cmake` which is created in the build folder when building the project to the `DESTINATION` specified. All targets are to be placed in the `NAMESPACE` `SI::`.

```cmake
install(EXPORT ${PROJECT_NAME}_Targets
        FILE ${PROJECT_NAME}Targets.cmake
        NAMESPACE ${PROJECT_NAME}::
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)
```

The created `.cmake` files containing the build configuration and information about version compatibility are to be installed to the install folder as well. By providing the `FILES` keyword a list of files is given to be saved in a folder specified by `DESTINATION`. 

```cmake
install(FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
              "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME}/cmake)
```

Finally, the header files are copied to the installation folder. For header-only libraries usually, all header files are supplied, so instead of providing individual files, the whole include directory is copied using the `DIRECTORY` keyword. 

```cmake
install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/SI DESTINATION include)
```

## Installation and usage

After setting all up the library can be built and installed like this:

```bash
cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/your/installation/path
cmake --build . --config Release --target install -- -j $(nproc)
```

For using it, use:

```cmake
project("SI-Example")

find_package(SI CONFIG REQUIRED)

add_executable(SI-example src/main.cc)
target_link_libraries(SI-example SI::SI)

```

[the CMake file of the SI library at the time of writing](https://github.com/bernedom/SI/blob/9342c4109f924f33e139a25bf20f6ebaeabab10d/CMakeLists.txt)
