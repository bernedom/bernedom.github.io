---
layout: post
title: Microbenchmarking with catch2 and github actions
thumbnail: images/cpp_logo.png
---

**"Do you have continuous benchmarking for your code?"** Is a question I often ask when people talk about optimizing their code for performance. An surprisingly the answer is often a "No" and then some excuses on why not. One of the most common one being that it is hard to set up and run. Granted having a full-blown system-wide testing setup is often tough to do, but if you start small, setting up a reliable performance indicator becomes easy. I will illustrate this by using [Catch2](https://github.com/catchorg/Catch2) for micro-benchmarking and [github actions](https://github.com/features/actions) to build a setup in less than an hour. Check out the [SI library](https://github.com/bernedom/SI) for a running example. 

# A word on virtual environments

Running benchmarks in a virtual, cloud-based environment such as github actions is often considered a no-no because these environments are notoriously unstable when it comes to performance. That is actually true so if you want exact numbers how your code performs there is no way around running it on the hardware and environment that matches the production environment. 
But even on an unstable environment one can deduce quite some value from the benchmarks, especially when comparing performance of different functions or going for changes in the [big-O behavior](https://en.wikipedia.org/wiki/Big_O_notation) 

# creating a benchmark with catch2

Since Catch2 is a header only library setting it up is as easy as downloading the header and putting it into an include directory, although I prefer to use [the conan.io package](https://bintray.com/catchorg/Catch2). As of version 2.11 benchmarking is disabled by default and needs to be enabled by setting the `CATCH_CONFIG_ENABLE_BENCHMARKING` compiler flag. 


Assuming we would like to benchmark a function `fibnoacci(unsigned int n)` which returns the n-th fibonacci number setting up a benchmark is easy by wrapping the function call inside the `BENCHMARK`-macro provided by catch. 

```cpp
TEST_CASE("Fibonacci") {
    BENCHMARK("Fibonacci 20") {
        return fibonacci(20);
    };

    BENCHMARK("Fibonacci 30") {
        return Fibonacci(30);
    };


```

<details>
<summary markdown="span">
When compiling (in release mode) and running this produces an output like this[^1] (click to expand)
</summary>

```text
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Catch2_bench is a Catch v2.11.0 host application.
Run with -? for options

-------------------------------------------------------------------------------
Fibonacci
-------------------------------------------------------------------------------
/my/project/dir/catch2_bench.cpp:5
...............................................................................

benchmark name                                  samples       iterations    estimated
                                                mean          low mean      high mean
                                                std dev       low std dev   high std dev
-------------------------------------------------------------------------------
Fibonacci 10                                              100           134     4.9848 ms 
                                                       371 ns        357 ns        391 ns 
                                                        84 ns         63 ns        113 ns 
                                                                                          
Fibonacci 20                                              100             2      8.829 ms 
                                                    44.016 us     42.521 us     46.256 us 
                                                     9.156 us       6.73 us     12.104 us 
                                                                                          

===============================================================================
test cases: 1 | 1 passed
assertions: - none -

```
</details>

Benchmarks can be placed in any regular unit test if desired, but I find it good practice to separate the two, in order not to pollute my benchmarks with code only relevant for testing or accidentally running a benchmark on a mocked class. 
Check out the [official documentation of catch2](https://github.com/catchorg/Catch2/blob/master/docs/benchmarks.md) to get all the possibilities. 

# Setting up the github action 

To get continous benchmark with [Github actions](https://github.com/features/actions) I'm using (and low-key contributing to) [Continous Benchmark github action](https://github.com/marketplace/actions/continuous-benchmark). This action allows us to collect benchmark results and [display them on the github pages](https://si.dominikberner.ch/dev/bench/). 

1. build the benchmarks
2. run the benchmarks and store the results in a file
3. pasre the file and store the results 
   1. If the results are slower than a certain threshold (200% in this example) notify the user
4. let github generate a new page 

An excerpt from the `.yml` file for running the action: 
```yml
name: Build and run benchmarks with Catch2
run: |
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    cmake --build . --config Release --target SI_unit_benchmarks
    ./test/bin/SI_unit_benchmarks | tee benchmark_result.txt
- name: parse and store benchmark result
if: github.ref == 'refs/heads/master'
uses: rhysd/github-action-benchmark@v1.7.0
with:
    name: Catch2 Benchmark
    tool: "catch2"
    output-file-path: build/benchmark_result.txt
    github-token: ${{ secrets.PERSONAL_GITHUB_TOKEN }}
    auto-push: true
    alert-threshold: "200%"
    comment-on-alert: true
    fail-on-alert: true
    alert-comment-cc-users: "@bernedom"
```

In order to be able to store the results, the action needs permission to push commits to the `ghpages` branch. Notice the `secrets.PERSONAL_GITHUB_TOKEN` in the yml file. This is a [personal access token](https://github.com/settings/tokens) created in you github account. 

Enabling the results to be published as a web site is as simple as [setting up github pages](https://pages.github.com/)

# Getting results

This is all that is needed to set up. I usually set the action up to run on each push on `master` or when manually triggered. The results are notoriously shaky because of the virtual environment they are running in. Nevertheless After a few run it is usually possible to read a few trends out of the result. This allows for instance to compare run times before and after a refactoring or comparison of alternative approaches for the same functionality.


---

[^1]: Different formats such as xml are supported by catch, but the current github action only supports parsing of text output