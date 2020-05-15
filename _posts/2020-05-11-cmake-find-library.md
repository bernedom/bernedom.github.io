---
layout: post
title: Cmake line by line - finding a non-cmake library
thumbnail: images/cmake-logo.png
---

**Cmake is awesome, but it can be hard to figure out.** Over the last few years, cmake has become one of the most popular ways to build C++ applications and libraries and many developers. As a company, building your software built with a de-facto standard instead of a custom built, heavily customized build-system intended for something else is a huge benefit. But migrating is hard, fortunately cmake can make this easier by allowing you to mix it with artifacts built by other build systems quite easil by using Cmakes [`find_package`](https://cmake.org/cmake/help/latest/command/find_package.html).The mechanism often referred as `find.cmake` or "find modules" relies on having cmake files that provide hints where to find the headers and libraries of the other modules.

## Find_package in a nutshell

In a nutshell a `find.cmake` does the following:

1. Look for files belonging to the package in likely locations
2. Set a few variables for include path and library path for the package
3. Set up an imported target for the package
4. Set the properties for the target to work

For a more detailed description head over to the [official cmake documentation](https://cmake.org/cmake/help/latest/command/find_package.html#search-procedure)


<details>
<summary markdown="span">
For a quick overview: Click here to expand the full FindLibrary.cmake
</summary>

```cmake
if(CMAKE_CROSSCOMPILING)
  find_library(LIBIMAGEPIPELINE_LIBRARY
    NAMES HSAvantgardeLibImagePipeline
    HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${PROJECT_SOURCE_DIR}/build/prebuilt/
  	PATH_SUFFIXES HSAvantgardeLibImagePipeline/natives-linux-arm64-static/)
else()
  find_library(LIBIMAGEPIPELINE_LIBRARY
    NAMES HSAvantgardeLibImagePipeline
    HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${PROJECT_SOURCE_DIR}/build/prebuilt/
    PATH_SUFFIXES HSAvantgardeLibImagePipeline/natives-linux-x64-static/)
endif()

find_path(LIBIMAGEPIPELINE_INCLUDE_DIR
  NAMES imagepipeline/util/DeviceManager.hpp
  HINTS ${PROJECT_BINARY_DIR}/prebuilt/ ${PROJECT_SOURCE_DIR}/build/prebuilt/
  PATH_SUFFIXES HSAvantgardeLibImagePipeline/natives-linux-api/)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(libImagePipeline DEFAULT_MSG
                                  LIBIMAGEPIPELINE_LIBRARY
                                  LIBIMAGEPIPELINE_INCLUDE_DIR)

mark_as_advanced(LIBIMAGEPIPELINE_LIBRARY LIBIMAGEPIPELINE_INCLUDE_DIR)

set(LIBIMAGEPIPELINE_INCLUDE_DIRS ${LIBIMAGEPIPELINE_INCLUDE_DIR})

if(LIBIMAGEPIPELINE_FOUND AND NOT TARGET libImagePipeline::libImagePipeline)
  add_library(libImagePipeline::libImagePipeline STATIC IMPORTED)
  set_target_properties(
    libImagePipeline::libImagePipeline
    PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LIBIMAGEPIPELINE_INCLUDE_DIRS}"
      IMPORTED_LOCATION ${LIBIMAGEPIPELINE_LIBRARY})
endif()
```

</details>

## An example file




