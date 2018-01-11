---
layout: post
title: Quick and easy unpacking in C++ with structured bindings 
thumbnail: images/logo_bbv_thumb.png
---

**Unpacking a fixed size container in C++ can be tedious, requiring you to fiddle around with ```std::get``` or ```std::tie```.** But not anymore, thanks to the newly introduced *structured bindings*. Unpacking anything with a fixed size into named variables never has been easier. 

Any data structure whose size is known at compile time, can now be conveniently be unpacked with minimal syntax. And it even works with ```structs``` and public members of ```classes```.

```lang=cpp
auto tuple = std::make_tuple(1, 'a', 2.3);
std::array<int, 3> a{1, 2, 3};

// unpack the tuple into individual variables declared above
const auto[i, c, d] = tuple;
// same with an array
auto[x,y,z] = a; 
```

Structured bindings always have to be declared using ```auto``` with all the possible decorations like ```const``` or reference. This removes the possibility of explicitly casting the data into a different or more specific datatype than what is known at compile time. But as explicit casting should generally be avoided as often as possible, this limitation rather helps writing strongly typed code than being a hindrance. 

All bindings have the same ```const```-ness and are all either copied or referenced, which means partially mutable access to a data structure is also ruled out. As mentioned above even ````structs``` and ```classes``` can be unpacked using structured bindings as illustrated below. 

```lang=cpp
struct Packed {
  int x;
  char y;
  float z;
};

Packed p;
// access by reference
auto & [ x, y, z ] = p;
// access by move
auto && [ xx, yy, zz ] = p;

class cls {
public:
  int m;
  float n;
};

auto[m, n] = cls();
```

While this works as expected there is a word of warning here, that unpacking depends obviously on the order of declaration in the class or struct. As long as this order is tightly controlled this is not so much a problem, but since the members of a struct are already named they are often not associated with positional stability. Experience shows that during refactoring class members often get regrouped semantically in a header file, which in that case could prove a disaster for any code using the structured bindings, so I strongly advise to use caution when using structured bindings with classes or structs. As these members are named variables strutured bindings provide a limited benefit anyway.

Another note is that so far structured bindings do not cover partial extraction as was possible with ```std::tie```and ```std::ignore```, so one has to create dummy variables if only interested in parts of a tuple. However due the guaranteed copy elision introduced in c++17 this should be side-effect free if compiled with any kind of optimization. 

To conclude one can say that structured bindings are a nice way to lighten the syntax of handling and extracting fixed size containers, without the need to fiddle with templated constructs like std::tie.

(This article was originally [published at bbv.ch in german](http://blog.bbv.ch/2017/12/12/cpp17-was-bringt-der-neue-standard/))
![bbv software services logo]({{ site.baseurl }}/images/logo_bbv_thumb.png)
