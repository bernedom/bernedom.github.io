---
layout: post
title: Standard Attributes - CleanCode for C++17
thumbnail: images/cpp_logo.png
---

**Good code is self-documenting** - We coders love this sentence and with the standard attributes available since C++11 we are one step closer to this utopia. 

The first standard attributes ```noreturn```` and ```carries_dependency``` are alreadyy available since C++11. C++14 brought us the very much loved ```deprecated``` and with C++17 we now also got ```fallthrough``, ```nodiscard``` and ```maybe_unused```.

Additionally, the introduction of the ```[[]]``` notation gave us an answer for the compiler specific syntaxes like ```#pragma```, ```__attribute__()```, ```__declspec```` and whatever else there is out there. The attrributes together with the unified notation allows us now, as CleanCode dictates, to explicitely state a specific intent for of the coder, static code analyzers and even the compiler. 


## ```[[noreturn]]``` (C++11)

This should not be the norm, but there are certain cases in which functions to not return properly. An example is a call to an ```exit()```` or if there is always an exception thrown. In this case the function should be decorated with ```[[noreturn]]]``` to give a hint that this is a special method. But beware: should any function decorated like this return normally, the behavior is undefined. 

```cpp
[[noreturn]]void always_throw() { throw 123; };
```

## [[deprecated]] (C++14)

During the lifetime of a software it is often the case that parts of the code should no longer be used, for instance because there is a new and better implementation available. With the attribute ```[[deprecated]]``` can such parts of the code be annotated. Not just functions, but also classes and even namespaces, template specialisations and enums can be annotated. C++17 added an option to decorate the attribute with a string to give the user a hint for possible migrations. If code that is annotated like this is used the compiler prints out a warning. 

```cpp
// Deprecation with a reason
[[deprecated("black magic is evil")]] void black_magic(){};

// generates a compiler warning if called
[[deprecated]] void ancient_magic() {}
```

## [[fallthrough]](C++17)
Wenn auch normalerweise ungern gesehen, kommt es doch in gewissen Fällen vor, dass wir in einem switch-case Statement die Codeteile des darauffolgenden case-Blocks mit ausführen wollen. Im folgenden Code-Stück soll zum Beispiel im Fall 'b' auch der Code von 'c' mit ausgeführt werden.

[sourcecode lang="cpp"]
switch (c) {
  case 'a':
    f();
    break;
  case 'b':
    g();
    [[fallthrough]];
  case 'c':
    h();
    break;
  case 'd': //no [[fallthrough]] necessary
  case 'e':
    e();
    break;
}
[/sourcecode]
Mit dem Attribut [[fallthrough]] können wir nun unseren Kollegen und der statischen Codeanalyse explizit deutlich machen, dass dies genau unsere Absicht war. Hätten wir andererseits für den Fall 'a' das break vergessen, kann uns nun der Compiler auf den Fehler aufmerksam machen. In GCC 7 ist dies mit der Option -Wimplicit-fallthrough beziehungsweise mit-Wextra möglich. Leere case-statements, wie hier im Fall 'd', ohne break produzieren weiterhin auch ohne  [[fallthrough]] keine Warnung.

[[nodiscard]](C++17)
Dies ist ebenfalls ein besonders hilfreiches Attribut für den täglichen Gebrauch. Wie oft haben wir schon Funktionsaufrufe gesehen von Funktionen, die einen bool oder einen int als Statuscode zurückgeben, wo dieser dann aber geflissentlich ignoriert wird. Mit [[nodiscard]] können wir solche Situation endlich verhindern. Und um dem noch eins draufzusetzen, kann [[nodiscard]] auch gleich für einen ganzen Datentyp gesetzt werden. So kann man als Library-entwickler den Benutzer mit Nachdruck auffordern gewisse Arten von Rückgabewerten weiter zu behandeln.

[sourcecode lang="cpp"]
struct[[nodiscard]] demon{}; // Demons need to be kept and named
struct ghost {}; 

demon summon_demon() { return demon(); }

// summoned ghosts need to be kept
[[nodiscard]] ghost summon_ghost() { return ghost(); }

void summon() {
  auto d = summon_demon(); // OK
  auto g = summon_ghost(); // OK
  // Compiler Warning, because returned demon is not kept
  summon_demon();

  // Compiler Warning, because the function of summoning is nodiscard
  summon_ghost();
}
[/sourcecode]
[[maybe_unused]](C++17)
Wer kennt das nicht, wir möchten im debug mode einen erweiterten Assert in eine Funktion einbauen z.b. um Design by Contract zu realisieren, aber das passt irgendwie nicht ohne eine zusätzliche Variable und nun schimpft der Compiler im Release mode – wo wir den assert nicht mehr rein kompilieren, dass die Variable nicht mehr benutzt wird. Seit C++17 können wir das mit [[maybe_unused]] zusätzlich markieren. Das Attribut beinflusst nur die Ausgabe von Compiler Warnungen. Wenn eine Variable [[maybe_unused]] deklariert wird, kann sie vom Compiler nach wie vor weg optimiert werden, falls sie nicht gebraucht wird.

[sourcecode lang="cpp"]
[[maybe_unused]] void f([[maybe_unused]] bool thing1,
 [[maybe_unused]] bool thing2) {
  [[maybe_unused]] bool b = thing1 && thing2;

  assert(b); // if assert is compiled out and b is unused

  assert(thing1 &&
    thing2); // parameters thing1 and thing2 are not used, no warning
}
[/sourcecode]
[[carries_dependency]](C++11)

Carries dependency gibt dem Benutzer und dem Compiler einen Hinweis, dass Speicher im Zusammenhang mit atomics "transparent" behandelt werden kann.

[sourcecode lang="cpp"]
void opaque_func(int *p){/* do something with p */};​

[[carries_dependency]] void transparent_func(int *p) {
 /* do something with p */
}

void illustrate_carries_dependency() {
 std::atomic<int *> p;
 int *atomic = p.load(std::memory_order_consume);

if (atomic)
 std::cout << *atomic << std::endl; // transparent for the the compiler

if (atomic)
 opaque_func(atomic); // if from another compile unit and not inline, the
 // compiler might construct a memory fence here

if (atomic)
 transparent_func(atomic); // marked as to work in the same memory-dependency
 // tree, compiler can omit the memory fence
}
[/sourcecode]
Nebst der erweiterten Dokumentation sind Standard Attribute vor allem ein weiterer Schritt in Richtung "Weg mit den Dialekten - Ein C++ für alle Compiler und Plattformen". Ein guter Weg der mit C++11/14 begonnen wurde und mit C++17 weiter getrieben wurde. Wir sind bereits gespannt auf die nächsten Änderungen in C++20.



(This article was originally [published at bbv.ch in german](http://blog.bbv.ch/2018/01/29/einfacher-coden-mit-c17-selection-statement-mit-initializer/)

![bbv software services logo]({{ site.baseurl }}/images/logo_bbv_thumb.png)
