name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
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

### C++ Coder, Agilist & Rock Climber
.left-column[
 ![Me](profile_picture_presenting.jpg)
]
.right-column[
.left[
[![web](web_icon.png) dominikberner.me](http://dominikberner.me)

[![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)

[![github](github_icon.png) bernedom](https://github.com/bernedom)

[![mail](mail_icon.png) dominik.berner@bbv.ch](mailto:dominik.berner@bbv.ch)
]
]
 

???

10+ Jahre erfahrung mit C++
Seit Anfang an auf c++11 (Cx::TR1)

Computergrafik, Medtech

# Arbeiten mit gutem code ist ein Genuss

---

# Wartbarer Code? 

```cpp
int x{123};
int y{999};

x = x ^ y;
y = y ^ x;
x = x ^ y;

```

???

# Wer weiss was das macht? 

(Tascht werte von zwei Variablen) 
Cool oder nicht? Wartbar oder nicht?



# Lesbarkeit, Wartbarkeit, Code Qualität
## Absicht hinter code erkennbar 
### Absicht lässt sich mit compiler nachdruck verleihen

# Programmiersprache födern Erwartungshaltung 
Keine natürliche Sprache

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

exclude: true

# Wartbarer Code 

* Lesbar
* Absicht erkennbar
* Erfüllt Erwartungen des Lesers
* "Standardpatterns"
* vom compiler überprüft

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

???

# etwas zum aufwärmen

Gut weil scoping klar
Operator precendence keine Frage mehr

---

# Starker Typ! - enums

.left[

```
enum class Sound { Boing, Gloop, Crack };
enum class Smell { Roses, Veils, Sunflower };

*auto s = Sound::Boing; 

s = Smell::Roses; // ooops! Assignment across types
auto s1 = Boing; // ooops! Missing type specifier
 
```

]

???



Starker scope für enums.
Kein gebastel mit Namespaces und umgebenden klassen
zuweising über verschiedene enums nicht mehr möglich

Absicht klar erkennbar und umsetzbar. 

--

### Bonus: Unterliegender datentyp spezifizieren:

.left[
```
enum Color : uint8_t { Red, Green, Blue }; 
```
]


???

# Nicht nur ints, alle simplen typen möglich


---

# Hast du Zeit? - Zeitliterale

### Einheiten-Suffixe für Zeitwerte


.left[
```
using namespace std::chrono_literals;

*auto seconds = 10s;
*auto very_small = 1us;

// automatic, compile-time conversion 
if(very_small < seconds) { ... } 
```
]


???

# handling von Zeiteinheiten sind ein Graus

nicht linear verwertbar,
compiler enforced das; Weg von `timestamp_in_seconds()` etc


--

### Bonus: Definere deine eigenen Literale!

.left[
```
long double operator "" km(long double d) {...}

const auto zurich_to_lucerne = 52.672km;

```
]


???

Sehr mächtiges Feature, wird aber hier nicht im detail besprochen 


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
*  int func() override { return 2; }; 
};
```
]


???


# Endlich! Der compiler hilft mir vererbungsbäume zu plfanzen

Nur `virtual` Absicht nicht vollständig ausgedrückt
override ist automatisch virtual
nun "Das muss von etwas erben"

liest sich auch ein kleines bischen natürlicher

macht refactorings viel einfacher - z.b. wenn signatur in Basisklasse ändert

---


# Du bist enterbt! - `final`

.left[
```cpp
*class Base final 
{ };

class Derived : public Base {}; // Compiler error
```
]


???

Vererbungen noch strenger kontrollieren

- Starker ausdruck der Absicht
- z.b. um tiefe vererbungsbäume zu verhindern

-> Kann dem compiler in gewissen situationen helfen ein virtual-table lookup wegzuoptimieren

--

### Auch für Methoden

.left[
```cpp
class Base
{
  virtual void f();
};

class Derived : public Base
{
  // f cannot be overriden by further base classes
*  void f() override final; 
};
``` 
]


???

## Kann man machen, muss man aber nicht

besser - von anfang an methode nicht virtual 

Versuchung nur teile der Klasse final zu machen - think again

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


???

Ganz klar ausdrücken, dieses Objekt darf so nicht verwendet werden.
Generell für Ctors und operatoren
Rule of five gilt auch hier

Reduziert die Menge generierten und geschriebenen code
Früher methoden mussten private sein -- Semantisch inkorrekt

## Guaranteed copy elision hilft hier

---

# Benutz mich! - `using` deklarationen


.left[
```cpp
struct Base
{
  Base() {}
  explicit Base(char c {}

  int get_x(); 
  int func();
}

struct Derived : public Base
{
  using Base::func;
  int func(int); // could possibly mask Base::func()

  private:
    using Base::get_x;  // <-- get_x is now private
}
```
]


???

Klare intention: Hier wird etwas wiederverwendet und nichts neues erstellt

using funktioniert nur innerhalb vererbungshierarchie 

Geht auch mit namensräumen (Reservefolie)

---

# Genetische Verwandtschaft - Konstruktorenvererbung

.left[
```

struct Base
{
	Base();
	Base(int x);
};

struct Derived : public Base
{
*  using Base::Base; // get all ctors from Base

  Derived(double d); // Add more
};

```
]

???

Jetzt wirds wieder spannender. Andere sprachen kennen das schon seit langem

Absicht: Nichts neues hier

Code reuse in ctors. Endlich!

---

# Mach du das doch - Delegating Ctors

.left[
```cpp
struct Base
{
	Base(double d);
};

struct Derived : public Base
{
  int number_;

  Derived(int n) : number_(n) {}
*  Derived() : Derived(42) {};

  // combine with inherting ctors
*  using Base::Base;
*  Derived(float f) : Derived{static_cast<double>(f)}; 
   
}
```
]

???

Deklaration zeigt ganz klar Absicht - Ich verwende dann diesen da
Hilft bei RAII, weil auf init() funktionen verzichtet werden kann bei 

# Nun weg von Datenstrukturen

---

# Auspacken! - Structured Bindings

.left[
```cpp
const auto tuple = std::make_tuple<1, 'a', 2.3>;

const auto [a, b, c] = tuple;
auto & [i,k,l] = tuple;
```
]


???

im grösseren Sinn hilft dies type-pollution zu unterbinden. 
fixed-size container und strukture können als anonyme datencontainer gebraucht werden

keine private-structs mehr nötig

Klassen und struckts können auch ausgepackt werden, aber hier ist die semantik nicht geordnet -> Nicht empfehlenswert

http://dominikberner.ch/structured-bindings/

---

# Reserve

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

# Standard Attribute

```cpp
[[noreturn]] 
[[deprecated]], [[deprecated("Reason")]]
[[fallthrough]]
[[nodiscard]]
[[maybe_unused]]

```

---


# `using` auch mit Namensräumen 

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


I::K::L::f();
I::K::L::x();
```
]


