---
layout: post
title: "Building a custom AI agent with Llama.cpp and C++"
description: ""
image: /images/artifact-based-ci/thumbnail.png
hero_image: /images/artifact-based-ci/hero.png
hero_darken: true
---

**Large Language Models (LLMs) and AI agents are everywhere and there are tons of online services that let you use them.** But what if you want to build your own, local AI agent that can run on your own hardware, without relying on cloud services? No problem - starting there is not as difficult as one might thing. There is a great open source project called [llama.cpp](https://github.com/ggml-org/llama.cpp) that makes it easy to run LLMs on your own hardware. Let's see how to get stated with a simple AI agent using llama.cpp, CMake and C++.

## Why build your own AI agent?

While tapping into an existing online service to build your custom AI agent might be convenient, there are several reasons why you might want to build your own. There might be privacy concerns, or you might need offline access to the agent or maybe you want to customize the agent to your specific needs. Building your own AI agent gives you full control over the model, the data and the functionality. You can tailor it to your specific use case and integrate it seamlessly into your existing systems. A great place to start building your own AI agent is the [llama.cpp](https://github.com/ggml-org/llama.cpp) project.

Llama.cpp is a C/C++ implementation of Facebook's LLaMA model that allows you to run LLMs on your own hardware. It is designed to be efficient and lightweight, making it suitable for running on a wide range of devices, from high-end servers to low-power edge devices. Llama.cpp supports various LLaMA models, including the smaller ones that can run on consumer-grade hardware. It offers a wide range of cross-platform support including various GPU backends for acceleration, but also runs on CPU only systems. So let's see how to get started with llama.cpp. 

## Building a simple AI agent with llama.cpp

So let's build a simple executable that uses llama.cpp to answer simple prompts like this one. You can find the complete code on [My GitHub](https://github.com/bernedom/LlamaPlayground)

```
> LLamaPlayground What is the capital of Switzerland?
The capital of Switzerland is Bern.
```

To get started we need a few things:

* A C++17 compatible compiler and CMake
* llama.cpp as library, which we can get by using CMakes `FetchContent` module. (Unfortunately the conan module for llama.cpp is outdated at the time of writing)
* A LLM-Model as `.gguf` file which can be obtained from various sources, e.g. [Huggingface](https://huggingface.co/models?search=gguf)












