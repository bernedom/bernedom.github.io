---
layout: post
title:  "The 5 most common CMake mistakes"
description: "CMake is a powerful tool, with a reputation of being hard to use. However, if used correctly, most of the pain points can be avoided. Here are the 5 most common mistakes I see when using CMake."
thumbnail: images/cmake-logo.png
---

**"CMake is hard to use and our build processes are a mess!"** CMake often has the reputation of being hard to use, but this is often due to common mistakes that can be easily avoided. In this post, I will cover the 5 most common mistakes I see when using CMake and how to avoid them.

The most common mistakes from my experience are:

* Messed up dependency management - notably not using `find_package`, but relying on vendoring.
* Using variables instead of targets and packages.
* writing non-portable CMake code.
* Omitting CMakePresets to configure the project.
* Not using toolchain files for cross-compilation or multiplatform builds.
* incomplete library and target setup, missing versioning and messing up PUBLIC/PRIVATE/INTERFACE usage.
* Incorrect testing setup.
