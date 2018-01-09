---
layout: post
title: Quick and easy unpacking in C++ with structured bindings 
thumbnail: images/logo_bbv_thumb.png
---

** Unpacking a fixed size container in C++ can be tedious, requiring you to fiddle around with ```std::get``` or ```std::tie```.*** But not anymore, thanks to the newly introduced *structured bindings*. Unpacking anything with a fixed size into named variables never has been easier. 

Any data structure whose size is known at compile time, can now be conveniently be unpacked with minimal syntax. And it even works with ```structs``` and public members of ```classes```.

```lang=cpp
auto tuple = std::make_tuple(1, 'a', 2.3);
std::array<int, 3> a{1, 2, 3};

// unpack the tuple into individual variables declared above
const auto[i, c, d] = tuple;
// same with an array
auto[x,y,z] = a; 
```

Structured bindings always have to be declared using ```auto``` with all the possible decorations like ```const``` or reference. This removed the possibility of explicitely casting the data into a different or more specific datatype than what is known at compile time. But as explicit casting should generally be avoided as often as possible, this limitation rather helps writing strongly typed code than being a hindrance. 

All bindings have the same ```const```-ness and are all either copied or referenced, so this also rules out having only partially mutable access to a data structure. 

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
```




(This article was originally [published at bbv.ch in german](http://blog.bbv.ch/2017/12/12/cpp17-was-bringt-der-neue-standard/))
![bbv software services logo]({{ site.baseurl }}/images/logo_bbv_thumb.png)
