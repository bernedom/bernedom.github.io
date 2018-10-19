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

# Vererbung mit kontrollieren mit `override` und `final`

Wann immer eine Funktion in einem Vererbungsbaum überschrieben wird sollte seit C++11 `override` verwendet werden. Damit wird eine überschriebene Funktion automatisch virtuell und der Compiler erhält die möglichkeit um zu überprüfen ob auch tatsächlich eine Methode überschrieben wird und ob die überschriebene Methode auch tatsächlich virtuell ist. 

```cpp

struct Base
{
  virtual int func() { return 1; }
};

struct Derived : public Base
{
  // Compiler-Error if Base::func does not exist or is not virtual
  int func() override { return 2; }; 
};

```

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

Andere High-Level Programmiersprachhttps://www.youtube.com/watch?v=P32hvk8b13Men kennen das "Verketten" von Konstruktoren schon länger und seit C++11 ist dies auch in C++ möglich. Die Vorteile von weniger dupliziertem Code und damit einfacherer Lesbarkweit und somit bessere Wartbarkeit liegen dabei auf der Hand. Gerade bei Konstruktoren die intern komplizierte Initialisierungen oder Checks durchführen hilft dies sehr und hilft bei der Umsetzung des RAII (Resource Allocation is Initialisation) paradigma, weil unter Umständen auf abgesetzte Initialisierung-Funktionen verzichtet werden kann. 

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

Enums sind seit langem bekannt und ein of zitiertes Ärgernis ist, dass die Typensicherheit bei der Verwendung nur ungenügend sichergestellt ist. So war es in der Vergangenheit Möglich ein wert eines Enum-Typs einer Variable eines anderen Enum-Typs zuzuweisen. Mit den den neuen Standards gehört dies bei korrekter Verwendung der vergangenheit an. Wird einer `enum` definition das Keyword `class` oder `struct` hinzugefügt wird daraus ein stark typisierter Datentyp und eine Verwendung mit einem anderen `enum`-Typ führt je nach Konfiguration zu einer Warnung oder einem Fehler beim Kompilieren.
Sozusagen als zusätzlichttps://www.youtube.com/watch?v=P32hvk8b13Mhen Seiteneffekt kann seit C++11 auch der unterliegende Datentyp für ein enum explizit angegeben werden, was der portabilität des Codes zu Gute kommt. 

```cpp
enum Color : uint8_t { Red, Green, Blue }; 
```

```cpp
enum class Sound { Boing, Gloop, Crack };

auto s = Sound::Boing;

```

# Standardattribute

Attribute sind seit längerem für verschiedene Compiler bekannt, allerdins war die Notation für die verschiedenen Compiler oft unterschiedlich. Seit C++17 wurde diese als `[[ attribute ]]` standardisiert was portablen den Code lesbarer macht. Zudem wurden verschiedene von allen Compilern unterstützte Standardattribute eingefügt, welche es dem Programmierer erlauben seine Absichten für gewisse Konstrukte explizit zu formulieren

|`[[noreturn]]`| Zeigt an, dass eine Funktion nicht zurückkehrt, z.B. weil sie immer eine exception wift |
|`[[deprecated]]` `[[deprecated("reason")]]`| Zeigt an, dass die verwendung dieser Klasse, Funktion oder Variable zwar erlaubt, aber nicht mehr empfohlen ist |
|`[[fallthrough]]` | Verwenddet in `switch`-statement um anzuzeigen, dass ein `case:`-block mit absicht kein `break` beinhaltet |
|`[[nodiscard]]` | Produziert eine Compiler-Warnung falls ein so markierter Rückgabewert nicht verwendet wird |
|`[[maybe_unused]]` | Unterdrückt Compiler-Warnungen bei nicht verwendeten Variablen. z.B. in Debug-code |


# Zeit-Literale mit `<chrono>`

Das handling von Zeiteinheiten ist für viele Programmierer ein Albtraum. Die Gründe sind vielfältig, von der nicht-linearen Aufteilung von Sekunden, Minuten und Stunden bis hin, dass schnell mal Verwirrung entsteht um welche Zeiteinheit sich bei einem Aufruf wie `sleep(100)`. Handelt es sich hier um Sekunden? Millisekunden? Mit der Einführung von `std::chrono` in C++11 und dem Hinzufügen von Zeitliteralen wird das Handling um einiges einfacher. 
Durch die Verwendung der von `std::chrono` mitgelieferten Zeiteinheiten lassen sich Zeitwerte bereits zur compile-time konvertieren und das lästige manuelle Umrechnen zur Laufzeit gehört der Vergangenheit an. 

```cpp

using namespace std::chrono_literals;

auto seconds = 10s;
auto very_small = 1us;

if(very_small < seconds) // automatic, compile-time conversion 
{
...
}

```

# Fazit

Diese 10 kleinen Features und Funktionen sind natürlich nur ein kleiner Teil davon, was modernes C++ ausmacht. Aber durch deren konsequente Anwendung kann Code mit relativ wenig Aufwand lesbarer und einfacher Verständlich gemacht werden, ohne dass die Komplette Struktur einer existierenden Codebase gleich umgesschrieben werden muss. 



