---
layout: post
title:  "The 7 most common CMake mistakes"
description: "CMake is a powerful tool, with a reputation of being hard to use. However, if used correctly, most of the pain points can be avoided. Here are the 7 most common mistakes I see when using CMake."
thumbnail: images/cmake-logo.png
---

**"CMake is hard to use and our build processes are a mess!"** CMake often has the reputation of being hard to use, but this is often due to common mistakes that can be easily avoided. In this post, I will cover the 7 most common mistakes I see when using CMake and how to avoid them.

The most common mistakes from my experience are:

* Messed up dependency management - notably not using `find_package`, but relying on vendoring.
* Using variables instead of targets and packages.
* writing non-portable CMake code.
* Omitting CMakePresets to configure the project.
* Not using toolchain files for cross-compilation or multiplatform builds.
* incomplete library and target setup, missing versioning and messing up PUBLIC/PRIVATE/INTERFACE usage.
* Incorrect testing setup.

---

### 1. Messed up Dependency Management

One of the most common pitfalls is poor dependency management, especially avoiding `find_package` and instead vendoring dependencies directly into your project. This leads to bloated repositories, duplicated code, and difficulties in updating or patching dependencies. Good CMake projects use `find_package` to locate and use system-installed libraries, making builds more maintainable and portable. Always prefer using `find_package` and properly installed packages over vendoring, unless absolutely necessary.

### 2. Using Variables Instead of Targets and Packages

Relying on variables (like `INCLUDE_DIRECTORIES` or `LINK_LIBRARIES`) instead of modern CMake targets and packages leads to fragile and hard-to-maintain build scripts. Variables can easily be overwritten or misused, causing subtle bugs. Modern CMake encourages the use of `target_link_libraries`, `target_include_directories`, and other target-based commands, which encapsulate build properties and dependencies. Always define and use targets for your libraries and executables, and link dependencies explicitly to those targets.

### 3. Writing Non-Portable CMake Code

Non-portable CMake code, such as hardcoding paths or using platform-specific commands without proper guards, makes your project difficult to build on different systems. This is a common source of frustration for contributors and users. Good CMake code uses generator expressions, platform checks, and avoids hardcoded values. Always test your CMake scripts on multiple platforms and use CMake's built-in mechanisms for portability.

### 4. Omitting CMakePresets to Configure the Project

CMakePresets provide a standardized way to configure and build projects, making it easier for new contributors to get started and for CI systems to build consistently. Omitting them means every developer must figure out their own configuration, leading to inconsistencies and wasted time. Good projects provide `CMakePresets.json` files with common configurations for development, testing, and release builds. Always include and maintain presets for your project.

### 5. Not Using Toolchain Files for Cross-Compilation or Multiplatform Builds

Cross-compiling or building for multiple platforms without toolchain files is error-prone and difficult to maintain. Toolchain files encapsulate compiler, linker, and system settings, making it easy to switch between build environments. Good CMake projects provide and document toolchain files for supported platforms. Always use and encourage toolchain files for cross-platform and cross-compilation scenarios.

### 6. Incomplete Library and Target Setup

Failing to properly set up libraries and targets—such as missing versioning, or incorrect use of `PUBLIC`, `PRIVATE`, and `INTERFACE` keywords—leads to dependency and linkage issues. This can cause downstream projects to break or behave unexpectedly. Good practice is to always specify visibility (`PUBLIC`, `PRIVATE`, `INTERFACE`) when linking libraries and to provide version information for your targets. Review your target setup and ensure all properties are correctly set.

### 7. Incorrect Testing Setup

A poor or missing testing setup means regressions go unnoticed and code quality suffers. Not integrating testing frameworks or not adding tests to the build process is a common mistake. Good CMake projects use `enable_testing()` and integrate with frameworks like CTest or GoogleTest, ensuring tests are easy to run and part of the CI process. Always set up and maintain a robust testing infrastructure in your CMake project.

---

By avoiding these common mistakes and following modern CMake best practices, you can make your build process more robust, maintainable, and enjoyable for everyone involved.
