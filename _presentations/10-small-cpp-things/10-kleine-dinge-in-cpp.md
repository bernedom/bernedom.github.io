name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik) ![web](web_icon.png)  [http://www.dominikberner.me](http://dominikberner.me) ]
---

10 kleine Dinge die C++ einfacher machen
===


### Dominik Berner

???

# Begrüssung

# C++ ist schwierig - aber die neuen Standards machen es einfacher
# Situation Beschreiben: Brownfield project, modernisieren

Grosse features seit C++11 ==> smart ptr, variadic templates, lambdas, move semantics... 

Aber die kleinen bringen auch viel

# Einiges wird wohl bekannt sein
# vielleicht auch das eine oder andere neue

---

# Dominik Berner

.left-column[
 ![Me](profile_picture_presenting.jpg)
]
.right-column[
* C++ Coder
* Med-Tech 
* Agilist 
] 


---

# Wartbarer Code? 

```
x = x ^ y;
y = y ^ x;
x = x ^ y;

```

???

# Wer weiss was das macht? 

Cool oder nicht? Wartbar oder nicht?



# Lesbarkeit, Wartbarkeit, Code Qualität
## Absicht hinter code erkennbar 
### Absicht lässt sich mit compiler nachdruck verleihen

 Warum? Software is volatil - Dies wird zunichte gemacht durch Schlechten code

Beispiele: ich traue mich nicht schlechten Code anzufassen 

Dinge wie Clean Code, das SOLID-Prinzip oder Paradigmen wie Low Coupling, Strong Cohesion
--

### besser:

```
std::swap(x,y);
```

???

Natürlich: Abstriche bei z.b. Performance etc. 

Progammiersprachen leben von Erwartungshaltungen beim lesen. 

Ein paar kleine features die sich auch relativ einfach in bestehenden code einarbeiten lassen und so die Qualität verbessern

# Los gehts mit ein paar features

---


# Stark typisierte enums

```cpp
enum Color : uint8_t { Red, Green, Blue }; 
```


```cpp
enum class Sound { Boing, Gloop, Crack };

auto s = Sound::Boing;
```

???

# etwas zum aufwärmen

# unterlioegender Datentyp spezifiziert 
zuweising über enums nicht mehr möglich

Absicht klar erkennbar und umsetzbar. 

---

# Hast du Zeit? - Zeitliterale

.left[
```cpp
using namespace std::chrono_literals;

auto seconds = 10s;
auto very_small = 1us;

if(very_small < seconds) // automatic, compile-time conversion 
{
...
}```
]
---

# Vererb mir bitte was - `override` 

.left[
```cpp
struct Base
{
  virtual int func() { return 1; }
};

struct Derived : public Base
{
  // Compiler-error if Base::func does not exist or is not virtual
  int func() override { return 2; }; 
};
```
]


---


# Du bist enterbt! - `final`

.left[
```cpp
class Base final 
{ };

class Derived : public Base {}; // Compiler error
```



```cpp
class Base
{
  virtual void f();
};

class Derived : public Base
{
  // f cannot be overriden by further base classes
  void f() override final; 
};
``` 
]

---

# Benutz mich! - `using` deklarationen

### (Und Kontstruktorenvererbung)

.left[
```cpp
struct A
{
  A() {}
  explicit A(char c {}

  int get_x(); 
  int func();
}

struct B : public A
{
  using A::A; // get all constructors from A

  using A::func;
  int func(int); // could possibly mask A::func()

  private:
    using A::get_x;  // <-- get_x is now private
}
```
]

---

# Auch mit Namensräumen 

.left[
```cpp
void f(){ }

namespace X
{
  void x() {};
  void y() {};
  void z() {};
}

namespace I::K::L
{
  using ::f; // f() is available in I::K::L now
  using X::x; // x() is available in I::K::L (dropped namespace X)
}

...

I::K::L::f();
I::K::L::x();
```
]

---

# Mach du das doch - Delegating Ctors

.left[
```cpp
class DelegatingCtor
{
    int number_;
  public:
    DelegatingCtor(int n) : number_(n) {}
    DelegatingCtor() : DelegatingCtor(42) {};
   
}
```
]

---

# Combine the power with `using`

.left[
```cpp
class Base
{
  public: 
    Base(int x) : x_{x} {}; 
  private:
    int x_;
};

class Derived : public Base
{
  public:
    using Base::Base; // imports Base(int) as Derived(int)
    Derived(char) : Derived(123) {} // delegating ctor; 
};
```
]

---

# Mich gibt's gar nicht - `=delete`

.left[
```cpp
struct NonCopyable {
  NonCopyable() = default; 

  // disables copying the object through construction
  NonCopyable(const Dummy &) = delete;
  // disables copying the object through assignement
  NonCopyable &operator=(const Dummy &rhs) = delete;
};

struct NonDefaultConstructible {
  
// this struct can only be constructed through a move or copy
  NonDefaultConstructible() = delete;
}; 
```
]

---

# Guaranteed copy elision

.left[
```cpp 
class A {
public:
  A() = default;
  A(const A &) = delete;
  A(const A &&) = delete;
  A& operator=(const A&) = delete;
  A& operator=(A&&) = delete;
  ~A() = default;

};

// Without elision this is illegal, as it performs a copy/move of A which has
// deleted copy/move ctors
A f() { return A{}; }

int main() {

  // OK, because of copy elision. 
  // Copy/move anonymously constructed A is not
  // neccessary
  A a = f();
}
```
]


---

# Auspacken! - Structured Bindings

.left[
```cpp
const auto tuple = std::make_tuple<1, 'a', 2.3>;

const auto [a, b, c] = tuple;
auto & [i,k,l] = tuple;
```
]

---

# Selection Statement mit initializer

.left[
```cpp
if(int i = std::rand(); i % 2 == 0)
{ }
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
]


---

# Standard Attribute

```cpp
[[noreturn]] 
[[deprecated]], [[deprecated("Reason")]]
[[fallthrough]]
[[nodiscard]]
[[maybe_unused]]

```
