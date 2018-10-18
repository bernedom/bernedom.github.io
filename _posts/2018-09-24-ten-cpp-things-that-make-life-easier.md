---
layout: post
title: 10 kleine Dinge die C++ einfacher machen
thumbnail: images/cpp_logo.png
---

Die neuen C++ Standards haben die Programmiersprache merklich modernisiert und teilweise ganz neue Programmierparadigmen in die Welt von C++ eingebracht. Die "grossen" Änderungen wie Variadic Templates, `auto`, move-semantics, Lambda-Expressions und weitere haben für viel Diskussionsstoff gesorgt und sind dementsprechend mittlerweile auch weitherum bekannt. Nebst den Sprachfeatures hat auch die Standard-Library eine merkliche Erweiterung erfahren und hat viele der Konzepte von Bibliotheken von Drittanbietern wie zum Beispiel `boost` auch in einer "Standard-Umgebung" zur verfügung gestellt. Aber nebst diesen sehr spürbaren und teilweise auch umstrittenen Features gibt es eine ganze Menge an kleinen-aber-feinen Spracherweiterungen die oft unter dem Radar fliegen und weit weniger bekannt sind. 

Aber gerade weil diese Features oft sehr klein und teilweise fast unsichtbar sind haben sie grosses Potential um im Programmiereralltag das Leben einfacher zu machen. Denn auch wenn zum Beispiel Variadic Templates eine sehr spannende und mächtige Angelegenheit sind, schreiben wir ungleich mehr nicht-termplatisierten Code. Auch Lambda-Expressions haben ihre daseinsberechtigung, aber vermutlich schreiben wir dennoch viel häufiger konventionelle Funkntionen und Methoden. Gerade weil der grossteil unseres Codes nicht aus der Verwendung der neuen "Killer-Features" besteht lohnt es sich das Augenmerk dort auf Lesbarkeit und Wartbarkeit zu legen.

# Moderner, Wartbarer Code

Wartbarkeit, Lesbarkeit und Code-Qualität sind Themen die aus der heutigen Software-Entwicklung nicht mehr wegzudenken sind. Gerade im Zuge der Agilisierung wo Code nicht nur einmal sondern bewusst mehrmals überarbeitet, veränderdert und angepasst wird sind dies zentrale Themen. Dinge wie Clean Code, das SOLID-Prinzip oder Paradigmen wie Low Coupling, Strong Cohesion sind ein wichtiger Aspekt von Codequalität, aber im kleinsten beginnt diese bereits bei der Verwendung der Sprache selbst. Das Verwenden von den von der Sprache zur Verfügung gestellten Features und Funktionen hilft die **Absicht hinter dem geschriebenen Code** zu verdeutlichen. Zudem kann oft dadurch die Menge von geschriebenem Code reduziert werden und dies hilft nach dem Prinzip von "Less code means less bugs" der Qualität auch wieder enorm. 

Ein einfacher Algorithmus kann sehr kompliziert zu verstehen sein, wenn die Schreibweise nicht den Erwartungen entsprechen oder der vorgängige Autor sich einen besonders schlauen Hack zur Optimierung einfallen lies.
So kann zum Beispiel das tauschen von zwei variablen `x` und `y` wie folgt geschrieben werden: 

```cpp
x = x ^ y; 
y = y ^ x;
x = x ^ y;
```

Dieser XOR-Swap ist zwar Speichereffizient und hat in ganz spezifischen Fällen seine Daseinsberechtigung, aber intuitiv lesbar ist die Operation nicht. Selbst mit einem Code-Kommentar versehen zwingt dieses einfach Beispiel dem leser unnötige Denkarbeit auf. Dem gegenübergestellt liest sich das folgende Beispiel viel einfacher: 

```cpp
std::swap(x,y);
```
 
Die folgenden 10 kleine Features und Erweiterungen aus C++11 - C++17 helfen Code kompakt und lesbar zu halten und somit die Code-Qualität zu verbessern.

# Vererbung mit kontrollieren mit `final` 

Der Spezifikator `final` zeigt an, dass eine Klasse nicht oder vrituelle Funktion nicht weiter überschrieben werden kann. Dies verringert zwar den Schreibaufwand nicht, aber kommuniziert ganz klar eine Absicht hinter einen Stück code, nämlich dass keine weitere Vererbung erwünscht ist. Hier hilft sogar der compiler mit, diese erwünschte Verwendung des Programmteils umzusetzen, indem die Kompilierung fehlschlägt, falls ein mit `final` markiertes Element überschrieben wird. 

```cpp
class Base final 
{ };

class Derived : public Base {} // Compiler error
```

```cpp
class Base
{
  virtual void f();
}

class Derived : public Base
{
  void f() override final; // f cannot be overriden by further base classes
}
``` 

# `Using`-Declarationen und Konstruktorenvererbung

`using`-Deklarationen erlauben es dem Programmierer ein Symbol von einer deklarativen Region, wie Namespaces, Klassen und Strukturen in einen anderen zu "importieren" ohne dass zusätzlicher code generiert wird. Bei Klassen ist dies vor allem nützlich um Konstruktoren von Basisklassen direkt zu übernehmen, ohne dass alle Varianten neu geschrieben werden müssen. Ein weiteres Beispiel ist um Ko-Variante Implementierungen in Abgeleiteten Klassen explizit zu gestalten. Damit wird dem dem Leser klar signalisiert, dass hier eine "fremde" Implementation verwendet wird, die keine funktionale Modifikation erfahren hat. 

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

Für Klassen und Structs funktioniert das schon länger, seit C++17 funktioniert das übernehmen von Symbolen auch für (verschachtelte) Namespaces: 

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
```

# Weiterleiten von Konstruktoren

Andere High-Level Programmiersprachen kennen das "Verketten" von Konstruktoren schon länger und seit C++11 ist dies auch in C++ möglich. Die Vorteile von weniger dupliziertem Code und damit einfacherer Lesbarkweit und somit bessere Wartbarkeit liegen dabei auf der Hand. Gerade bei Konstruktoren die intern komplizierte Initialisierungen oder Checks durchführen hilft dies sehr und hilft bei der Umsetzung des RAII (Resource Allocation is Initialisation) paradigma, weil unter Umständen auf abgesetzte Initialisierung-Funktionen verzichtet werden kann. 

```cpp
class DelegatingCtor
{
    int number_;
  public:
    DelegatingCtor(int n) : number_(n) {}
    DelegatingCtor() : DelegatingCtor(42) {};
   
}
```

Gerade im Zusammenhang mit ver verwendung der oben genannten Konstruktorenvererbung mit `using` lässt sich code so noch weiter komprimieren. 

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

# `= delete` - Löschen von Funktionen


Das Keyword `delete` für Funktionsdeklrationen - nicht zu verwechseln mit dem entsprechenden Ausdruck um Objekte zu Löschen - ist eine weitere sehr starke Erweiterung in C++11, mit der ein Programmierer eine Absicht nicht nur Signalisieren sondern auch vom Kompiler forcieren lassen kann. Ein netter Nebeneffekt dabei ist auch, dass die Menge generierter, aber evtl. nie verwendeter Code minimiert werden kann. Mit der Verwendung von `= delete` kann explizit sichergestellt werden, das gewisse Operationen wie zum Beispiel Kopieren eines Objektes nicht vorgesehen sind. NAtürlich sollte die "Rule of Five" auch beim Löschen von Funktionen beachtet werden. 

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
 
# Garantiertes verhindern von Kopien

Die garantiere Verhinderung von Kopien (engl. guaranteed copy elision) ist für den Programmierer meist unsichtbar, aber dahinter verbirgt sich grosses Potential für kleineren und saubereren Code. Diese Tilgung (engl. elision) verhindert, dass unnötige Kopien von temporären Objekten erstellt werden, wenn sie unmittelbar nach dem erstellen einem Neuen Symbol zugewiesen werden. Einige Compiler, wie gcc unterstützen dies zwar schon länger, aber mit C++17 wurde das Auslassen von Kopien als garantiertes Verhalten in den Standard aufgenommen. 
Nebst dem Effekt, das so weniger Code generiert wird, lässt sie den Progammierer seine Absicht, dass ein Objekt nicht kopiert oder verschoben werden darf mit noch grösserer Konsequenz umzusetzen. Im Zusammenhang mit dem obengenannten `= delete` lässt sich dies sehr deutlich ausdrücken. 

Dies 

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

  // OK, because of copy elision. Copy/move constructing an anonymous A is not
  // neccessary
  A a = f();
}
```

# Structured Bindings

Mit `std::tuple` und `std::array` wurden in C++11 zwei Datenstrukturen mit zur compile time bekannter Grösse eingeführt. Während `std::array` eine relativ simple Modernisierung von C-Arrays darstellt wurde mit `std::tuple` wurde eine generische Möglichkeit geschaffen um heterogene Daten bequem im Programm herum zu reichen, ohne dass der Programmiere reine Datenklassen oder `structs` erstellen muss. 

Seit C++17 ist der Zugriff auf die Inhalte dieser Datenstrukturen durch die Strukturierten Bindings sehr leichtgewichtig möglich:

```cpp
const auto tuple = std::make_tuple<1, 'a', 2.3>;

const auto [a, b, c] = tuple;
auto & [i,k,l] = tuple;
```

Zu beachten ist, dass alle Variablen hier die selbe `const`-ness haben und entweder alle als Referenz oder By-Value gelesen werden. 
Die Structured bindings funktionieren auch im Zusammenhang mit Klassen, allerdings ist dies etwas Problematisch, da die Semantik von Klassenmember keine starke Reihenfolge der Member vorsieht. Es gibt Möglichkeiten diese Semantik nachzuimplementieren, allerdings ist dies vergleichsweise aufwändig. 

# Verzweigungen mit Initialisierung

Auf den ersten Blick ist die Einführung direkten Initialisierung in `if`- und `switch`-statements in C++17 eine Möglichkeit Code noch ein kleines bisschen kompakter schreiben. Ein weiter etwas versteckter Vorteil ist, dass der Programmierer seine Absicht, dass ein Symbol nur innerhalb einer Verzweigung verwendet wird deutlicher ausdrücken kann. Die Initialisierung direkt neben bzw. in der Bedingung zu haben verhindert auch die Gefahr, dass sie bei Refactorings (unabsichtlich) von der Verzweigung getrennt wird. 


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

Im Zusammenhang mit den oben genannten Structures Bindings kann die direkte Initialisierung sehr elegant verwendet werden. 
Im folgenden Beispiel wird versucht ein bereits existierender Wert in einer `std::map` zu überschreiben. Der Rückgabewert von `insert` wird direkt in einen iterator und das flag, ob die operation erfolgreich war entpackt und kann somit direkt innerhalb der Abfrage verwendet werden. 

```cpp

std::map<char, int> map;
map['a'] = 123;

if(const auto [position, inserted] = map.insert({'a', 1000}); !inserted)
{
  std::cout << "'a' already exists with value " << position->second << "\n";
}

```

# Stark typisierte Enums

In den neuen Standards haben `enum`s einige Verbesserungen erfahren. Der unterliegenden Datentyp lässt sich nun explizit spezifizieren, was der Plattformunabhängigkeit von Code zu gute kommt. 


```cpp
enum Color : uint8_t { Red, Green, Blue }; 
```

```cpp
enum class Sound { Boing, Gloop, Crack };

auto s = Sound::Boing;

```

1. final
1. using declarations
1. Delegating constructors (inkl. using)
1. =delete
1. guaranteed copy elision
1. structured bindings
1. selection statements with initializers

1. strongly typed enums
1. standard atttributes
1. ```__has_include```


1. ```<filesystem>```
1. ```<algorithm>```


** The new standards have modernized C++ significantly and this is a good thing.** But it's not just the "big" new features such as smart-pointers, variadic templates and move semantics that make the new standards so powerful. They come with a a lot of small-but-nice additions that often pass below the radar of the casual C++ programmer. Together with many changes and additions to the STL these make for a powerful combination in writing nice code. g

* Code quality on the lowest level - No architecture 
* 

# features: 

* structured bindings
* initializers in conditional statements
* using - maybe split
* guaranteed copy elision
* Delegating constructors (inkl. using)
* <algorithm> too big, maybe split
* standard atttributes
* __has_include
* <filesystem>
* strongly typed enums

* final, default, delete
* static assertions
* noexcept
* nested namespace definition
* initialisierung von lambda captures
* type traits (too big)
* unordered containers



# ideas

* using over typedef



 Die Einführung der neuen Standards C++11/14/17 hat C++ merklich modernisiert. Nebst solchen grossen Sprachfeatures wie smart-pointers, move semantics und varaidic templates gibt es auch noch eine ganze Menge an kleineren Erweiterungen die oftmals unter dem Radar fliegen. Aber gerade diese Features können Helfen C++ Code merklich zu vereinfachen und Wartbarer zu machen. Dies gekoppelt mit neuen Features in der STL können helfen viele kleine Fehlerchen schon beim schreiben des Codes zu verhindern. Dass der Code sich dabei auch noch leichter liest und stabiler wird sind weitere erfreuliche Nebeneffekte. 10 dieser kleinen aber feinen Features werden hier aufgezeigt und etwas genauer unter die Lupe genommen.
Gliederung

* Wartbarer/Lesbarer Code was ist das?
* 10 Beispiele (inklusive Code) aus dem Alltag die den Code lesbarer machen.
Nutzen und Besonderheiten

Die Teilnehmer erhalten eine Übersicht und konrete Inputs über C++ Sprachkonstrukte welche Code wartbarer machen. Sowohl neuer Code als auch Refactoring von bestehendem Code wird besprochen. Nebst den Benefits der Features wird auch auf allfällige Gefahren und Pitfalls eingegangen. Die Teilnehmer erhalten die Möglichkeit Fragen zu den einzelnen Features zu stellen und diese kritisch zu diskutieren. 
