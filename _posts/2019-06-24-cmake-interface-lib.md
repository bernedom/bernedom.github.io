---
layout: post
title: Cmake line by line - header only library
thumbnail: images/cmake-logo.png
---

**Cmake can be hard to figure out.** I love cmake, but unfortunately its documentation is more focused on completeness than on providing hands-on-examples. Since I found it hard to find a comprehensive example of how a header only library can be set up, I decided to provide an example of a CMakeLists.txt file for such a library here and analyze it line by line. The example is taken from [SI, a header only library that provides strongly typed physical units](https://github.com/bernedom/SI).
In order to keep the cmake file as small as possible, few possible optimizations are omitted. Notably I stripped any information relating to testing out of the project.

# Using a header only library 

The usage of our header only library should be as simple as calling `find_package` and then using `target_link_library` on it. See [here for a full example](https://github.com/bernedom/SI/blob/master/example/CMakeLists.txt)

# Overview

In order to make the interface library usable, the following things have to be done. 

1. Set up the cmake project
1. Define the library to be built as a header only library and adding files
1. Define installation properties
1. Specify which files to copy into the installation directory

<details>
<summary markdown="span">
As an overview: Click here to expand the full CMakeLists.txt
</summary>

```cmake
cmake_minimum_required(VERSION 3.8)

project("SI" VERSION 0.0.4)

add_library(${PROJECT_NAME} INTERFACE)

target_include_directories(
  ${PROJECT_NAME}
  INTERFACE $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:include>)

target_compile_features(${PROJECT_NAME} INTERFACE cxx_std_17)

enable_testing()
add_subdirectory(test)

install(TARGETS ${PROJECT_NAME}
        EXPORT ${PROJECT_NAME}_Targets
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES
        DESTINATION include)

include(CMakePackageConfigHelpers)
write_basic_package_version_file("${PROJECT_NAME}ConfigVersion.cmake"
                                 VERSION ${PROJECT_VERSION}
                                 COMPATIBILITY SameMajorVersion)

configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/cmake/SIConfig.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION
  lib/cmake/${PROJECT_NAME})

install(EXPORT ${PROJECT_NAME}_Targets
        FILE ${PROJECT_NAME}Targets.cmake
        NAMESPACE ${PROJECT_NAME}::
        DESTINATION lib/cmake/${PROJECT_NAME})

install(FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
              "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        DESTINATION lib/cmake/${PROJECT_NAME})

install(DIRECTORY ${PROJECT_SOURCE_DIR}/include/SI DESTINATION include)
```
</details>

# Setting up the project 

The first line of all cmake files is the minimum required version. Here version `3.8.` Generally I try to pick the lowest version number that supports all the features I'm using. As SI is using C++17 features, I chose 3.8 because it supplies the necessary keywords.

```cmake
cmake_minimum_required(VERSION 3.8)
```

The next line denotes the name of the project `"SI"` in our case and the version (0.0.4) of the package. Generally usage of [semantic versioning](https://semver.org/) is recommended.

```cmake
project("SI" VERSION 0.0.4)
```

# Defining how to "build" the header-only library

`add_library` tells cmake that we want to build a library and to set up the [logical target](https://cmake.org/cmake/help/v3.14/manual/cmake-buildsystem.7.html).  Good practice is to use the project name as a variable `${PROJECT_NAME}` as the name for the library/target for consistency reasons. The target-name is important to remember, as all further options for building and installing are tied to it. The [keyword `INTERFACE`](https://cmake.org/cmake/help/v3.14/manual/cmake-buildsystem.7.html#interface-libraries) makes our target a header only library that does not need to be compiled. 

```cmake
add_library(${PROJECT_NAME} INTERFACE)
```

So far the target of the library is set up, but it does not contain any files yet. `target_inlcude_directories` lets us add them. The first parameter `${PROJECT_NAME}` is again the variable containing or project name "SI", next the keyword `INTERFACE` tells cmake that the files are to be exposed in the library interface, which means they are publicly visible when using the library. What follows is a list of include directories wrapped in [generator expressions](https://cmake.org/cmake/help/v3.14/manual/cmake-generator-expressions.7.html#manual:cmake-generator-expressions(7)). The Generator expressions are evaluated at the time when the build system is generated and allow to have different values for when the library is used directly over cmake or when it is installed. 

`$<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>` tells cmake that if the library is used directly by another cmake target (such as when building tests for the library or when it is included as a sub directory), then the include path is `${${PROJECT_NAME}_SOURCE_DIR}/include}` which is a nested variable. `${${PROJECT_NAME}_SOURCE_DIR}` contains an automatically generated variable which points to the directory in which the CMakeLists.txt lies that contains the `project()` call. This expands to `/directory/where/CmakeList.txt/is/include`

`$<INSTALL_INTERFACE:include>` defines the path if the project is installed. The paths are relative to the install-root chosen when installing projects. The target path for installation can be set by setting the `CMAKE_INSTALL_PREFIX` variable. 

```cmake
target_include_directories(
  ${PROJECT_NAME}
  INTERFACE $<BUILD_INTERFACE:${${PROJECT_NAME}_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:include>)
```

As the code of the SI-library uses some features of the C++17 standard, this dependency is passed along using `target_compile_features`. This specifies compiler features to be enabled in a compiler-agnostic way. Again the target is the by now familiar `${PROJECT_NAME}` and the keyword `INTERFACE` again marks this feature to be exposed and required when using the library. `cxx_std_17` is the catch-all feature to enable the whole C++17 standard, here individual features such as use of `constexpr` or `auto` could also be specified. 

If a compiler does not support the specified feature, building the library will fail. 


```cmake
target_compile_features(${PROJECT_NAME} INTERFACE cxx_std_17)
```

# Installation instructions

By this point the project itself is set up an can be built locally. However it cannot yet be installed to the system. For this we specify where to install by using the [`install` command](https://cmake.org/cmake/help/latest/command/install.html).

First cmake needs to know which targets to install `TARGETS ${PROJECT_NAME}`, again using the variable `${PROJECT_NAME}` to the target to install. 
The`EXPORT` associates the installation with an export-form named `SI_Targets`, built again using the variable. This export is defined later in an `install(EXPORT...)` call. 
 
Next the folders for the installation-artifacts are set. The folder names are relative to what the user defines in the `CMAKE_INSTALL_PREFIX` variable.

* `ARCHIVE` - All files that are neither executables, shared libraries (.so), header files or executables. 
* `LIBRARY` - All shared libraries (.so/.dll) files, tyically all binaries produced by a `add_library` call
* `RUNTIME` - All executables built by an `add_excutable` call
* `INCLUDE` - All public header files. For our header only library these are all files. 
  
 Technically for a header only library only the `INCLUDES` would be needed, but it is good practice to supply the other locations as well. 

```cmake
install(TARGETS ${PROJECT_NAME}
        EXPORT ${PROJECT_NAME}_Targets
        ARCHIVE DESTINATION lib
        LIBRARY DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION include)
```

The next two lines are a shortcut to avoid having to write the boilerplate cmake code to manage version comparison. First the cmake package containing the macros parsing versions is included. This is deliverd with the standard cmake installations since 3.5. Then the macro `write_basic_package_version_file` is called and instructed to create a file `SIConfigVersion.cmake`. The version specified is the one supplied in the `project` dierective at the beginning of the file and since semantic versioning is used versions of the same major digit are considerd compatible. 

```cmake
include(CMakePackageConfigHelpers)
write_basic_package_version_file("${PROJECT_NAME}ConfigVersion.cmake"
                                 VERSION ${PROJECT_VERSION}
                                 COMPATIBILITY SameMajorVersion)
```

After setting up the version, another cmake macro `configure_package_config_file` is called, to generate the configuration file which cmake uses for using an installed package.
<details>
<summary markdown="span">
 The content of the input file `SIconfig.cmake.in` is quite simple. 
</summary>

```cmake
@PACKAGE_INIT@

include("${CMAKE_CURRENT_LIST_DIR}/@PROJECT_NAME@Targets.cmake")
check_required_components("@PROJECT_NAME@")
```

</details>

All the placeholders marked with `@` in the input file are replaced with the explicit values and the file is written to the target `.cmake` file. 
By specifying `INSTALL_DESTINATION` cmake is told where to place it when creating the installation artifact.

```cmake
configure_package_config_file(
  "${PROJECT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in"
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION
  lib/cmake/${PROJECT_NAME})
```

## Selecting targets and files to install

After setting up the configuration for installing the library, the files to be installed can be passed to cmake by using the `install` function. 

First the file containing the installation-targets as defined above, is created and copied to the installation folder. The `EXPORT` keyword at the beginning tells cmake to export the installation targets which are defined in the file `SITargets.cmake` which is created in the build folder when building the project to the `DESTINATION` specified. All targets are to be placed in the `NAMESPACE` `SI::`.

```cmake
install(EXPORT ${PROJECT_NAME}_Targets
        FILE ${PROJECT_NAME}Targets.cmake
        NAMESPACE ${PROJECT_NAME}::
        DESTINATION lib/cmake/${PROJECT_NAME})
```

The created `.cmake` files containing the build configuration and informartion about version compatibilty are to be installed to the install folder as well. By providing the `FILES` keyword a list of files is given to be saved in a folder specified by `DESTINATION`. 

```cmake
install(FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
              "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        DESTINATION lib/cmake/${PROJECT_NAME})
```

Finally the header files are copied to the installation folder. For header only libraries ususally all header files are supplied, so instead of providing individual files the whole include directory is copied using the `DIRECTORY` keyword. 

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

add_executable(${PROJECT_NAME} src/main.cc)
target_link_libraries(${PROJECT_NAME} SI::SI)

```

[the cmake file of the SI library at the time of writing](https://github.com/bernedom/SI/blob/18586fcc0efc269dd2014c7fcf52838e9068558b/CMakeLists.txt)
