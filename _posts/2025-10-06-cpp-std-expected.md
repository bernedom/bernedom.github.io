---
author: Dominik
layout: post
title: "std::expected in C++23: A Better Way to Handle Errors"
description: "Practical introduction to std::expected: intent-revealing, structured error handling for recoverable failure paths in modern C++."
image: /images/cpp_logo.png
hero_image: /images/cpp_logo.png
hero_darken: true
tags: cpp, ai, cmake
---

**How to handle errors in C++ has been a constant point of debate.** Do you use exceptions, error code, out-parameters or return nullptrs on failure? And how do you convey information on the nature of the failure? With C++17 we got `std::optional` for "value or nothing" semantics, but it lacks error context. [C++23 - finally - introduces `std::expected`](https://en.cppreference.com/w/cpp/utility/expected.html), a type that encapsulates either a value or an error, making error handling explicit and composable. Let's explore how `std::expected` can improve your C++ code.

## `std::expected` in a nutshell

Semantically, `std::expected<T, E>` is a returnable type that can either hold a value of type `T` (indicating success) or an error of type `E` (indicating failure). This makes it clear to the caller that a function can fail and provides a structured way to handle that failure.

Let's look at a simple example of a function that computes the square root of a number, returning an error if the input is negative:

```cpp
#include <expected>
#include <cmath>

std::expected<double, std::string> safe_sqrt(double x) {
    if (x < 0) {
        return std::unexpected("Negative input");
    }
    return std::sqrt(x);
}
```

To use this function, you can check if the result is valid and handle the error accordingly:

```cpp
#include <iostream>

int main() {
    auto result = safe_sqrt(-1);
    if (result) {
        std::cout << "Square root: " << *result << '\n';
    } else {
        std::cout << "Error: " << result.error() << '\n';
    }
    return 0;
}

* expected vs optional vs exceptions
* 