---
layout: post
title: Cmake line by line - finding a non-cmake library
thumbnail: images/cmake-logo.png
---

**Cmake is awesome, but it can be hard to figure out.** Over the last few years, cmake has become one of the most popular ways to build C++ applications and libraries and many develop.  Unfortunately you might be stuck wit an existing software that ist built entirely differently. Be it make files, gradle, Qmake or even something completely custom build. 
So migrating doftware is hard and often cannot be done all at once. Fortunately cmakes [`find_package`](https://cmake.org/cmake/help/latest/command/find_package.html) allows you to mix a cmake project with artifacts built by other build systems. This can help you to switch whatever you're currently developing to cmake without the need to migrate the whole ecosystem of a software to cmake.

## Find_package in a nutshell

In a nutshell, the mechanism often referred as `find.cmake` or "find modules" relies on having cmake files that provide hints where to find the headers and libraries of the other modules. What happens in a such a cmake file is essentially the following.

1. Look for files belonging to the package in likely locations
2. Set a few variables for include path and library path for the package
3. Set up an imported target for the package
4. Set the properties for the target to work

For a more detailed description head over to the [official cmake documentation](https://cmake.org/cmake/help/latest/command/find_package.html#search-procedure)

## Setting up to use find.cmake

Let us assume we have a cmake project that depends on an image-processing library called `LibImagePipeline`. This LibImagePipeline is a dynamic library including accompanying header files built somewhere else. For building we manually download it to a location inside the build folder and include it with `find_package(libImagePipeline)` in our project.

The project structure looks something like this>

```bash
.
├── build <-- The ${PROJECT_BINARY_DIR} or build folder
├── cmake
│   └── FindLibImagePipeline.cmake <-- This is what we need to write
├── CMakeLists.txt <-- Main CmakeLists.txt
├── src
│   ├── *.cpp files

```

In the main `CMakeLists.txt` finding the package is invoked as shown below. Cmake looks into the paths stored in the ${CMAKE_MODULE_PATH} variable for the files with the find-instructions. The find-files have to be [named according to a certain convention](https://cmake.org/cmake/help/latest/command/find_package.html#id5) but it essentially boils down to name them as `<libraryname>.cmake` 

Once the libray is found it can be linked to targets as usual using `target_link_libraries`

```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")
find_package(libImagePipeline REQUIRED)
...
add_executable(${PROJECT_NAME})
...
target_link_libraries(${PROJECT_NAME} PRIVATE libImagePipeline::libImagePipeline)

```

## Find.cmake line by line

Let's look how the `FindLibImagePipeline.cmake` might look like. 

<details>
<summary markdown="span">
Click here to expand the full FindLibrary.cmake
</summary>

```cmake
include(GNUInstallDirs)
find_library(
    LIBIMAGEPIPELINE_LIBRARY
    NAMES LibImagePipeline
    HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${CMAKE_INSTALL_LIBDIR}
    PATH_SUFFIXES LibImagePipeline/nativ-linux-x64-static/)

find_path(LIBIMAGEPIPELINE_INCLUDE_DIR
  NAMES imagepipeline/Pipeline.hpp
  HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${CMAKE_INSTALL_INCLUDEDIR}
  PATH_SUFFIXES LibImagePipeline/native-linux-api/)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(libImagePipeline DEFAULT_MSG
                                  LIBIMAGEPIPELINE_LIBRARY
                                  LIBIMAGEPIPELINE_INCLUDE_DIR)

mark_as_advanced(LIBIMAGEPIPELINE_LIBRARY LIBIMAGEPIPELINE_INCLUDE_DIR)

set(LIBIMAGEPIPELINE_INCLUDE_DIRS ${LIBIMAGEPIPELINE_INCLUDE_DIR})

if(LIBIMAGEPIPELINE_FOUND AND NOT TARGET libImagePipeline::libImagePipeline)
  add_library(libImagePipeline::libImagePipeline DYNAMIC IMPORTED)
  set_target_properties(
    libImagePipeline::libImagePipeline
    PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LIBIMAGEPIPELINE_INCLUDE_DIRS}"
      IMPORTED_LOCATION ${LIBIMAGEPIPELINE_LIBRARY})
endif()
```

</details>

## Finding the location of the package

First thing is finding some files belonging to the package in likely locations to determine where the library is saved. Let's assume that dependencies are either put into the build-dir in the folder `prebuilt` or installed in the unix default location. The default locations are provided by `GNUInstallDirs` which the first thing to include.

```cmake
include(GNUInstallDirs)
```

```cmake
find_library(
    LIBIMAGEPIPELINE_LIBRARY
    NAMES LibImagePipeline
    HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${CMAKE_INSTALL_LIBDIR}
    PATH_SUFFIXES LibImagePipeline/native-linux-x64-static/)
```

Next thing is to find the binary library package. For header-only libraries this step can be omitted. 
`find_library` tells cmake that we're looking for a library and once we have found it, the path to it is stored in `LIBIMAGEPIPELINE_LIBRARY`. Likely filenames are passed with `NAMES LibImagePipeline`. Here we're only looking for a single name but alternative spellings could also be passed. 
`HINTS ${PROJECT_BINARY_DIR}/prebuilt/` is again a list of folders to look for and `PATH_SUFFIXES` are appended to that. 

After the binary files next is finding the headers:

```cmake
find_path(LIBIMAGEPIPELINE_INCLUDE_DIR
  NAMES imagepipeline/Pipeline.hpp
  HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${CMAKE_INSTALL_INCLUDEDIR}
  PATH_SUFFIXES LibImagePipeline/native-linux-api/)
```

This call tells cmake to 