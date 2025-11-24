--- 
layout: post
title: "std::expected in C++23: A Better Way to Handle Errors"
description: "Practical introduction to std::expected: intent-revealing, structured error handling for recoverable failure paths in modern C++."
image: /images/cpp_logo.png
hero_image: /images/cpp_logo.png
hero_darken: true
tags: cpp 
---

**How to handle errors in C++ has been a constant point of debate.** Do you use exceptions, error code, out-parameters or return nullptrs on failure? And how do you convey information on the nature of the failure? With C++17 we got `std::optional` for "value or nothing" semantics, but it lacks error context. [C++23 - finally - introduces `std::expected`](https://en.cppreference.com/w/cpp/utility/expected.html), a type that encapsulates either a value or an error, making error handling explicit and composable. Let's explore how `std::expected` can improve your C++ code.

## `std::expected` in a nutshell

At the core, `std::expected<T, E>` is a returnable type that can either hold a value of type `T` (indicating success) or an error of type `E` (indicating failure). This makes it clear to the caller that a function can fail and provides a structured way to handle that failure.

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

...

// Usage
const auto result = safe_sqrt(-1);
if (result) {
    std::cout << "Square root: " << *result << '\n';
} else {
    std::cout << "Error: " << result.error() << '\n';
}

```
In this example, `safe_sqrt` returns an `std::expected<double, std::string>`. If the input is valid, it returns the square root; otherwise, it returns an error message. The caller can then check if the result is valid and handle the error accordingly. So how does this compare to traditional error handling methods?

### Comparison to Traditional Error Handling

Before `std::expected`, there were typically two main approaches to error handling in C++: exceptions and error codes. While exceptions can be powerful, they typically bring with them more complexity in control flow and then there is the discussion which errors should cause an exception to be thrown and which should not. The benefit of exceptions is that they allow for clean separation of error handling code and for propagation of errors up the call stack. 
Error codes on the other hand tend to either clutter the code by requiring out-parameters or have the problem of being either ignored or misunderstood by the caller. While [nodiscard](https://en.cppreference.com/w/cpp/language/attributes/nodiscard) can help with ignored return values, it still does not solve the problem that the caller has to semantically understand the meaning of the return value. 

`std::expected` provides a middle ground. It makes error handling explicit in the type system, allowing to pass semantic information about the error back to the caller. The beauty of `std::expected`is also, that it can help to discern between expected or recoverable errors (e.g. file not found, invalid input) and unexpected or unrecoverable errors (e.g. out of memory, logic errors) which should still be handled via exceptions. 

> **Tip:** Use `std::expected` for recoverable errors where the caller can take action based on the error, and reserve exceptions for truly exceptional situations.

Let's look at a more complex example that demonstrates how `std::expected` can be used in a real-world scenario.

### Real world example: Reading a QR code from an image

Let's suppose we want to write a function that reads a QR code from binary image data. The function generally has three paths:

1. The image contains a valid QR code and we can return the decoded string.
2. The image does not contain a QR code and we want to return an error indicating that.
3. The image data is unreadable (e.g. corrupted or unrecognizable format) and we want to throw an exception.

While the first two paths are expected and recoverable errors, the third path is an unexpected error that should be handled via exceptions. So the implementation could look like this:

```cpp
#include <expected>
#include <string>
#include <stdexcept>
#include <vector>   

std::expected<std::string, std::string> read_qr_code(std::vector<uint8_t> const& image_data) {
    
    if (image_data.empty() || check_if_corrupted(image_data)) {
        throw std::invalid_argument("Invalid image data");
    }

    // Assume parse_image_data is a function that parses the image data and returns the QR code string or throws on failure
    std::string parsed_data = parse_image_data(image_data); // May throw exceptions on failure

    if (parsed_data.empty()) {
        return std::unexpected("No QR code found");
    }

    return parsed_data;
}
```

Note that in this example, both the success and error type are strings, but they could be any type. In a lot of cases, it might still make sense to use an enum or a custom error type for the error case to make it more structured. However, by using `std::expected`, we already are able to add a lot more context to the function without cluttering the code. This already is a big improvement over returning, but there is more. `std::expected` also provides a set of powerful combinators for composing operations that may fail, allowing for more elegant error handling.

### Monadic chaining with `and_then`

One of the benefits of `std::expected` is that it allows for [monadic chaining](https://en.wikipedia.org/wiki/Monad_(functional_programming)), A technique widely used in functional programming. Monadic chaining lets you compose a sequence of operations that may fail, without deeply nested `if`/`else`. With `std::expected`, you chain:
- `and_then` when the next step itself may fail and returns another `expected`.
- `transform` when the next step cannot fail and just maps the value.
- `or_else` to act on or recover from an error.

Below is a continuation of the QR example, showing a pipeline that:
1) reads the QR payload,
2) validates it,
3) parses it as a URI,
4) extracts the host (pure mapping),
5) adds context to the error if anything failed.

```cpp
// Reuse the earlier read_qr_code signature:
// std::expected<std::string, std::string> read_qr_code(const std::vector<uint8_t>&);

#include <expected>
#include <string>
#include <vector>

struct Uri {
    std::string scheme;
    std::string host;
    std::string path;
};

std::expected<std::string, std::string>
validate_payload(std::string const& s) {
    if (s.empty()) {
        return std::unexpected("Empty QR payload");
    }
    if (s.size() > 4096) { // arbitrary sanity limit
        return std::unexpected("QR payload too large");
    }
    return s; // valid as-is
}

std::expected<Uri, std::string>
parse_uri(std::string const& s) {
    auto starts_with = [&](std::string const& p) {
        return s.rfind(p, 0) == 0;
    };

    Uri u;
    if (starts_with("https://")) {
        u.scheme = "https";
    } else if (starts_with("http://")) {
        u.scheme = "http";
    } else {
        return std::unexpected("Not an http(s) URI");
    }

    // very naive split: scheme://host/path
    auto pos = s.find("://");
    auto rest = s.substr(pos + 3);
    auto slash = rest.find('/');
    if (slash == std::string::npos) {
        u.host = rest;
        u.path = "/";
    } else {
        u.host = rest.substr(0, slash);
        u.path = rest.substr(slash);
    }
    if (u.host.empty()) {
        return std::unexpected("Missing host");
    }
    return u;
}

std::string host_from(Uri const& u) {
    return u.host; // pure mapping, cannot fail
}

std::expected<std::string, std::string>
annotate_error(std::string const& err) {
    return std::unexpected(std::string{"QR processing failed: "} + err);
}

// Usage: linear, early-exiting pipeline
std::expected<std::string, std::string>
extract_qr_host(std::vector<uint8_t> const& image) {
    return read_qr_code(image)
        .and_then(validate_payload)        // may fail -> expected<Payload, E>
        .and_then(parse_uri)               // may fail -> expected<Uri, E>
        .transform(host_from)              // cannot fail -> expected<std::string, E>
        .or_else(annotate_error);          // act on error path, keep E the same
}
```

As we see, the resulting code in `extract_qr_host` is linear and easy to read. Each step is clearly defined, and error handling is centralized without deeply nested conditionals. The use of `and_then`, `transform`, and `or_else` makes the intent of each operation explicit. 

There are some pitfalls and good practices to keep in mind when using monadic chaining with `std::expected`:

* Keep the error type `E` consistent across `and_then`/`or_else` steps. If you must change it, use `transform_error`.
* Use `and_then` only with functions that return `expected<..., E>`. Use `transform` for pure mappings returning plain values.
* The chain short-circuits on the first error, returning that error downstream. So having a catch-all `or_else` at the end is a good practice.
* If a step can throw, those exceptions still propagate unless caught and converted to `std::unexpected`.
* Prefer passing by `const&` in chain steps to avoid copies or use move semantics. However the guaranteed copy elision in C++17 and later often makes this less of a concern.

With these practices in mind, `std::expected` and its combinators can greatly enhance the clarity and robustness of error handling in your C++ code.

## final thoughts

With the arrival of `std::expected` in C++23 there is another powerful tool in C++ to allow more expressive code in a functional programming style. This can make applications that do a lot of data processing and have many recoverable failure paths much cleaner and easier to maintain. While it does not replace exceptions for unrecoverable errors, it nicely complements them by providing a structured way to handle expected errors. And the beauty of it is, that it still works seamlessly with existing C++ code and libraries - So no need to go all in and change it everywhere. So give it a try in your next C++ project and see how it can improve your error handling!

---

While `std::expected` became part of the C++ standard with C++23, it has been around for quite some time as an [open-source library](https://github.com/TartanLlama/expected) by Sy Brand before that.