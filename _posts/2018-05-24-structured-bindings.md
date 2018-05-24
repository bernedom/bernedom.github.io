---
layout: post
title: Quick and easy unpacking in C++ with structured bindings 
thumbnail: images/cpp_logo.png
---

**Unpacking a fixed size container in C++ can be tedious, requiring you to fiddle around with `std::get` or `std::tie`.** But not anymore, thanks to the new *structured bindings* introduced in C++17. Unpacking anything with a fixed size into named variables never has been easier. 

Any data structure whose size is known at compile time, can now be conveniently be unpacked with minimal syntax. And it even works with `structs` and public members of `classes`.

```lang=cpp
auto tuple = std::make_tuple(1, 'a', 2.3);
std::array<int, 3> a{1, 2, 3};

// unpack the tuple into individual variables declared above
const auto[i, c, d] = tuple;
// same with an array
auto[x,y,z] = a; 
```

Structured bindings always have to be declared using `auto` with all the possible decorations like `const` or reference. This removes the possibility of explicitly casting the data into a different or more specific datatype than what is known at compile time. But as explicit casting should generally be avoided as often as possible, this limitation rather helps writing strongly typed code than being a hindrance. All bindings have the same `const`-ness and are all either copied or referenced, which means partially mutable access to a data structure is also ruled out.

Extracting classes and structs is, as mentioned, possible but has a few possible pitfalls.

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

While this works as expected there is a word of warning here, that unpacking depends obviously on the order of declaration in the class or struct. As long as this order is tightly controlled this is not so much a problem, but since the members of a struct are already named they are often not associated with positional stability. Experience shows that during refactoring class members often get regrouped semantically in a header file, which in that case could prove a disaster for any code using the structured bindings.

A much better approach when working with `classes`and `structs` is to add support for structured bindings, which is quite easy, bys template-specializing `std::tuple_size, std::tuple_element` and `get`. By the way, this pairs nicely with `if constexpr`, another feature introduced in C++17. Specializing a class in this way removes the dependency on the order of the declaration and also allows to change the return type of the parameter returned or return additional information as a positional parameter.

```lang=cpp
// this illustrates how to make a class support structured bindings
class Bindable
{
  public:
    template<std::size_t N>
    decltype(auto) get() const {

      // note the changing of the type from std::string to const char* for the 2nd parameter
      // of returning a reference to the vector
      if constexpr (N == 0) return x;
      else if constexpr (N == 1) return msg.c_str(); 
      else if constexpr (N == 2) return (v); // parentheses make a reference out of this
	  else if constexpr (N == 3) return v.size();

    }
  private:
    int x{123};
    std::string msg{"ABC"};
    std::vector<int> v{1,2,3};
};
/// template specialisation for class Bindable
namespace std{
  template<>
  struct tuple_size<Bindable> : std::integral_constant<std::size_t, 4> {};

  template<std::size_t N>
  struct tuple_element<N, Bindable> {
    using type = decltype(std::declval<Bindable>().get<N>());
  };

}
```


A sidenote is that so far structured bindings do not cover partial extraction as was possible with `std::tie`and `std::ignore`, so one has to create dummy variables if only interested in parts of a tuple. However due the guaranteed copy elision introduced in c++17 this should be side-effect free if compiled with any kind of compile-time optimization enabled. 

To conclude one can say that structured bindings are a nice way to lighten the syntax of handling and extracting fixed size containers, without the need to fiddle with templates. They are the linear "evolution" of `auto` and help bringing datatypes like `std::tuple` or `std::array` more naturally into the code.  