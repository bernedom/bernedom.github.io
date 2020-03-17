---
layout: post
title: Microbenchmarking with catch2 and github actions
thumbnail: images/cpp_logo.png
---

**"Do you have continous benchmarking for your code?"** Is a question I often ask when people talk about optimizing their code for performance. An surprisingly the answer is often a "No" and then some excuses on why not. One of the most common one being that it is hard to set up and run. Granted having a full-blown system-wide testing setup is often tough to do, but if you start small having a reliable performance indicator becomes easy. I will illustrate this by using [Catch2](https://github.com/catchorg/Catch2) for micro-benchmarking and [github actions](https://github.com/features/actions) to build a setup in less than an hour. 

# A word on virtual environments

Running benchmarks in a virtual, cloud-based environment such as github actions is often considered a no-no because these environments are notoriously unstable when it comes to performance. That is actually true so if you want exact numbers how your code performs there is no way around running it on the hardware and environment that matches the production environment. 
But even on an unstable environment one can deduce quite some value from the benchmarks, especially when comparing functions or going for changes in the [big-O behavior](https://en.wikipedia.org/wiki/Big_O_notation) 

# Setting up a benchmark

# Setting up github actions 

# Getting results