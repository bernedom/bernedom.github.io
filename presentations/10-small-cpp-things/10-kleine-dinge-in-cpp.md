<!-- $theme: gaia -->
<!-- $size: 16:9 -->
10 kleine Dinge die C++ einfacher machen
===



###### Dominik Berner
---

# Wartbarer Code? 

```lang=c++

x = x ^ y; 
y = y ^ x;
x = x ^ y;

```

oder 

```lang=c++
std::swap(x,y);
```

<!--

Warbarer code beginnt auf dem kleinsten level. SOLID prinzipien, clean code etc. alles gut, aber es beginnt bei der Verwendung der Sprache.

Progammiersprachen leben von Erwartungshaltungen beim lesen. 

Idee: Warum es cool ist, warum es gefÃ¤hrlich ist

//-->

---

# Die neuen C++ Standards

* Viele "grosse" Ã„nderungen
  * variadic templates, move-semantics, `auto`, ` [](){}`
* kleinere die unter dem Radar fliegen

---

# Die kleinen aber feinen

1. structured bindings
1. selection statements with initializers
1. using declarations
1. guaranteed copy elision
1. Delegating constructors (inkl. using)
1. strongly typed enums
1. standard atttributes
1. ```__has_include```
1. ```<filesystem>```
1. ```<algorithm>```

<!--

* final, default, delete
* static assertions
* noexcept
* nested namespace definition
* initialisierung von lambda captures
* type traits (too big)
* unordered containers


//-->

--- 

# structured bindings

```lang=cpp
const auto tuple = std::make_tuple<1, 'a', 2.3>;

const auto [a, b, c] = tuple;
auto & [i,k,l] = tuple;
```

* Auspacken von fixed size containern
* Geht auch mit Klassen und structs
  * Aber Achtung: keine strikt-order Semantik
  * Workarounds gehen, sind aber aufwÃ¤ndig

---

# selection statements with initializers

```
if(int i = std::rand(); i % 2 == 0)
{
	...
}
```

```
switch(int i = std::rand(); i = %3)
{
  case 0:
   ...
  case 1:
   ...
  case 2:
   ...
}
```
---

# using declarations

##### "import" a name defined elswhere into another declarative region"

```
struct A
{
	int get_x(); 
}

struct B : public A
{
  private:
    using A::get_x;  // <-- get_x is now private
}

namespace AX
{
 void f();
}

namespace BX
{
 using AX::f;
}
```

---

# guaranteed copy elision

```
struct A {

  A() =default;
  A(const A &rhs) = delete;
  A(const A &&rhs) = delete;

};

A f() { return A{}; }
A a = f();
```



---

# delegating constructors

#### Konstruktoren die andere Konstruktoren aufrufen


```
class DelegatingCtor
{
 int number_;
 public:
   DelegatingCtor(int n) : number_(n) {}
   DelegatingCtor() : DelegatingCtor(42) {};
   
}
```

---

# Inheriting ctors

```
struct Base 
{
 Base() = default();
 explicit Base(int n) {};
}


struct Derived : public Base
{
  using Base::Base; // get all ctors from base class!
}

Derived d(123);
```


---

# Strongly typed enums & scoped enums

```
enum Color : unsiged char { Red, Green, Blue }; 
```

```

enum class Sound { Boing, Gloop, Crack };

auto s = Sound::Boing;

```

---

# (Standard) attributes 

```
[[MyCustomAnnotation]]
int some_function() 
{
}
```

* `[[deprecated]]`, `[[deprecated("reason")]]`, `[[fallthrough]]`, `[[nodiscard]]`, `[[maybe_unused]]`

More to come 
 * C++20: design by contract

---

# `__has_include`

##### Weniger abhängigkeiten von `#define`s 

```
#if __has_include(<unistd.h>)
#define OPEN_SHARDED dlopen
#elif __has_include(<windows.h>)
#define OPEN_SHARED LoadLibrary
#else
#pragma error("loading shared libraries not supported");
#endif
```

--- 

# `#include <filesystem>`

# Endlich! (C++17)

---

# `#include <algorithm>`

### Die top 105 algorithmen 
