---
layout: post
title: Reproducable build environments for C++ using docker
description: How to set up a build environment for building C++ applications with docker and visual studio codes remote container environment (devcontainer)
thumbnail: images/kickstart-agile-project/thumbnail.jpg
---

**"But it compiles on MY machine!"** Is one of the phrases that every C++ coder hates. Even with CMake building a C++ app is often hard, because of missing system dependencies, or people have different compiler runtimes installed or are just building with another flavor of make, ninja etc. But thanks to the [remote container extension](https://code.visualstudio.com/docs/remote/containers-tutorial) of visual studio code this has gotten much easier. 

This allows to set up a complete dev-environment inside a docker container and fully develop and debug it inside the container, without any additional fiddling. 

{%include figure.html url="images/devcontainer/architecture-containers.png" description="Overview about how devcontainers work" source="https://code.visualstudio.com/docs/remote/containers" %}

## A 10000-mile overview

What you need is a docker (podman would also work) container containing all your requirements and a `devcontainer.json` file describing how to use your container. In our example we will set up a customized container for creating and debugging a qt-application. For extra convenience we will also include some developer tools and vscode extensions into the container. Once set up vscode will connect to the container, install all specified extensions and run a server to accept it's commands. After that all operations will be done in the running container. 

## Project structure

The devcontainer configuration is stored in a `devcontainer.json` file either in a folder named `.devcontainer` or named `.devcontainer.json` in the root of your project. I prefer the folder approach, because it is a bit easier to work with `Dockerfiles` and because it lets me keep all the needed files together. 

```bash
├── CMakeLists.txt
├── .devcontainer
│   ├── devcontainer.json
│   └── Dockerfile (Optional)
└── src
    └── main.cpp
```

## devcontainer.json



```json
{
    "build": {
        "dockerfile": "Dockerfile"
    },
    "extensions": [
        "ms-vscode.cpptools",
        "ms-vscode.cmake-tools",
        "vadimcn.vscode-lldb",
        "cheshirekow.cmake-format"
    ],
    "remoteEnv": {
        "DISPLAY": ":0"
    },
    "runArgs": [
        "--net=host",
        "--device=/dev/dri:/dev/dri"
    ],
    "containerUser": "builder"
}
```
## Dockerfile

```Dockerfile
FROM bbvch/conan_qt-5.15.2_builder_gcc9

## Add a dedicated user for building
RUN addgroup builder && useradd -ms /bin/bash -g builder builder
RUN adduser builder sudo
RUN echo "builder:builder" | chpasswd


#install git shell extension
RUN curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > /home/builder/.bash_git && echo "source /home/builder/.bash_git" >> ~/.bashrc
RUN sed -Ei 's/(PS1=.*)(\\\[\\033\[00m\\\]\\\$.*)/\1\\[\\033[01;33m\\]$(__git_ps1)\2/p' /home/builder/.bashrc
```

## How to use 

* reopen in container - done


* Show example dockerfile (small)
* Show devcontainer.json
