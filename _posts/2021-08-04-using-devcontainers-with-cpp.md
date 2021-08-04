---
layout: post
title: Reproducable buildenvironments for C++ using docker
description: Building C++ projects can be fiddly, but thanks to vscodes devcontainer this gets much easier
thumbnail: images/kickstart-agile-project/thumbnail.jpg
---

**"But it compiles on MY machine!"** Is one of the phrases that every C++ coder hates. Even with CMake building a C++ app is often hard, because of missing system dependencies, or people have different compiler runtimes installed or are just building with another flavor of make, ninja etc. But thanks to the [remote container extension](https://code.visualstudio.com/docs/remote/containers-tutorial) of visual studio code this has gotten much easier. 

This allows to set up a complete dev-environment inside a docker container and fully develop and debug it inside the container, without any additional fiddling. 

XXX insert image with overview

## A 10000 mile overview

What you need is a docker container either as Dockerfile or as an image from dockerhub. 
* Show example dockerfile (small)
* Show devcontainer.json
* Show project setup