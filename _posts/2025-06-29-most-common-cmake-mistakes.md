---
layout: post
title: "The 7 CMake anti-patterns that keep wasting your time"
description: "CMake is powerful, but often blamed for bad build experiences. Most of the frustration, though, comes from avoidable mistakes. Here are 7 common CMake anti-patterns that waste your time—and how to fix them."
thumbnail: images/cmake-logo.png
---

If that sounds familiar, you're not alone. CMake has a reputation for being painful to use - but most of that pain comes from bad practices, not the tool itself.In this post, I’ll break down 7 of the most common CMake anti-patterns I see in real projects. These issues often creep in from legacy setups or lack of modern CMake knowledge, and they tend to slow teams down, cause frustration, and make build systems nearly unmaintainable.

Let’s fix that.

## 1. Vendoring Everything Instead of Using `find_package`

One of the worst time-wasters: bundling dependencies directly into your project (aka "vendoring"), either as source code or worse, as precompiled binaries.

It bloats your repo, makes updates a hassle, and creates fragile builds. Modern CMake projects should use `find_package` to locate and integrate dependencies cleanly. Many libraries now provide CMake config files out of the box. If they don't, writing your own `Find<Package>.cmake` is a good step toward future-proofing.

{% include cmake-best-practices-ad.html %}

Even better, tools like [Conan or vcpkg](https://dominikberner.ch/conan-as-cmake-dependency-provider/) can take care of dependency management for you. Stop hardcoding paths—let CMake and your package manager handle it.

## 2. Not using CMakePresets

[CMake Presets are a game-changer](https://dominikberner.ch/cmake-presets-best-practices/) - use them! Since their introduction, they’ve made managing multiple build configurations *so* much easier. Instead of fiddling with command-line flags or custom scripts, you can define builds cleanly in `CMakePresets.json`.

> CMake presets are one of the most impactful features introduced in CMake since the introduction of targets.

Presets reduce errors, improve consistency across teams, and help CI pipelines stay clean. By providing a standardized way to configure good build configurations for development, testing, and release builds, CMakePresets can significantly reduce the entry barrier for new contributors and help ensure that everyone is using the same build settings.  Always include and maintain presets for your project, and encourage contributors to use them or create their own `CMakeUserPresets.json` files for their specific needs.

## 3. Still Using Global Variables Instead of Targets

Modern CMake is all about *targets* - and has been for over a decade. Yet many projects still rely on global variables and configuration, making things messy and error-prone.

Targets make everything modular, scoped, and easier to maintain. Use commands like `target_link_libraries`, `target_include_directories`, and `target_compile_options` to apply settings *only* where needed.

And don’t just slap `PUBLIC` everywhere. Use `PRIVATE` by default, and only expose what’s absolutely necessary. You'll reduce build times and avoid unnecessary rebuilds.

And if you still need global project settings, use `options()` with good descriptions and defaults, but keep them minimal. The goal is to avoid global state as much as possible.

## 4. Writing Non-Portable Build Scripts

It’s easy to hack together something that works on your machine and CMake's possibility to call external commands and scripts is very powerful. But that doesn't mean it's portable. Using platform-specific paths, scripts, or flags ties your build to a single setup—and breaks everything elsewhere.

Stick to CMake's built-in features:

- Use `target_compile_options`, `target_compile_definitions`, etc., instead of global flags.
- Stick global compiler flags into CMake presets.
- Use `cmake -P` and `cmake -E` for scripting, not Bash or PowerShell.
- Set up toolchain files for cross-compilation.
- Use CMake's built-in function to find things like libraries and include directories - No hardcoded paths in CMakeLists.txt!

Portability isn’t just for open-source projects. It’ll save you headaches even in single-platform codebases—especially when onboarding new devs or upgrading tools.

## 5. Half-Baked Library Setup

Ever try using a library only to discover it’s missing version info, has broken exports, or forces a pile of transitive includes on you?

That’s what happens when `target` usage is incomplete or sloppy.

Don’t just make everything `PUBLIC`. Be precise with `PRIVATE`, `PUBLIC`, and `INTERFACE`. Set symbol visibility correctly, especially for shared libs. And always include version info (`VERSION`, `SOVERSION`) for libraries - it helps tools, consumers, and future-you.

For a solid setup, [here’s a line-by-line guide](https://dominikberner.ch/cmake-library-setup/).

## 6. No Install Instructions

You might think install rules don’t matter if you’re not publishing a library. But even in internal projects, a clean `install()` setup can make packaging, CI pipelines, or dev workflows way smoother.

It’s not hard: a few lines in your `CMakeLists.txt` go a long way. Think of it as a foundation for future packaging, or just making builds easier to deploy locally.

## 7. Neglecting Maintenance of Your CMakeLists.txt

CMake scripts aren't “write-once” files. They need love too.

Old, bloated, or inconsistent `CMakeLists.txt` files are painful to work with and a nightmare for newcomers. Regularly refactor and clean up your build scripts - just like you do with code.

Update to modern CMake practices. Drop old workarounds. Add comments. Keep dependencies clean. You’ll thank yourself later.

## How to absolve these sins

If your team is grumbling about CMake, chances are you’re stuck in one - or several - of these anti-patterns. But you don’t have to fix everything overnight.

Which one hurts the most depends on the project and the team, but in general, the anti-patterns often go hand in hand. Modernize your CMake scripts and tackle one thing at the time and each step brings back a little bit of joy to the build process.

{% include cmake-best-practices-ad.html %}

Even if you can't make things perfect, starting with small steps can lead quickly to improvements. Just applying `PRIVATE` and `PUBLIC` correctly can go a long way, replacing hardcoded paths with `find_package` and using CMake's built-in functions to find libraries and include directories can make the build process more robust and portable. And usually with every step you take, you will find that the build process becomes easier to understand and maintain, leading to a more enjoyable development experience for everyone involved.
