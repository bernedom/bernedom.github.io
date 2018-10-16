+ ---
layout: post
title: 10 kleine Dinge die C++ einfacher machen
thumbnail: images/cpp_logo.png
---

# Kleine Sprachfeatures ins C++?

Die neuen C++ Standards haben die Programmiersprache merklich modernisiert und teilweise ganz neue Programmierparadigmen in die Welt von C++ eingebracht. Die "grossen" Änderungen wie Variadic Templates, `auto`, move-semantics, Lambda-Expressions und weitere haben für viel Diskussionsstoff gesorgt und sind dementsprechend mittlerweile auch weitherum bekannt. Nebst den Sprachfeatures hat auch die Standard-Library eine merkliche Erweiterung erfahren und hat viele der Konzepte von Bibliotheken von Drittanbietern wie zum Beispiel `boost` auch in einer "Standard-Umgebung" zur verfügung gestellt. Aber nebst diesen sehr spürbaren und teilweise auch umstrittenen Features gibt es eine ganze Menge an kleinen-aber-feinen Spracherweiterungen die oft unter dem Radar fliegen und weit weniger bekannt sind. 

Aber gerade weil diese Features oft sehr klein und teilweise fast unsichtbar sind haben sie grosses Potential um im Programmiereralltag das Leben einfacher zu machen. Denn auch wenn zum Beispiel Variadic Templates eine sehr spannende und mächtige Angelegenheit sind, schreiben wir ungleich mehr nicht-termplatisierten Code. Auch Lambda-Expressions haben ihre daseinsberechtigung, aber vermutlich schreiben wir dennoch viel häufiger konventionelle Funkntionen und Methoden. Gerade weil der grossteil unseres Codes nicht aus der Verwendung der neuen "Killer-Features" besteht lohnt es sich das Augenmerk dort auf Lesbarkeit und Wartbarkeit zu legen.

# Moderner, Wartbarer Code

Wartbarkeit, Lesbarkeit und Code-Qualität sind Themen die aus der heutigen Software-Entwicklung nicht mehr wegzudenken sind. Gerade im Zuge der Agilisierung wo Code nicht nur einmal sondern bewusst mehrmals überarbeitet, veränderdert und angepasst wird sind dies zentrale Themen. Dinge wie Clean Code, das SOLID-Prinzip oder Paradigmen wie Low Coupling, Strong Cohesion sind ein wichtiger Aspekt von Codequalität, aber im kleinsten beginnt diese bereits bei der Verwendung der Sprache selbst. Das Verwenden von den von der Sprache zur Verfügung gestellten Features und Funktionen hilft die **Absicht hinter dem geschriebenen Code** zu verdeutlichen. Zudem kann oft dadurch die Menge von geschriebenem Code reduziert werden und dies hilft nach dem Prinzip von "Less code means less bugs" der Qualität auch wieder enorm. 

Ein einfacher Algorithmus kann sehr kompliziert zu verstehen sein, wenn die Schreibweise nicht den Erwartungen entsprechen oder der vorgängige Autor sich einen besonders schlauen Hack zur Optimierung einfallen lies.
So kann zum Beispiel das tauschen von zwei variablen `x` und `y` wie folgt geschrieben werden: 

```lang=c++

x = x ^ y; 
y = y ^ x;
x = x ^ y;

```

Dieser XOR-Swap ist zwar Speichereffizient und hat in ganz spezifischen Fällen seine Daseinsberechtigung, aber intuitiv lesbar ist die Operation nicht. Selbst mit einem Code-Kommentar versehen zwingt dieses einfach Beispiel dem leser unnötige Denkarbeit auf. Dem gegenübergestellt liest sich das folgende Beispiel viel einfacher: 

```lang=c++
std::swap(x,y);
```
 
Die folgenden 10 kleine Erweiterungen aus C++11 - C++17 helfen Code kompakt und lesbar zu halten und somit die Code-Qualität zu verbessern.

# `Using`-Declarations und Konstruktorenvererbung

`using`-Deklarationen erlauben es dem Programmierer ein Symbol von einer deklarativen Region, wie Namespaces, Klassen und Strukturen in einen anderen zu "importieren" ohne dass zusätzlicher code generiert wird. Bei Klassen ist dies vor allem nützlich um Konstruktoren von Basisklassen direkt zu übernehmen, ohne dass alle Varianten neu geschrieben werden müssen. Ein weiteres Beispiel ist um Ko-Variante Implementierungen in Abgeleiteten Klassen explizit zu gestalten. Damit wird dem dem Leser klar signalisiert, dass hier eine "fremde" Implementation verwendet wird, die keine funktionale Modifikation erfahren hat. 

```
struct A
{
  A() {}
  explicit A(char c {}

  int get_x(); 
}

struct B : public A
{
  using A::A; // get all constructors from A
  private:
    using A::get_x;  // <-- get_x is now private
}
``` 

Seit C++17 funktioniert das übernehmen von Symbolen auch für (verschachtelte) Namespaces: 

void f(){
    // Do something
}

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




1. structured bindings
1. selection statements with initializers
1. default, delete, final
1. using declarations
1. guaranteed copy elision
1. Delegating constructors (inkl. using)
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
