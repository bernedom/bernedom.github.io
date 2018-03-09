---
layout: post
title: Standard Attributes - CleanCode for C++17
thumbnail: images/cpp_logo.png
---

**Good code is self-documenting** - We coders love this sentence and with the standard attributes available since C++11 we are one step closer to this utopia. 

The first standard attributes ```noreturn``` and ```carries_dependency``` are already available since C++11. C++14 brought us the very much loved ```deprecated``` and with C++17 we now got ```fallthrough```, ```nodiscard``` and ```maybe_unused```.

Additionally, the introduction of the ```[[]]``` notation gave us an answer for the compiler specific syntaxes like ```#pragma```, ```__attribute__()```, ```__declspec``` and whatever else there is out there. The attributes together with the unified notation allows us now, as CleanCode dictates, to explicitly state a specific intent for of the coder, static code analyzers and even the compiler. 


## [[noreturn]] (C++11)

This should not be the norm, but there are certain cases in which functions to not return properly. An example is a call to an ```exit()``` or if there is always an exception thrown. In this case the function should be decorated with ```[[noreturn]]]``` to give a hint that this is a special method. But beware: should any function decorated like this return normally, the behavior is undefined. 

```cpp
[[noreturn]]void always_throw() { throw 123; };
```

## [[deprecated]] (C++14)

During the lifetime of a software it is often the case that parts of the code should no longer be used, for instance because there is a new and better implementation available. With the attribute ```[[deprecated]]``` can such parts of the code be annotated. Not just functions, but also classes and even namespaces, template specialisations and enums can be annotated. C++17 added an option to decorate the attribute with a string to give the user a hint for possible migrations. If code that is annotated like this is used the compiler prints out a warning. 

```cpp
// Deprecation with a reason
[[deprecated("black magic is evil")]] void black_magic(){};

// generates a compiler warning if called
[[deprecated]] void ancient_magic() {}
```

## [[fallthrough]](C++17)

Usually this is not very well liked, but in certain cases we want to execute two blocks of code in a ```switch```-```case``` statement. In the following example the code for the case 'b' and 'c' should be executed together. 

```cpp
switch (c) {
  case 'a':
    f();
    break;
  case 'b':
    g();
    [[fallthrough]]; // Some compilers need the semicolon
  case 'c':
    h();
    break;
  case 'd': //no [[fallthrough]] necessary
  case 'e':
    e();
    break;
}
```


With the attribute ```[[fallthrough]]``` we can express that executing both parts of the code was exactly our intention. Had omitted the attribute for cases 'b', most compilers are able to produce a warning or an error on this. Empty cases without a ```break``` are always warning free, even without ```[[fallthrough]]```.  


## [[nodiscard]](C++17)

This attribute I consider one of the most helpful. How often have we seen code where return values are just ignored, despite carrying helpful information? With ```[[nodiscard]]``` it is now possible to prevent this situation and to make it an even more powerful tool whole data types can be annoptated as such. Like this a library-developer can force the user to actually handle return value or error-data structures without resorting to controversial methods like throwing exceptions. 

```cpp
struct[[nodiscard]] demon{}; // Demons need to be kept and named
struct ghost {}; 

demon summon_demon() { return demon(); }

// summoned ghosts need to be kept
[[nodiscard]] ghost summon_ghost() { return ghost(); }

void summon() {
  auto d = summon_demon(); // OK
  auto g = summon_ghost(); // OK
  // Compiler Warning, because returned demon is not kept
  summon_demon();

  // Compiler Warning, because the function of summoning is nodiscard
  summon_ghost();
}
```
## [[maybe_unused]](C++17)

We all know this. When compiling with debug information during development we want to have an extended assert or similar in the code, for instance to realize design by contract. But sometimes this does not work without defining additional variables and now the compiler complains in the release-configuration - where we don't compile the assert - that we have an unused variable. Since C++17 these warnigns can be avoided by marking variables with ```[[maybe_unused]]````. The compiler will still optimize the variables away if the flag is set, but it will do so silently. 

```cpp
void f([[maybe_unused]] bool thing1,
 [[maybe_unused]] bool thing2) {
  [[maybe_unused]] bool b = thing1 && thing2;

  assert(b); // if assert is compiled out and b is unused

  assert(thing1 &&
    thing2); // parameters thing1 and thing2 are not used, no warning
}
```

## [[carries_dependency]](C++11)

Carries dependency gives the coder and the compiler a hint that memory-handling inside a function can be considered `transparent` in conjunction with atomics. The settings such as hard realtime constraints or very limited stack- and memory sizes are not that common, but in these cases the effect can be quite beneficial. 

```cpp
void opaque_func(int *p){/* do something with p */};​

[[carries_dependency]] void transparent_func(int *p) {
 /* do something with p */
}

void illustrate_carries_dependency() {
 std::atomic<int *> p;
 int *atomic = p.load(std::memory_order_consume);

if (atomic)
 std::cout << *atomic << std::endl; // transparent for the the compiler

if (atomic)
 opaque_func(atomic); // if from another compile unit and not inline, the
 // compiler might construct a memory fence here

if (atomic)
 transparent_func(atomic); // marked as to work in the same memory-dependency
 // tree, compiler can omit the memory fence
}
```

## What now? 

Apart from extended inline-documentation the standard attributes are a step in the direction: "away with dialects - one C++ for all compilers and plattforms". A good path, that started with C++11/14 and is now advanced further with C++17. I really hope that this direction will continue with C++20.
Of course as with all features the standard-attributes can be abused and used too liberally but it takes a surprisingly short time to get used to them and to be able to apply them in a helpful but non-intrusive manner. 

*Thanks to Silvan Wegmann for Co-Authoring this article*

(This article was originally [published at bbv.ch in german](http://blog.bbv.ch/2018/03/08/c-attribute-clean-code-fur-den-compiler/)

![bbv software services logo]({{ site.baseurl }}/images/logo_bbv_thumb.png)
