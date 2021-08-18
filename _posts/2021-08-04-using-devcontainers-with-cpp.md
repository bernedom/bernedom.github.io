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

Having the build environment inside a container is a major game changer. First it helps to ensure that all developers have exactly the same dependencies installed, but it goes further. All major CI systems include support for container based building, the same container that runs on a developers machine can be used to build your code on the server. This kind of consistency makes it very easy to create consistent builds. Using dev-containers helps even more, because the definition of the container is stored along the code in a `Dockerfile` and the `devcontainer.json`. So if this is put under version control each build provides the information about the respective build system set up as well. So how does this magic work? 

## Devcontainers in a nutshell

What you need is a docker (podman would also work) container containing all your requirements and a `devcontainer.json` file describing how to use your container. In our example, we will set up a customized container for creating and debugging a qt-application. For extra convenience, we will also include some developer tools and vscode extensions into the container. Once set up vscode will connect to the container, install all specified extensions and run a server to accept it's commands. After that all operations will be done in the running container. 

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

Let's start with a simple `Dockerfile`

```Dockerfile
FROM conanio/clang10:1.39.0

USER root

RUN  apt-get update; \
    apt-get -y install --fix-missing \
    gdb \
    sudo \
    curl \
    bash-completion \
    vim 
    

USER conan

#install git shell extension
RUN curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git && echo "source ~/.bash_git" >> ~/.bashrc
RUN sed -Ei 's/(PS1=.*)(\\\[\\033\[00m\\\]\\\$.*)/\1\\[\\033[01;33m\\]$(__git_ps1)\2/p' ~/.bashrc
```

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
}


```
## Dockerfile



## How to use 

* reopen in container - done


* Show example dockerfile (small)
* Show devcontainer.json
