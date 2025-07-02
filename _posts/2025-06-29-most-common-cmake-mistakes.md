---
layout: post
title:  "The 7 most common CMake sins"
description: "CMake is a powerful tool, with a reputation of being hard to use. However, if used correctly, most of the pain points can be avoided. Here are the 7 most common sins I see when using CMake."
thumbnail: images/cmake-logo.png
---

**"CMake is hard to use and our build processes are a mess!"** CMake often has the reputation of being hard to use, but this is often due to common mistakes that can be easily avoided. In this post, I will cover the 7 most common sins I see when using CMake and how to avoid them. While you still might be able to build and ship your software, typically these mistakes lead to a lot of pain, frustration, and wasted time for developers up to a point where projects become almost unmaintainable, because every change to the project needs some magic incarnation on the build system side to work.

Most of these sins stem from a lack of application of modern CMake or from a time where CMake was not as mature as it is today. The CMake ecosystem has evolved significantly, and many of the issues that plagued earlier versions can now be avoided with best practices and modern features. Unfortunately, many projects still carry the baggage of these old practices, leading to confusion and inefficiency.

The most common sins from my experience are:

* Messed up dependency management - notably not using `find_package`, but relying on vendoring.
* Using variables instead of targets and packages.
* writing non-portable CMake code.
* Omitting CMakePresets to configure the project.
* Not using toolchain files for cross-compilation or multiplatform builds.
* incomplete library and target setup, missing versioning and messing up PUBLIC/PRIVATE/INTERFACE usage.
* Incorrect testing setup.

So let's dive into these mistakes and let's talk on how to avoid them and get out of it. 

### 1. Messed up Dependency Management

Dependency management with C++ is notoriously difficult, especially when developing for multiple platforms. In the past, dependency management had to be done manually, but nowadays we have powerful package managers like Conan, vcpkg, and others that can help manage dependencies more effectively. In fact, with the advent of [CMake dependency providers, using package managers has become the recommended approach to dependency management](https://dominikberner.ch/conan-as-cmake-dependency-provider/). However, many projects still struggle with dependency management, often due to legacy practices.

One of the worst sins here is to do this by just packing the dependencies into your project, either as source code or - even worse - as precompiled binaries, a practice often referred to as "vendoring". This approach can lead to a lot of problems, such as bloated repositories, duplicated code, and difficulties in updating or patching dependencies. 

The practice of vendoring was often made worse by hardcoding paths or using custom scripts to manage dependencies, which made the build process fragile and non-portable. This is where modern CMake shines, as it provides a robust way to manage dependencies through `find_package`, which allows you to locate and use system-installed libraries or packages.

Using `find_package` is the preferred way to look for dependencies in CMake. Moving from hard-coded paths to using `find_package` is a good first step towards modernizing your CMake project. Nowadays a lot of libraries provide CMake configuration files that can be found with `find_package`, making it easy to integrate them into your project. If a library does not provide a CMake configuration [writing your own `Find<PackageName>.cmake` module](https://dominikberner.ch/cmake-find-library/) can be a good first step before moving to full package management with Conan, vcpkg, or similar tools.

Closely related to hard coding dependencies is the practice of using variables to store paths or settings instead of using CMake's built-in targets and packages. This can lead to confusion and inconsistencies, as different parts of the project may use different paths or settings for the same dependency.

### 2. Using Variables Instead of Targets and Packages

In CMake, it's important to use targets and packages instead of plain variables for dependencies. This is because targets provide a higher level of abstraction and better encapsulation of build properties. When you use variables, you risk introducing inconsistencies and making your build system harder to understand and maintain.

For example, instead of using a variable to store the path to a library, you should create a CMake target for that library using `add_library()` or `add_executable()`. Then, you can use `target_link_libraries()` to specify dependencies between targets. This approach makes it clear which targets depend on each other and allows CMake to manage the build process more effectively.
### 3. Writing Non-Portable CMake Code  

CMake is designed to be cross-platform, but many projects still write non-portable CMake code that only works on specific platforms or compilers. This can lead to issues when trying to build the project on different systems or with different toolchains.
To avoid this, always use CMake's built-in functions and variables that are designed to be portable. For example, use `CMAKE_CXX_STANDARD` to specify the C++ standard instead of hardcoding compiler flags. Additionally, avoid using platform-specific paths or commands in your CMake scripts. Instead, use CMake's cross-platform features, such as `CMAKE_SYSTEM_NAME`, to conditionally include platform-specific code when necessary.

### 4. Omitting CMakePresets
CMakePresets provide a standardized way to configure and build projects, making it easier for new contributors to get started and for CI systems to build consistently. Omitting them means every developer must figure out their own configuration, leading to inconsistencies and wasted time. Good projects provide `CMakePresets.json` files with common configurations for development, testing, and release builds. Always include and maintain presets for your project.

### 5. Not Using Toolchain Files for Cross-Compilation or Multiplatform Builds

Cross-compiling or building for multiple platforms without toolchain files is error-prone and difficult to maintain. Toolchain files encapsulate compiler, linker, and system settings, making it easy to switch between build environments. Good CMake projects provide and document toolchain files for supported platforms. Always use and encourage toolchain files for cross-platform and cross-compilation scenarios.

### 6. Incomplete Library and Target Setup

Failing to properly set up libraries and targets—such as missing versioning, or incorrect use of `PUBLIC`, `PRIVATE`, and `INTERFACE` keywords—leads to dependency and linkage issues. This can cause downstream projects to break or behave unexpectedly. Good practice is to always specify visibility (`PUBLIC`, `PRIVATE`, `INTERFACE`) when linking libraries and to provide version information for your targets. Review your target setup and ensure all properties are correctly set.

### 7. Incorrect Testing Setup

A poor or missing testing setup means regressions go unnoticed and code quality suffers. Not integrating testing frameworks or not adding tests to the build process is a common mistake. Good CMake projects use `enable_testing()` and integrate with frameworks like CTest or GoogleTest, ensuring tests are easy to run and part of the CI process. Always set up and maintain a robust testing infrastructure in your CMake project.

---

By avoiding these common mistakes and following modern CMake best practices, you can make your build process more robust, maintainable, and enjoyable for everyone involved.
