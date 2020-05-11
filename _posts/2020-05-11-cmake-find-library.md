---
layout: post
title: Cmake line by line - finding a non-cmake library
thumbnail: images/cmake-logo.png
---

**Cmake is awesome, but it can be hard to figure out.** Over the last few years cmake has become one of the most popular ways to build C++ applications and libraries and many developers. As a company, building your software built with a de-facto standard instead of a custom built, heavily customized build-system intended for something else is a huge benefit. But migrating is hard, fortunately cmake can make this easier by allowing you to mix it with artifacts built by other build systems quite easil by using Cmakes [`find_package`](https://cmake.org/cmake/help/latest/command/find_package.html).The mechanism often referred as `find.cmake` or "find modules" relies on having cmake files that provide hints where to find the headers and libraries of the other modules.

## Find_package in a nutshell

In a nutshell a call to find_package in cmake does the following thing. For a more detailed description head over to the [official cmake documentation](https://cmake.org/cmake/help/latest/command/find_package.html#search-procedure)



