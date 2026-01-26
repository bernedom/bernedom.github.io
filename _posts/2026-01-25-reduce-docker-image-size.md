--- 
layout: post
title: "Saving money by reducing Docker image size for devcontainers"
description: "Devcontainers are a great way to provide a consistent development environment, but large Docker images can lead to increased costs and slower performance in CI. In this post, we explore strategies to reduce Docker image sizes effectively."
image: /images/secure-boot-yocto/secure-boot-yocto-thumb.jpg
hero_image: /images/secure-boot-yocto/secure-boot-yocto.jpg
hero_darken: true
tags: docker
lang: en
author: Dominik
---

**Devcontainers are a [great way to improve developer workflows](https://softwarecraft.ch/using-devcontainers-with-cpp/), but they tend to be large and bloated.** This is not just an inconvenience for developers who have to download these images, but it can also lead to increased costs and slower performance in CI environments where these images are frequently pulled and used. Depending on the CI provider, you might be charged based on the amount of data transferred or the time it takes to pull and start the containers, so small images can lead to significant cost savings over time. Let's look how to reduce Docker image sizes effectively on a real life example.

## A devcontainer example

Let's look at a real life example of a [devcontainer I use for creating Qt applications for android](https://github.com/bernedom/QtAndroidTemplate/). The container is based on ubuntu 24.04 and contains the following components:

* python, c++ build tools and common development utilities - installed over `apt`
* Qt 6.7.2 with android and desktop support - installed using `aqtinstall`
* Android SDK and NDK for armeabi-v7a and arm64-v8a and x86_64 - manudally installed using curl, unzip and sdkmanager
* Android emulator and debugging tools - installed using sdkmanager
* conan, cmake-format and other development tools - installed using pip

Given the requirements of Qt and and the android toolchains, the resulting image will be far from a slim in the best case. However a first [naive implementation of the devcontainer](https://github.com/bernedom/QtAndroidTemplate/blob/76dbf93698f05fa86b8e91bb4f2453ac8780915a/.devcontainer/Dockerfile) resulted in a whopping **9.3 GB** image size!

using `docker history --no-trunc <image-id>` we can see that the largest layers are. In this case we see several that stand out as using more than 1GB of space:

* The use of `apt-get install` to install packages results in a layer of 2.26 GB
* Installation of android SDK and NDK using sdkmanager results in layers of 2.2GB
* and then the various Qt components installed using aqtinstall result in layers of 300MB to 1.2GB each.

So let's look at how we can reduce the image size. one way to do this is to [use multi-stage builds](https://docs.docker.com/build/building/multi-stage/), where we can separate the build environment from the final runtime environment. The easiest 
