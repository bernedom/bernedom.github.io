---
author: Dominik
layout: post
title: "Building a local AI agent with Llama.cpp and C++"
description: "Learn how to build a local AI agent using llama.cpp and C++. This article covers setting up your project with CMake, obtaining a suitable LLM model, and implementing basic model loading, prompt tokenization, and text generation. Ideal for those interested in running AI models on their own hardware without relying on cloud services."
image: /images/llamacpp/thumbnail.jpg
hero_image: /images/llamacpp/hero.png
hero_darken: true
tags: cpp ai cmake
---
author: Dominik

**Large Language Models (LLMs) and AI agents are everywhere and there are tons of online services that let you use them.** But what if you want to build your own, local AI agent that can run on your own hardware, without relying on cloud services? No problem - starting there is not as difficult as one might think. There is a great open source project called [llama.cpp](https://github.com/ggml-org/llama.cpp) that makes it easy to run LLMs on your own hardware. Let's see how to get stated with a simple AI agent using llama.cpp, CMake and C++. 

## Why build your own AI agent?

While tapping into an existing online service to build your custom AI agent might be convenient, there are several reasons why you might want to build your own. There might be privacy concerns, or you might need offline access to the agent or maybe you want to customize the agent to your specific needs. Building your own AI agent gives you full control over the model, the data and the functionality. You can tailor it to your specific use case and integrate it seamlessly into your existing systems. A great place to start building your own AI agent is the [llama.cpp](https://github.com/ggml-org/llama.cpp) project.

Llama.cpp is a C/C++ implementation of Facebook's LLaMA model that allows you to run LLMs on your own hardware. It is designed to be efficient and lightweight, making it suitable for running on a wide range of devices, from high-end servers to low-power edge devices. Llama.cpp supports various LLaMA models, including the smaller ones that can run on consumer-grade hardware. It offers a wide range of cross-platform support including various GPU backends for acceleration, but also runs on CPU only systems. So let's see how to get started with llama.cpp.

## Building a simple AI agent with llama.cpp

So let's build a simple executable that uses llama.cpp to answer simple prompts by using a pre-trained model. You can find the complete code on [on GitHub it the bernedom/LlamaPlayground repository](https://github.com/bernedom/LlamaPlayground) which is inspired by the [simple example provided in the llama.cpp repository](https://github.com/ggml-org/llama.cpp/tree/master/examples/simple). The executable will be called `LLamaPlayground` and can be used like this:

```
> LLamaPlayground -m ./models/mymodel.gguf What is the capital of Switzerland?

The capital of Switzerland is Bern.
```

To get started we need a few things:

* A C++17 compatible compiler and CMake
* llama.cpp as library, which we can get by using CMakes `FetchContent` module. (Unfortunately the conan module for llama.cpp is outdated at the time of writing)
* A LLM-Model as `.gguf` file which can be obtained from various sources, e.g. [Huggingface](https://huggingface.co/models?search=gguf)

### Setting up the project

Let's start by setting up a simple CMake project, that creates our executable and pulls in llama.cpp as a dependency. To kickstart your project with a basic CMake and dependency handling already set up, consider this [CMake/Conan/Catch2 Template](https://github.com/bernedom/CMakeConanCatchTemplate). 

In the `CMakeLists.txt` we need to pull in llama.cpp using `FetchContent` and link it to our executable like this

```cmake
...
include(FetchContent)
FetchContent_Declare(
        llama
        GIT_REPOSITORY https://github.com/ggml-org/llama.cpp.git
        GIT_TAG master
)
FetchContent_MakeAvailable(llama)
...
```
This gives us access to the `llama` target that we can link to our executable like this `target_link_libraries(LLamaPlayground PRIVATE llama)`.

{% include cmake-best-practices-ad.html %}

Next we need to obtain a model. You can find various models on [Huggingface](https://huggingface.co/models?search=gguf). For this example I downloaded the `ggml-org/gemma-3-1b-it-GGUF` model and placed it in a `models` folder next to the executable. This is a fairly lightweight model that accepts text or images as input and generates text as output.

The easiest way to get the model is to use the [huggingface CLI](https://huggingface.co/docs/huggingface_hub/en/guides/cli). You can install it using pip:

```
pip install huggingface_hub[cli]
```
To download the model, you can use the following command:

```
hf download ggml-org/gemma-3-1b-it-GGUF --local-dir ./models
```

And with that we are ready to start coding. 

### Coding the AI agent

Our simple AI agent will have to do three basig things:

1. **Model Loading**: Loading the pre-trained model file.
1. **Prompt Tokenization**: Converting the input prompt into tokens.
1. **Text Generation**: Using the model to predict and generate tokens.

I'll skip the boilerplate code to parse the arguments and focus on the llama.cpp specific parts, for the full code head over to the [Github repository containing the example code](https://github.com/bernedom/LlamaPlayground)

#### Model Loading

First let's load the model and initialize it. 

```cpp
llama_model_params model_params = llama_model_default_params();
model_params.n_gpu_layers = ngl;

llama_model *model = llama_model_load_from_file(model_path.c_str(), model_params);
```

For simplicity we use the default model parameters, but you can customize them as needed. To illustrate how this works, the `n_gpu_layers` parameter specifies how many layers of the model should be offloaded to the GPU for acceleration. If you don't have a GPU or want to run on CPU only, you can set this to `0`. That is already all the magic needed to load the model, lets go to the next step **Prompt Tokenization**.

#### Prompt Tokenization

To convert the user-supplied prompt into tokens we need to convert it from a string into tokens that the model can understand. The prompt is tokenized using the model's vocabulary. Tokenization involves splitting the input string into smaller units (tokens) that the model can process, these are no longer human readable strings but rather integer values that represent words or subwords. 

```cpp
const llama_vocab *vocab = llama_model_get_vocab(model);
const int n_prompt = -llama_tokenize(vocab, prompt.c_str(), prompt.size(), nullptr, 0, true, true);

std::vector<llama_token> prompt_tokens(n_prompt);
llama_tokenize(vocab, prompt.c_str(), prompt.size(), prompt_tokens.data(), prompt_tokens.size(), true, true);
```

The first call to `llama_tokenize` with a `nullptr` for the output tokens is used to determine how many tokens are needed for the prompt. It's a particularity of llama.cpp that the first call returns a negative value, because it failed to write the tokens to a `nullptr`. The absolute value of the returned integer indicates the number of tokens required. 

The second call actually performs the tokenization and fills the `prompt_tokens` vector with the resulting tokens. With this we can initialize the context for the model and prepare it for text generation. 

```cpp
llama_context_params ctx_params = llama_context_default_params();
ctx_params.n_ctx = n_prompt + n_predict - 1;
ctx_params.n_batch = n_prompt;

llama_context *ctx = llama_init_from_model(model, ctx_params);
```

The context defines the model's working environment, including the number of tokens to process and the batch size. For our small example we set the context size to the sum of the prompt tokens and the number of tokens we want to predict. The batch size is set to the number of prompt tokens, which means that the model will process all prompt tokens in one go. 

Now that we have the prompt tokenized, we can move on to the final step: **Text Generation**.

#### Text Generation

The main loop evaluates the model and generates tokens iteratively. Each token is sampled, converted back to text, and appended to the output. for this we loop until we reach the desired number of predicted tokens or encounter an end-of-generation token.

```cpp
llama_batch batch = llama_batch_get_one(prompt_tokens.data(), prompt_tokens.size());

for (int n_pos = 0; n_pos + batch.n_tokens < n_prompt + n_predict;) {
    llama_decode(ctx, batch);

    llama_token new_token_id = llama_sampler_sample(smpl, ctx, -1);
    if (llama_vocab_is_eog(vocab, new_token_id)) break;

    char buf[128];
    int n = llama_token_to_piece(vocab, new_token_id, buf, sizeof(buf), 0, true);
    std::cout << std::string(buf, n);

    batch = llama_batch_get_one(&new_token_id, 1);
}
```

First we fetch a batch of tokens to process, in our case this might be the entire prompt, but since we might want to extend to larger prompts, we enter a loop. 

Inside the loop the current batch is decoded using `llama_decode`, which processes the tokens and updates the model's internal state. Then we sample a new token using `llama_sampler_sample`, which selects the next token based on the model's predictions. If the sampled token is an end-of-generation token, we break out of the loop.

The sampled token is then converted back to a human-readable string using `llama_token_to_piece` and printed to the console. Finally, we prepare the next batch containing just the newly generated token for the next iteration of the loop.
And that is all the code we need to build a simple AI agent using llama.cpp. You can find the complete code on [on GitHub it the bernedom/LlamaPlayground repository](https://github.com/bernedom/LlamaPlayground).

To run the AI agent, you need to compile the code using CMake and your C++ compiler. Make sure you have the model file in the specified path. Beware that even the smaller models can be quite memory/hungry, so make sure you have enough RAM available.

### Whats next?

This is a very simple example to get you started with llama.cpp and building your own AI agent. As the talk of edge AI and on-device AI is getting more and more popular, llama.cpp might be a great starting point to explore this field. There are of course many more things to explore be it towards more efficiency or hardware acceleration through CUDA or Vulkan or more advanced prompt handling and context management. Whether you find any practical use for it or just play around with it, I hope this post helped you to get started.



