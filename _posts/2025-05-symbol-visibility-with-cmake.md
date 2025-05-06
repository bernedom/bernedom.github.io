---
layout: post
title:  "CMake line by line: Symbol visibility for C++ libraries"
description: ""
thumbnail: images/cmake-logo.png
---

**One of the most overlooked features when writing C++ libraries is proper symbol visibility.** It is one of my pet peeves that many C++ libraries do not take advantage of this feature and do not properly define which of a libraries symbols are visible and which not. There are several benefits of defining proper symbol visibility, such as reduced binary size as the linker can discard unused code, better safety as hiding the internal symbols prevents the user from accidentally relying on private implementation details and cleaner API when using the library. One hurdle often quoted when asking about symbol visibility is that it is tedious to handle, especially when building for various compilers and platforms, but here CMake can help by simplifzing the handling drastically. Let's see how to do this in CMake.

## How to define symbol visibility in a nutshell



{% include cmake-best-practices-ad.html %}