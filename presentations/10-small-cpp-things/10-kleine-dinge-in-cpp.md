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

Idee: Warum es cool ist, warum es gefährlich ist

//-->

---

# Die neuen C++ Standards

* Viele "grosse" Änderungen
  * variadic templates, move-semantics,`auto` 
* kleinere die unter dem Radar fliegen

---

# Die kleinen aber feinen

1. structured bindings
1. selection statements with initializers
1. using declarations
1. guaranteed copy elision
1. Delegating constructors (inkl. using)
1. ```<algorithm>```
1. standard atttributes
1. ```__has_include```
1. ```<filesystem>```
1. strongly typed enums

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
  * Workarounds gehen, sind aber aufwändig

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

  A() = default;
  A(const A &rhs) = delete;
  A(const A &&rhs) = delete;
  ~A() = default;

};

A f() { return A{}; }
A a = f();
```



