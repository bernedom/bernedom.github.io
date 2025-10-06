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

`std::expected` (C++23) is a vocabulary type for functions that can either produce a value (success) or a well-defined recoverable error (failure) without throwing. It generalizes the intent behind `std::optional`: instead of “value or nothing”, you get “value *or* error payload”.

Key points:
- Success path is explicit (`expected<T,E>` holds `T`)
- Failure path is explicit (holds `E`)
- Zero-cost access in the success case (no heap)
- Works alongside (not instead of) exceptions
- Encourages documenting failure modes via the error type

## Basic Form

```cpp
#include <expected>
#include <string>
#include <iostream>

std::expected<int, std::string> parse_int(std::string_view txt) {
    try {
        size_t pos = 0;
        int v = std::stoi(std::string(txt), &pos);
        if (pos != txt.size())
            return std::unexpected("Trailing characters");
        return v; // implicit expected<int,string> construction
    } catch (std::exception const& ex) {
        return std::unexpected(std::string("Parse error: ") + ex.what());
    }
}

int main() {
    if (auto r = parse_int("42"); r) {
        std::cout << "Value = " << *r << "\n";
    } else {
        std::cout << "Error: " << r.error() << "\n";
    }
}
```

Access patterns:
- `r.has_value()` or `if (r)` checks success
- `*r` / `r.value()` gives the value (latter throws `bad_expected_access` if no value)
- `r.error()` yields the error object (only if !r)

## Why Not Just std::optional?
`std::optional<T>` only distinguishes “present” vs “absent”. You must invent an external channel (logs, out-params, magic enums) for error context. `std::expected<T,E>` bakes the error representation into the type signature, making intent self-documenting and enabling composition.

## A Realistic Scenario: QR Code Scanner

Design: Recoverable domain failures (e.g. “no QR code found”) return an error enum. Catastrophic issues (I/O, memory corruption, decoder invariants) throw exceptions.

```cpp
#include <expected>
#include <string>
#include <vector>
#include <span>

enum class QrScanError {
    NoCodeDetected,
    LowContrast,
    UnsupportedEncoding
};

std::expected<std::string, QrScanError>
decode_qr(std::span<const std::byte> imageData);

/*
Usage:
*/
void process_image(std::span<const std::byte> img) {
    try {
        if (auto r = decode_qr(img); r) {
            // Success
            // use *r
        } else {
            switch (r.error()) {
                case QrScanError::NoCodeDetected:     /* fallback */ break;
                case QrScanError::LowContrast:        /* maybe retry */ break;
                case QrScanError::UnsupportedEncoding:/* report */ break;
            }
        }
    } catch (const std::exception& ex) {
        // Truly exceptional: corrupted file, allocation failure, etc.
    }
}
```

This separation clarifies which failures callers must handle and which remain exceptional.

## Transforming and Chaining (Monadic Style)

`and_then`, `or_else`, and `transform` let you compose stages cleanly.

```cpp
#include <expected>
#include <string>
#include <cctype>

std::expected<std::string, std::string> fetch();
std::expected<int, std::string> to_int(std::string_view);

auto pipeline() {
    return fetch()
        .transform([](std::string s) { return s + "_suffix"; })
        .and_then([](std::string const& s) { return to_int(s); })
        .or_else([](std::string const& err) {
            // map error to a unified form
            return std::unexpected("pipeline: " + err);
        });
}
```

- `transform` maps the value if present, leaves error untouched.
- `and_then` expects a callable returning another `expected`, flattening nesting.
- `or_else` lets you transform the error.

## Interop With Exceptions

You can still throw where unwinding is cleaner (constructor invariants, impossible states, allocation failures). Use `expected` when:
- Caller is likely to recover or choose an alternate path
- Failures are part of normal control flow
- You want static exhaustiveness via an error enum

Use exceptions when:
- Handling site is distant and recovery is rare
- Failure indicates abnormal or truly exceptional conditions

## Choosing the Error Type

Common patterns:
- Enum class (compact, compile-time reviewed)
- `std::string` or `std::string_view` (flexible but less structured)
- Custom struct holding code + context (line, file offset, etc.)
- Lightweight error wrapper referencing shared static strings

```cpp
struct ParseError {
    enum class Code { UnexpectedChar, Range, Empty } code;
    int position;
};

std::expected<int, ParseError> parse_number(std::string_view txt);
```

## Providing Defaults

```cpp
int value_or_default(std::string_view s) {
    auto r = parse_int(s);
    return r.value_or(0); // 0 if error
}
```

## Converting Legacy APIs

Wrap a legacy function returning error codes:

```cpp
enum legacy_err { OK=0, NOT_FOUND=1, PERM=2 };

legacy_err legacy_lookup(int key, int* out);

std::expected<int, legacy_err> modern_lookup(int key) {
    int v;
    if (auto e = legacy_lookup(key, &v); e == OK)
        return v;
    return std::unexpected(e);
}
```

## Performance Notes

- Represents a discriminated union; typically same size as `T` plus space for `E` (aligned to max of both) plus a boolean.
- No heap allocations unless `T` or `E` allocate.
- Branch predictor friendly for predominantly-success paths.

## Pitfalls

- Do not overuse for every function; pure success functions return plain `T`.
- Avoid large `E` types; store references or lightweight handles if needed.
- Be explicit in public APIs; prefer `expected<result_type, error_enum>` over vague string errors when stability matters.

## Minimal End-to-End Example

```cpp
#include <expected>
#include <string>
#include <charconv>
#include <system_error>

enum class HexError { Empty, Invalid };

std::expected<unsigned, HexError> parse_hex(std::string_view s) {
    if (s.empty()) return std::unexpected(HexError::Empty);
    unsigned value = 0;
    auto first = s.data();
    auto last  = s.data() + s.size();
    auto res = std::from_chars(first, last, value, 16);
    if (res.ec != std::errc() || res.ptr != last)
        return std::unexpected(HexError::Invalid);
    return value;
}

std::string describe(HexError e) {
    switch (e) {
        case HexError::Empty:   return "input empty";
        case HexError::Invalid: return "invalid hex";
    }
    return "unknown";
}

int main() {
    for (auto txt : {"FF", "XYZ", ""}) {
        if (auto r = parse_hex(txt); r) {
            // success
        } else {
            auto msg = describe(r.error());
            (void)msg;
        }
    }
}
```

## Summary

`std::expected`:
- Documents recoverable failure modes in the type system
- Reduces implicit contracts and sentinel values
- Composes cleanly with functional-style helpers
- Complements (not replaces) exceptions

Adopt it where callers are expected to react to well-scoped failures. It improves clarity, testability, and intent.

