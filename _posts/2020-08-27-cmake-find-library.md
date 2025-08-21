---
layout: post
title: CMake line by line - using a non-CMake library
image: /images/cmake-logo.png
hero_image: /images/cmake-logo.png
hero_darken: true
description: how to use the find.cmake mechanism to include library into your CMake project, even if it is not built with CMake itself. By combining find_package with a custom .cmake file we can migrate any library to be usable with a CMake project. 
---

**CMake is awesome, but it can be hard to figure out.** Over the last few years, CMake has become one of the most popular ways to build C++ applications and libraries. Unfortunately, you might be stuck with an existing piece of software that is built entirely differently - be it makefiles, gradle, Qmake or even a completely custom-built way to compile software - you name it. So what if you want to move your codebase to CMake without rewriting the way all these old dependencies are built?


Fortunately, CMake's [`find_package`](https://cmake.org/cmake/help/latest/command/find_package.html) allows you to mix a CMake project with artifacts built by some other build system. This is essential if you want to shift your codebase to CMake without the need to migrate the whole ecosystem of a software portfolio at once.

{% include cmake-best-practices-ad.html %}

## Find_package in a nutshell

In a nutshell, the mechanism often referred to as `find.cmake`, "find package" or "find modules" uses `.cmake` files that provide information about where to find the headers and libraries of the other modules. The find-files do roughly the following:

1. Look for files belonging to the package in likely locations
2. Set up variables for include-path and library-path for the package
3. Set up targets for the imported package
4. Set the properties for the targets

For the full documentation and inner workings head over to the [official CMake documentation.](https://cmake.org/cmake/help/latest/command/find_package.html#search-procedure)

## Setting up to use find.cmake

Let's assume we have a CMake project that depends on an non-CMake built dynamically shared library called `LibImagePipeline`. For building, the `.so` or `.dll` file and header files are downloaded to a location inside the build folder (i.e. by using [cmakes "fetchContent" mechanism](https://cmake.org/cmake/help/latest/module/FetchContent.html)]).

The project structure looks something like this>

```bash
.
├── build <-- The ${PROJECT_BINARY_DIR} or build folder
├── CMake
│   └── FindLibImagePipeline.cmake <-- This is what we need to write
├── CMakeLists.txt <-- Main CmakeLists.txt
├── src
│   ├── *.cpp files

```

In the main `CMakeLists.txt` finding the package is invoked with `find_package(libImagePipeline)` as shown below. CMake looks into the paths stored in the `${CMAKE_MODULE_PATH}` variable for the files with the find-instructions. The find-files have to be [named according to a certain convention](https://cmake.org/cmake/help/latest/command/find_package.html#id5) which essentially boils down to `<libraryname>.cmake`.

Once the library is found it can be linked to targets using `target_link_libraries`. The details on how to use it is explained at the end of this article, but it looks something like this:

```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake/")
find_package(libImagePipeline REQUIRED)
...
add_executable(SomeExecutable)
...
target_link_libraries(SomeExecutable PRIVATE libImagePipeline::libImagePipeline)
```

## Find.cmake line by line

Let's look at how the `FindLibImagePipeline.cmake` looks like:

<details>
<summary markdown="span">
Click here to expand the full FindLibrary.cmake
</summary>

```cmake
include(GNUInstallDirs)

find_library(
    LIBIMAGEPIPELINE_LIBRARY
    NAMES LibImagePipeline
    HINTS ${PROJECT_BINARY_DIR}/prebuilt/
    PATH_SUFFIXES LibImagePipeline/native-linux-x64/)

find_path(LIBIMAGEPIPELINE_INCLUDE_DIR
  NAMES Pipeline.hpp
  HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${CMAKE_INSTALL_INCLUDEDIR}
  PATH_SUFFIXES LibImagePipeline/native-linux-api/imagepipeline/ LibImagePipeline/imagepipeline)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(libImagePipeline DEFAULT_MSG
                                  LIBIMAGEPIPELINE_LIBRARY
                                  LIBIMAGEPIPELINE_INCLUDE_DIR)

mark_as_advanced(LIBIMAGEPIPELINE_LIBRARY LIBIMAGEPIPELINE_INCLUDE_DIR)

if(LIBIMAGEPIPELINE_FOUND AND NOT TARGET libImagePipeline::libImagePipeline)
  add_library(libImagePipeline::libImagePipeline SHARED IMPORTED)
  set_target_properties(
    libImagePipeline::libImagePipeline
    PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LIBIMAGEPIPELINE_INCLUDE_DIR}"
      IMPORTED_LOCATION ${LIBIMAGEPIPELINE_LIBRARY})
endif()
```

</details>

## Finding the package files

Let's assume that dependencies are either put into the build-dir in a folder `prebuilt` or installed in the [GNU default directories](http://www.gnu.org/prep/standards/html_node/Directory-Variables.html). The default locations are provided by the CMake module `GNUInstallDirs` which the first thing to include.

```cmake
include(GNUInstallDirs)
```

After this bit of boilerplate we start looking some files belonging to the package to determine where the library is saved. Let's assume that dependencies are either put into the build-dir in the folder `prebuilt` or installed in the default locations. The default locations are searched by default, so we do not have to add them manually. For header-only libraries the call to `find_library` can be omitted.

```cmake
find_library(
    LIBIMAGEPIPELINE_LIBRARY
    NAMES LibImagePipeline
    HINTS ${PROJECT_BINARY_DIR}/prebuilt/
    PATH_SUFFIXES LibImagePipeline/native-linux-x64/)
```

`find_library` tells CMake that we're looking for a library and once we have found it, to store the path to it in the variable `LIBIMAGEPIPELINE_LIBRARY`. Likely filenames are passed with `NAMES LibImagePipeline`. It is good practice to pass the names without the file extension like `.so`, `.dll`, `.a` etc. and without version suffix, so locally-built packages are found before installed ones. Here we're only looking for a single name but alternative spellings could also be passed.
`HINTS ${PROJECT_BINARY_DIR}/prebuilt/` is a list of folders in which to search for the library in addition to the default locations. In this example, this is our custom download folder. `PATH_SUFFIXES` are locations below to the paths specified in `HINTS` to look for the library. 
If the library file is not found the variable `LIBIMAGEPIPELINE_LIBRARY-NOTFOUND` is created.

Once the binary files are located the we do a similar thing to find headers:

```cmake
find_path(LIBIMAGEPIPELINE_INCLUDE_DIR
  NAMES Pipeline.hpp
  HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${CMAKE_INSTALL_INCLUDEDIR}
  PATH_SUFFIXES LibImagePipeline/native-linux-api/imagepipeline/ LibImagePipeline/imagepipeline)
```

The `find_path` is used to look for a specific file in multiple locations. Similar to `find_library` above, the first argument `LIBIMAGEPIPELINE_INCLUDE_DIR` is the variable to store the result in. `NAMES Pipeline.hpp` specifies a file we're looking for. As `find_path` does not have default locations (such as `/usr/include/`) to look in we pass it manually by adding the `CMAKE_INSTALL_INCLUDEDIR` variable which is defined in the `GNUInstallDirs` include above. `PATH_SUFFIXES` are paths that are appended to the directories specified under `HINTS`. The HINTS take precedence over the suffixes in the search order.

The resulting search order is the following:

* `${PROJECT_BINARY_DIR}/prebuilt/LibImagePipeline/native-linux-api/imagepipeline/Pipeline.hpp`
* `${PROJECT_BINARY_DIR}/prebuilt/LibImagePipeline/imagepipeline/Pipeline.hpp`
* `${CMAKE_INSTALL_INCLUDEDIR}/LibImagePipeline/native-linux-api/imagepipeline/Pipeline.hpp`
* `${CMAKE_INSTALL_INCLUDEDIR}/LibImagePipeline/imagepipeline/Pipeline.hpp`

Once we know the likely paths to the files needed, CMake is ready to set it up as a package. `find_package` has lots of parameters that are only needed in rare cases, we're taking a shortcut by including `FindPackageHandleStandardArgs` from the standard CMake distribution to make the call simpler.

```cmake
include(FindPackageHandleStandardArgs)
```

This include provides the `find_package_handle_standard_args` convenience function:

```cmake
find_package_handle_standard_args(libImagePipeline DEFAULT_MSG
                                  LIBIMAGEPIPELINE_LIBRARY
                                  LIBIMAGEPIPELINE_INCLUDE_DIR)
```

The first argument `libImagePipeline` is the name of the package we're going to build. This is often the same as the library name, which may make things a bit confusing. `DEFAULT_MSG` tells CMake to use a preconfigured set of messages if the package is not found. Next, we pass the two required variables  `LIBIMAGEPIPELINE_LIBRARY` and `LIBIMAGEPIPELINE_INCLUDE_DIR` which contain the paths to the files belonging to the package. If any of the paths are not set by the calls of `find_path` or `find_library` above CMake prints an error message. 

## Configuring the targets

If all went well, the searching of the package is now done. But before this library can be used it needs to be configured as a CMake-target.
By declaring out internally generated variables as advanced, they do not show up in any of the GUIs. This is not strictly necessary, but a nice touch anyway. 

```cmake
mark_as_advanced(LIBIMAGEPIPELINE_LIBRARY LIBIMAGEPIPELINE_INCLUDE_DIR)
```

To configure the library and its targets we make sure that it is found and not already configured for instance by multiple calls to `find_package(LibImagePipeline)` within the same CMake project.

```cmake
if(LIBIMAGEPIPELINE_FOUND AND NOT TARGET libImagePipeline::libImagePipeline)
  ...
endif()
```

The variable `LIBIMAGEPIPELINE_FOUND` is set if the by the call of `find_package_handle_standard_args` succeeds. Else it is unset. The second part of the if statement `NOT TARGET libImagePipeline::libImagePipeline` ensures that the library is not already declared as a target within the current project. 

Inside the `if` the declaration and the configuration of the target is done:

```cmake
add_library(libImagePipeline::libImagePipeline SHARED IMPORTED)
```

`add_library` declares the CMake target for the imported library. With `libImagePipeline::libImagePipeline` the target is given a name including a namespace to access it within the CMake project. `SHARED` tells us this is a dynamically linked library and `IMPORTED` indicates that the library is not built by the current project.

By this point all that is left is the configuration of the target. Setting the properties can be a bit tricky if it the inner layout and the way of building the library is not known. So this is often the hardest part of writing a `find.cmake` file.

```cmake
  set_target_properties(
    libImagePipeline::libImagePipeline
    PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LIBIMAGEPIPELINE_INCLUDE_DIR}"
      IMPORTED_LOCATION ${LIBIMAGEPIPELINE_LIBRARY})
```

Properties for targets can be manipulated with the `set_target_properties` command. There are [quite a few variables for targets](https://cmake.org/cmake/help/latest/manual/CMake-properties.7.html#target-properties) available, but most often only the include dir and the location of the library-files itself are needed.

`PROPERTIES` takes a list of pairs of property names and values.
* `INTERFACE_INCLUDE_DIRECTORIES "${LIBIMAGEPIPELINE_INCLUDE_DIR}"` is a list of public include folders. The value is the path we found in the call to `find_path` at the beginning of the find.cmake. 
* `IMPORTED_LOCATION ${LIBIMAGEPIPELINE_LIBRARY}` is the location of the library file provided by `find_library`.

# Usage in an existing CMake project

Having defined all of the above CMake is able to find the required parts of a library except where to find the `find.cmake` file itself. This is done by appending folder where the file is located to `CMAKE_MODULE_PATH`.

```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake/")
```

From here on the package can be included by calling `find_package`. The `REQUIRED` keyword marking that the library is essential for the build and that CMake will stop with an error if the package is not found.

```cmake
find_package(libImagePipeline REQUIRED)
```

Now, the library is available like a normal target defined in CMake and can be linked to any other existing target with `target_link_libraries`.

```cmake
add_executable(SomeExecutable)
target_link_libraries(SomeExecutable PRIVATE libImagePipeline::libImagePipeline)
```

That is all that is to know to get started. Of course CMake being what it is there are a lot of inner workings and edge cases which can be covered when using [`find_package`](https://cmake.org/cmake/help/latest/command/find_package.html), so be sure to refer to the original documentation if stuck. 
