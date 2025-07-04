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
* Not using toolchain files for cross-compilation or multi-platform builds.
* incomplete library and target setup, missing versioning and messing up PUBLIC/PRIVATE/INTERFACE usage.
* Incorrect testing setup.

So let's dive into these mistakes and let's talk on how to avoid them and get out of it. 

### 1. Messed up Dependency Management

Dependency management with C++ is notoriously difficult, especially when developing for multiple platforms. In the past, dependency management had to be done manually, but nowadays we have powerful package managers like Conan, vcpkg, and others that can help manage dependencies more effectively. In fact, with the advent of [CMake dependency providers, using package managers has become the recommended approach to dependency management](https://dominikberner.ch/conan-as-cmake-dependency-provider/). However, many projects still struggle with dependency management, often due to legacy practices.

One of the worst sins here is to do this by just packing the dependencies into your project, either as source code or - even worse - as precompiled binaries, a practice often referred to as "vendoring". This approach can lead to a lot of problems, such as bloated repositories, duplicated code, and difficulties in updating or patching dependencies. 

The practice of vendoring was often made worse by hardcoding paths or using custom scripts to manage dependencies, which made the build process fragile and non-portable. This is where modern CMake shines, as it provides a robust way to manage dependencies through `find_package`, which allows you to locate and use system-installed libraries or packages.

Using `find_package` is the preferred way to look for dependencies in CMake. Moving from hard-coded paths to using `find_package` is a good first step towards modernizing your CMake project. Nowadays a lot of libraries provide CMake configuration files that can be found with `find_package`, making it easy to integrate them into your project. If a library does not provide a CMake configuration [writing your own `Find<PackageName>.cmake` module](https://dominikberner.ch/cmake-find-library/) can be a good first step before moving to full package management with Conan, vcpkg, or similar tools.

Closely related to hard coding dependencies is the practice of using variables to store paths or settings instead of using CMake's built-in targets and packages. This can lead to confusion and inconsistencies, as different parts of the project may use different paths or settings for the same dependency.

### 2. Using global configuration and variables instead of targets and properties

It is now over ten years since CMake 3.0 - often referred as "Modern CMake" - came out, which introduced the concept of targets and properties. The introduction of the concept of targets was a major paradigm shift and a big enabler to create maintainable and portable CMake projects. With targets and properties, definition and configuration of libraries, executables, and other build artifacts became much more structured and manageable and notably mostly side-effect free. 

However, many projects still use global variables and configuration instead of targets, which can lead to a lot of confusion and issues. The problem with this is that it is easy to accidentally overwrite existing variables or settings, leading to unexpected behavior. Also variables have unclear scoping, while targets and their properties are inherently scoped, making it easier to combine existing projects and libraries without conflicts. 

Using the `target_*` commands in CMake, such as `target_link_libraries`, `target_include_directories`, and `target_compile_options`, allows you to define dependencies and settings for specific targets, making your build scripts more modular and easier to understand. Especially, because with the keywords `PUBLIC`, `PRIVATE`, and `INTERFACE` one can control which properties are transient when linking against a target and which ones are not.

While there are a few places such as `options()` where global variables are still useful, they should be used sparingly and only when absolutely necessary. After all, one key feature of CMake is that it allows you to define your build process in a modular way, which makes it easier to combine different projects or create build instructions that can be reused across different platforms. Nevertheless, keeping track of all the different configurations can be a challenge, which is where CMakePresets come in handy.


### 3. Not using CMakePresets

CMake presets are arguably one of the most powerful features introduced in CMake since the introduction of targets. They allow you to define and manage different build configurations in a structured way, making it easier to switch between different build setups without having to modify the CMake scripts directly.

> CMake presets are one of the most impactful features introduced in CMake since the introduction of targets.

Managing different build configurations with CMake can be a complex task, especially when dealing with multiple platforms, compilers, and build types. [CMakePresets provide a way to define these configurations](https://dominikberner.ch/cmake-presets-best-practices/) in a single file, making it easier to maintain and share them across different developers and CI systems.

By providing a standardized way to configure good build configurations for development, testing, and release builds, CMakePresets can significantly reduce the entry barrier for new contributors and help ensure that everyone is using the same build settings. Not using CMakePresets means that every developer has to figure out their own configuration, leading to inconsistencies and wasted time. Good projects provide `CMakePresets.json` files with common configurations for development, testing, and release builds. Always include and maintain presets for your project, and encourage contributors to use them or create their own `CMakeUserPresets.json` files for their specific needs.

CMake presets are a game changer for managing build configurations, but they rely on the underlying CMake scripts to be as platform-agnostic and modular as possible. This means that the CMake scripts should not contain hardcoded paths or platform-specific commands, but rather use CMake's built-in functions and variables to ensure portability across different platforms and compilers.

### 4. Using non-portable scripts or commands

CMake's possibility to call external commands or scripts is very powerful, but it can also lead to non-portable code if not used carefully. Many projects still write CMake scripts that are tailored to specific platforms or compilers, which can cause issues when trying to build the project on different systems or with different toolchains.

One of the most powerful features of CMake is it's ability to generate build files for different platforms and compilers. However this advantage is often lost when projects are using platform-specific commands or (external) scripts that are not portable across different systems. A few simple rules can help making CMake scripts more portable:

* For custom scripting consider using CMakes built-in scripting capabilities instead of external scripts by calling `CMake -P <script>` or the `CMake -E` commands from the CMake scripts.
* Compiler-specific flags or options should be set in the CMake presets
* No hardcoded paths should be used, but rather use CMake's built-in functions to find libraries and include directories.
* Use CMake's built-in functions and variables to ensure portability across different platforms and compilers.

By following these four rules, you can create more portable and maintainable CMake scripts that work across different platforms and toolchains.

### 5. Not Using Toolchain Files for Cross-Compilation or Multiplatform Builds

Cross-compiling or building for multiple platforms without toolchain files is error-prone and difficult to maintain. Toolchain files encapsulate compiler, linker, and system settings, making it easy to switch between build environments. Good CMake projects provide and document toolchain files for supported platforms. Always use and encourage toolchain files for cross-platform and cross-compilation scenarios.

### 6. Incomplete Library and Target Setup

Failing to properly set up libraries and targets—such as missing versioning, or incorrect use of `PUBLIC`, `PRIVATE`, and `INTERFACE` keywords—leads to dependency and linkage issues. This can cause downstream projects to break or behave unexpectedly. Good practice is to always specify visibility (`PUBLIC`, `PRIVATE`, `INTERFACE`) when linking libraries and to provide version information for your targets. Review your target setup and ensure all properties are correctly set.

### 7. Incorrect Testing Setup

A poor or missing testing setup means regressions go unnoticed and code quality suffers. Not integrating testing frameworks or not adding tests to the build process is a common mistake. Good CMake projects use `enable_testing()` and integrate with frameworks like CTest or GoogleTest, ensuring tests are easy to run and part of the CI process. Always set up and maintain a robust testing infrastructure in your CMake project.

---

By avoiding these common mistakes and following modern CMake best practices, you can make your build process more robust, maintainable, and enjoyable for everyone involved.
