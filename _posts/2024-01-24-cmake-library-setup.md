---
layout: post
title: CMake line by line - Creating a library
description: "How to set up a library with CMake, including proper symbol visibility and installation"
thumbnail: images/cmake-logo.png
---

**Creating a clean library that has proper symbol visibility and installation instructions might sound difficult.** However with CMake it is relatively straight forward to set up, even if there are a few things to consider. Actually creating creating a library is as simple as invoking the `add_library()` command and adding the sources to it. When it comes to setting up the installation instructions and symbol visibility properly there is a bit more to it. There are also some small, but useful things like defining the version compatibility of the library that make the life of developers a lot easier if done properly. 

In this post, we will go through the steps to create a library with CMake, including proper symbol visibility and installation. All the code for this post is available as [a template on GitHub](https://github.com/bernedom/CMake_Library_Template)

## Creating a library with CMake - A quick overview

When configuring for a library with CMake we need to do the following things:

1. Creating the library and adding the sources to it
2. Setting version compatibility
3. Specifying which include files are public and private
4. Setting symbol visibility and creating an export header
5. Defining where to install the library and make it usable with `find_package()`
6. Some miscellaneous things like setting the C++ standard and debug suffix

For detailed documentation on the commands used in this post, please refer to the [CMake documentation](https://cmake.org/cmake/help/latest/).

{% include cmake-best-practices-ad.html %}

## Setting up the project

Choosing the right file structure for a project is always important as it makes it easier to find files and helps to keep the project organized. For libraries it is even more important, as others will want to use the library as well. Usually, not all files needed to build a library are necessary to use the library, so a clean separation helps to only install the files that are needed. For this post, we will create a library called "Greeter" or "libGreeter" and use the following file structure:


```bash
├── CMakeLists.txt # the main CMakeLists.txt file
├── LICENSE
├── README.md
├── cmake # CMake modules
│   └── GreeterConfig.cmake.in
├── include # public headers
│   └── greeter
│       └── hello.hpp
└── src # source files
    ├── hello.cpp
    ├── internal.cpp
    └── internal.hpp
```

The library will expose a class `Greeter::Hello` that contains a `greet()` function that prints "Hello ${name} from a library" and it is declared in the `include/hello/hello.hpp`. Internally it uses a private function called `print_impl` which is defined in The `internal.cpp` and `internal.hpp` files. These are used to demonstrate how to hide symbols from the library interface. The `GreeterConfig.cmake.in` file is used to configure the CMake package file that will be used to make the library usable with `find_package()`.

Let's have a look at the public header file `include/greeter/hello.hpp`:

```cpp
#pragma once

#include <greeter/export_greeter.hpp>
#include <string>

namespace Greeter {
/// Example class that is explicitly exported into a library
class GREETER_EXPORT Hello {
public:
  Hello(const std::string &name) : name_{name} {}

  void greet() const;

private:
  const std::string name_;
};
} // namespace Greeter
```

Two things are notable in this class, first, the including of the `<greeter/export_header.hpp>` file and second, the `GREETER_EXPORT` macro. The `export_greeter.hpp` file is generated by CMake and contains the necessary macros to export symbols from the library. The `GREETER_EXPORT` macro is used to mark the class as exported. This makes the class visible to users of the library and marks the class `Greeter::Hello` as part of the public API. The export header is generated by CMake and we will look at it later.

## Creating the library with CMake

Let's have a look at the `CMakeLists.txt` file line by line.

<details>
<summary markdown="span">
Click here to expand the full FindLibrary.cmake
</summary>

```cmake
cmake_minimum_required(VERSION 3.17)

project(
    Greeter
    VERSION 1.0.0
    DESCRIPTION
        "A simple C++ project to demonstrate creating executables and libraries in CMake"
    LANGUAGES CXX
)

# set the postfix "d" for the resulting .so or .dll files when building the
# library in debug mode
set(CMAKE_DEBUG_POSTFIX
    d
)

# add the library target and an alias
add_library(Greeter)
add_library(Greeter::Greeter ALIAS Greeter)

# set properties for the target. VERSION set the library version to the project
# version * SOVERSION set the compatibility  version for the library to the
# major number of the version
set_target_properties(
    Greeter
    PROPERTIES VERSION ${PROJECT_VERSION}
               SOVERSION ${PROJECT_VERSION_MAJOR}
)

# add sources to the library target
target_sources(
    Greeter
    PRIVATE src/hello.cpp src/internal.cpp
)

# define the C++ standard needed to compile this library and make it visible to
# dependers
target_compile_features(
    Greeter
    PUBLIC cxx_std_17
)

# set the include directories
target_include_directories(
    Greeter
    PRIVATE src
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

# if using limited visibility, set CXX_VISIBILILTY_PRESET to "hidden"
include(GenerateExportHeader)
set_property(
    TARGET Greeter
    PROPERTY CXX_VISIBILITY_PRESET "hidden"
)
# Hide inlined functions by default, reducing the size of the library
set_property(
    TARGET Greeter
    PROPERTY VISIBILITY_INLINES_HIDDEN TRUE
)
# this command generates a header file in the CMAKE_CURRENT_BINARY_DIR which
# sets the visibility attributes according to the compiler settings
generate_export_header(
    Greeter
    EXPORT_FILE_NAME
    export/greeter/export_greeter.hpp
)
# Add CMAKE_CURRENT_BINARY_DIR to the include path so the generated header can
# be found
target_include_directories(
    Greeter
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/export>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    
)

# include the GNUInstallDirs module to get the canonical install paths defined
include(GNUInstallDirs)

# Install the library and export the CMake targets
install(
    TARGETS Greeter
    EXPORT GreeterTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
# install the public headers
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# install the generated export header
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/export/greeter/export_greeter.hpp"
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/greeter
)

# configure the CMake package file so the libray can be included with find_package() later
include(CMakePackageConfigHelpers)

write_basic_package_version_file(
    "GreeterConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

configure_package_config_file(
    "${CMAKE_CURRENT_LIST_DIR}/cmake/GreeterConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/GreeterConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/greeter
)

# install the CMake targets
install(
    EXPORT GreeterTargets
    FILE GreeterTargets.cmake
    NAMESPACE Greeter::
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/greeter
)
```
</details>

## Setting up the library

As usual the `CMakeLists.txt` starts with `cmake_minimum_required` which specifies the minimum CMake version to be used and the `project()` call. 

```cmake 
project(
    Greeter
    VERSION 1.0.0
    DESCRIPTION
        "A simple C++ project to demonstrate creating executables and libraries in CMake"
    LANGUAGES CXX
)
```

For libraries the `VERSION` field is important, as this is used to determine the version compatibility of the library. The `LANGUAGES` field is optional, but it is good practice to specify the language used in the project. This will make sure that the correct compiler is used when building the project.

The next thing to do is to set a debug postfix for the library with `set(CMAKE_DEBUG_POSTFIX d)`. This means when building the library in debug mode, it will append a "d" to the resulting library file. This is useful to distinguish between debug and release builds of the library, but it is an optional step. This is a global option for the project, so it will affect all libraries and executables inside the project. 

After that the library target is created with `add_library(Greeter)`. This will create a library target called `Greeter` which can be used to add sources, set properties and link against other libraries. To make the library usable with `find_package()` the same way as if it was included with `add_subdirectory` or with `FetchContent` we also create an alias for the library with `add_library(Greeter::Greeter ALIAS Greeter)`.  

That way all targets that use the library can use `Greeter::Greeter` instead of just `Greeter`. This is useful to avoid name clashes and to make it clear that the target is a library.

Once the target is defined we can set the properties for the library. 

```cmake
set_target_properties(
    Greeter
    PROPERTIES VERSION ${PROJECT_VERSION}
               SOVERSION ${PROJECT_VERSION_MAJOR}
)
```

The `VERSION` property sets the version of the library to the project version. The `SOVERSION` property sets the compatibility version of the library to the major version of the project. Generally you should try to use [semantic versioning](https://semver.org/) for libraries and set the `SOVERSION` to the major version of the library and determines API compatibility. Generally I advise to use the following rules for versioning:

* If your change the public API by removing or changing an interface class or function, increase the major version
* If new symbols are added to the API but nothing is changed or remove increase the minor version
* For implementation changes that do not affect the API increase the patch version

Once the target is created and the properties are set, we can add the sources to the library target with `target_sources()`. This command takes the target name and a list of source files and adds them to the target. The sources are added as private sources, which means they are only visible to the target itself. This is important to hide implementation details from the library interface. 

Next we need to set up the include directories for the library. For the public include directories, there are two things to consider here, first the headers need to be available to the library itself and second, the headers need to be available to users of the library. This makes the `target_include_directories()` command a bit more complicated. 

```cmake
target_include_directories(
    Greeter
    PRIVATE src
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
```

This command takes the target name and a list of include directories. The `PRIVATE` keyword means that the include directory is only visible to the target itself. We add the `src` folder here which contains all the internal headers/
The `PUBLIC` keyword means that the include directory is visible to the target and to users of the library, to differ the include path during building the library and when it is installed, a [generator expression](https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html) is used. If we're building the library itself the `$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>` expression will be evaluated to the `include` folder in the source directory. If the library is installed, the expression `$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>` will be evaluated to the install include directory. This makes sure that the correct include directory is used when building the library and when it is installed.

## Setting symbol visibility

Separating the headers into private and public is one step to define the library interface, we can go a step further by defining the symbol visibility of the library. This is important to hide implementation details from the library interface and to reduce the size of the library. First the default visibility of the library is set to hidden: 


```cmake
set_target_properties(Greeter PROPERTIES CXX_VISIBILITY_PRESET "hidden"
                                         VISIBILITY_INLINES_HIDDEN TRUE)
```

This means that all symbols are hidden by default and need to be explicitly exported. On Windows this is already the default, on linux und mac the default is that everything is visible. Additionally we can hide inlined functions by default, which will reduce the size of the library some more but it also means that inlined functions need to be explicitly exported.

CMake has a built-in module called `GenerateExportHeader` that can be used to generate a header file that sets the symbol visibility according to the compiler settings, which is included with `include(GenerateExportHeader)`. This gives us the `generate_export_header()` command which generates the export macro header file for a target. 

```cmake
generate_export_header(
    Greeter
    EXPORT_FILE_NAME
    export/greeter/export_greeter.hpp
)
```

By default the export header will be created in the `${CMAKE_CURRENT_BINARY_DIR}` directory unless an absolute path is passed to `EXPORT_FILE_NAME`, in this case exporting to the default location is fine, but we define the folder structure and the file name to be  `export/greeter/export_greeter.hpp`. Putting the export file into its own subfolder helps later with finding and installing it. The generated header file contains the necessary macros to export symbols from the library. 

In order to use the included file with `#include <greeter/export_greeter.hpp>` we need to add the `${CMAKE_CURRENT_BINARY_DIR}` to the include path. This is done with the `target_include_directories()` command again. Again we use the generator expression to differ between building the library and installing it. 

```cmake

target_include_directories(
    Greeter
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/export>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
    
)
```
This concludes the setup of the library target and it can be built and used in other projects by using `add_subdirectory()` and `target_link_libraries()`. However for a library to be useful it needs to be installed and usable with `find_package()`.

## Defining installation behavior

To make the library usable with `find_package()` we need to install the library and create a CMake package file. The first step is to define where the library should be installed. This is done with the `install()` command. The CMake module `GNUInstallDirs` defines the canonical install paths for different platforms which should be used except for special cases. 

The first thing to set is the install destination for the library itself. This is done with the `LIBRARY`, `ARCHIVE` and `RUNTIME` keywords. The `LIBRARY` keyword is used for shared libraries, the `ARCHIVE` keyword is used for static libraries and the `RUNTIME` keyword is used for executables. The `INCLUDES` keyword is used to install the include directories. 

```cmake

install(
    TARGETS Greeter
    EXPORT GreeterTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)


```

This tells CMake to install the target `Greeter` the the paths specified below. the `EXPORT GreeterTargets` keyword tells CMake to export the target information to an export set called `GreeterTargets` which will be used later to create the CMake package file in order to make the installation usable with `find_package`. 
The `CMAKE_INSTALL_LIBDIR`, `CMAKE_INSTALL_BINDIR` and `CMAKE_INSTALL_INCLUDEDIR` variables are defined by the `GNUInstallDirs` module. 

The public headers and the export-header need to be installed explicitly in a similar manner:

```cmake   
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/export/greeter/export_greeter.hpp"
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/greeter
)
```

For normal usage in a system as runtime library this would be already enough, but since this is a CMake package we want this to be usable as easily as possible by other devs. This means we need to create a CMake package file that can be used with `find_package()`.

### Making the library usable with `find_package()`

CMake provides the [CMakePackageConfigHelpers](https://cmake.org/cmake/help/latest/module/CMakePackageConfigHelpers.html) module which - as the name suggests - contains helper functions that can be used to create a CMake package file. A CMake package consists of a version information file, a configuration file and a list of exported targets. The version information file is used to check if the correct version of the package is installed and the package file is used to make the package usable with `find_package()`.

The first step is to create the version information file with `write_basic_package_version_file()`.

```cmake 
write_basic_package_version_file(
    "GreeterConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)
```

This command takes the name of the file to be created, the version of the package and the compatibility mode. The compatibility mode is used to determine if the package is compatible with the requested version. In this case we use `SameMajorVersion` which means that the package is compatible if the major version is the same. 

Next we generate the package file from a template:

```cmake
configure_package_config_file(
    "${CMAKE_CURRENT_LIST_DIR}/cmake/GreeterConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/GreeterConfig.cmake"
    INSTALL_DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/greeter
)
```

internally calls `configure_file()` to generate the package file from the template. The generated file will be called `GreeterConfig.cmake` and will be installed to `${CMAKE_INSTALL_DATAROOTDIR}/cmake/greeter`. The template file is a generic file that looks like this:

```cmake
@PACKAGE_INIT@

include("${CMAKE_CURRENT_LIST_DIR}/@PROJECT_NAME@Targets.cmake")
check_required_components("@PROJECT_NAME@")
```

The `@PACKAGE_INIT@` macro is replaced by the `CMakePackageConfigHelpers` module with the necessary code to initialize the package. The `@PROJECT_NAME@` macro is replaced with the project name. It includes the file containing the targets and checks if the required components are available.

The last step is to install the CMake targets:

```cmake
install(
    EXPORT GreeterTargets
    FILE GreeterTargets.cmake
    NAMESPACE Greeter::
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/cmake/greeter
)
```

This takes the export set `GreeterTargets` which we created above with the `install(EXPORT)` command and installs it to `${CMAKE_INSTALL_DATAROOTDIR}/cmake/greeter`. Then the namespace `Greeter::` is added to the targets in the export set. This means that the targets can be used with `Greeter::Greeter` instead of just `Greeter`.

With this the library is ready to be, built installed and used with `find_package()`. To build and install the library call.
    
```bash
cmake -B build -S .
cmake --build build --target install
```

By default this will create a static library, to create a shared library add `-DBUILD_SHARED_LIBS=ON` to the `cmake` command to configure the project. 

The setup described here is the bare minimum to create a clean library with CMake. There are a few more things that can be done to make the library more usable and portable, like adding [packaging information](https://cmake.org/cmake/help/latest/module/CPack.html) and of course it pays to set up proper [testing](https://cmake.org/cmake/help/latest/module/CPack.html) as well. 