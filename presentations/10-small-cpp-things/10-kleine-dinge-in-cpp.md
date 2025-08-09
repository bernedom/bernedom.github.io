name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
---

10 kleine Dinge die C++ einfacher machen
===


### Dominik Berner

![](logo_bbv_thumb.png)

???

# Begrüssung

# C++ ist schwierig - aber die neuen Standards machen es einfacher
Grosse features seit C++11 ==> smart ptr, variadic templates, lambdas, move semantics... 

Aber die kleinen bringen auch viel

### Grobübersicht, keine tiefgehende Diskussionen

### Features sind nützlich bei Brownfield projekten

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

# 10+ Jahre erfahrung mit C++
#Seit Anfang an auf c++11 (Cx::TR1)

Computergrafik, Medtech

# Agilist -> Konstantes Refactoren

# Arbeiten mit gutem code ist ein Genuss

### Pfadfinder-mentalität: Lass den Code etwas besser zurück als du ihn angetroffen hast

---

# Guter Code? 

???

# Lesbarkeit, Wartbarkeit, Code Qualität
## Absicht hinter code erkennbar 
### Absicht lässt sich mit compiler nachdruck verleihen

# Programmiersprache födern Erwartungshaltung 
Keine natürliche Sprache (Beispiel do ... while, if ... else)


## Software is volatil - Dies wird zunichte gemacht durch Schlechten code

Beispiele: ich traue mich nicht schlechten Code anzufassen 

 SOLID-Prinzip oder Paradigmen wie Low Coupling, Strong Cohesion


--

```
int x{123};
int y{999};

x = x ^ y;
y = y ^ x;
x = x ^ y;

```

???

# Ein Beispiel Wer weiss was das macht? 

(Tauscht werte von zwei Variablen, ohne eine dritte) 
Cool oder nicht? Wartbar oder nicht?

# Wie machen wir den gut? 

# Lesbar, klein, absicht erkennbar, compilergestützt

--

# Guter Code!

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
```
if(int i = std::rand(); i % 2 == 0)
{ ... }
```

```
switch(int i = std::rand(); i % 3)
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

# 

# Gut weil scoping klar, deklaration neu IN if
Operator precendence keine Frage mehr
Absicht: diese veriable wird nur in diesem Statement verwendet

Feature 1

## Weiter zu einer anderen netten syntax-Erweiterung

---

# Auspacken! - Structured Bindings

.left[
```
const auto dataset = std::make_tuple<1, 'a', 2.3>;

const auto [a, b, c] = dataset;
auto & [i,k,l] = dataset;
```
]

~~Funktioniert auch für Klassen und Structs~~

???

fixed-size container und strukture können als anonyme datencontainer gebraucht werden
# Auspacken mit `std::tie` und `std::get` mühsam

keine private-structs mehr nötig

# Klassen und structs können auch ausgepackt werden, aber hier ist die semantik nicht geordnet -> Nicht empfehlenswert

http://softwarecraft.ch/structured-bindings/

## Weiter zu anderen Datentypen - Enums

feature 2



---

# Starker Typ! - enums

.left[

```
enum class Color { Red, Purple, Green };
enum class Smell { Roses, Violet, Sunflower }; 

auto color = Color::Purple; 

// Examples below do not compile
auto c2 = Red; // 'Red' not declared in scope
color = Smell::Violet; // conversion from 'Smell' to 'Color'
```

]

???

# Starker scope für enums.
##Kein gebastel mit Namespaces und umgebenden klassen

zuweising über verschiedene enums nicht mehr möglich

Absicht klar erkennbar und umsetzbar. 
(violet sind veilchen)

violet - englisch purple

feature 3

--

### Bonus: Unterliegender datentyp spezifizieren:

.left[
```
enum class Color : uint8_t { Red, Green, Blue }; 
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

*auto time_step = 10s;
*auto very_small_time_step = 1us;

// automatic, compile-time conversion between 's' and 'us'
if(very_small_time_step < time_step) { ... } 
```
]


???

# Wenn wirs schon von uneindeutigen Werten haben

# handling von Zeiteinheiten sind ein Graus

nicht linear verwertbar,
compiler enforced das; Weg von `timestamp_in_seconds()` etc

feature 4

--

### Bonus: Definere deine eigenen Literale!

.left[
```

long double operator "" _km(long double d) 
{ return {d * 1000}; }

const auto zurich_to_sindelfingen = 201.672_km;
```
]


???

Sehr mächtiges Feature, wird aber hier nicht im detail besprochen 

# Alles was kein _ hat ist reserved for further standardisation

# Nun gehts ans eingemachte, Klassen und Vererbung

---

# Vererb mir bitte was - `override` 

.left[
```
struct Base
{
  virtual int func() { return 1; }
};

struct Derived : public Base
{
   // Compiler-error if Base::func does not exist 
   // or if func is not virtual
*  int func() override { return 2; }; 
};
```
]


???


# Endlich! Der compiler hilft mir vererbungsbäume zu pflanzen

Nur `virtual` Absicht nicht vollständig ausgedrückt
override ist automatisch virtual
nun "Das muss von etwas erben"

liest sich auch ein kleines bischen natürlicher

macht refactorings viel einfacher - z.b. wenn signatur in Basisklasse ändert

feature 5

---


# Du bist enterbt! - `final`

.left[
```
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

feature 6

--

### Auch für Methoden

.left[
```
class Base
{
  virtual void func();
};

class Derived : public Base
{
  // func cannot be overriden by further base classes
*  void func() override final; 
};
``` 
]


???

# Kann man machen, muss man aber nicht

besser - von anfang an methode nicht virtual 

# Versuchung nur teile der Klasse final zu machen - think again

---

# Mich gibt's gar nicht: `=delete`

.left[
```
struct NonCopyable {
  NonCopyable() = default; 

  // disables copying the object through construction
* NonCopyable(const Dummy &) = delete;
  // disables copying the object through assignement
* NonCopyable &operator=(const Dummy &rhs) = delete;
};

struct NonDefaultConstructible {
  
  // this struct can only be constructed through a move or copy
*  NonDefaultConstructible() = delete;
}; 
```
]


???
# Löscht einen konstruktor/operator - Verwendung führt zu compiler error

Ganz klar ausdrücken, dieses Objekt darf so nicht verwendet werden.
Generell für Ctors und operatoren
Rule of five gilt auch hier

Reduziert die Menge generierten und geschriebenen code
Früher methoden mussten private sein -- Semantisch inkorrekt

## Guaranteed copy elision hilft hier

feature 7

---

# Benutz mich! - `using` deklarationen


.left[
```
struct Base
{
  int func();
  int some_function(); 
};

struct Derived : public Base
{
* using Base::func; // explicit intent: I'm aware of Base:func

  int func(int); // could possibly mask Base::func()

  private:
*   using Base::some_function;  // some_function is now private
};
```
]


???

# Absicht: ich weiss dass func() in der Basisklasse existiert

Klare intention: Hier wird etwas wiederverwendet und nichts neues erstellt

using funktioniert nur innerhalb vererbungshierarchie 

Geht auch mit namensräumen (Reservefolie)

feature 8

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
* using Base::Base; // get *all* ctors from Base

  Derived(double d); // Add more ctors
  Derived(int x); // overwrite Base(int x)
};

```
]

???

Jetzt wirds wieder spannender. Andere sprachen kennen das schon seit langem

Absicht: Nichts neues hier

Code reuse in ctors. Endlich!

feature 9

---

# Mach du das doch - Delegating Ctors

.left[
```
struct Base
{
  Base(int d) {};
* Base() : Base(42) {}
};
```
]

???

# Code reduktion, Gegenstück zu inheritance

Deklaration zeigt ganz klar Absicht - Ich verwende dann diesen da
Hilft bei RAII, weil auf init() funktionen verzichtet werden kann bei 


--

### Bonus: Kombinierbar mit Konstruktorenvererbung

.left[
```
struct Derived : public Base
{
  // combine with inherting ctors
* using Base::Base;
* Derived(float f) : Derived{static_cast<double>(f)}; 
}
```
]

???

Funktioniert auch bei Konstruktorenvererbung


feature 10

---


# Die 10 "kleinen" features

.left[
1. Initializers in selection statements
2. Structured bindings
3. Stark typisierte enums
4. Zeitliterale
5. `override`
6. `final`
7. `= delete`
8. `using` - deklarationen
9. Konstruktorenvererbung
10. Konstruktorendelegation

]

???

# Das waren die 10
## besserer Code mit kleinem Aufwand
## ohne dass man gesamte Programmstruktur umbauen muss

# Vielen dank

# Fragen? 

