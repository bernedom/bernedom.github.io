name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
---

Vertraglich zugesicherte code-Robustheit
===

### Robuster, Lesbarer Code mit Design by Contract

#### Dominik Berner - Coder, Agilist, rock Climber

![](logo_bbv_thumb.png)

???

# Begrüssung

Worum geht es? Architektur/Software-engineering praxis für besseren code. Code muss heute nicht nur einmal geschrieben werden, sondern auch für ide Zukunft wartbar sein. 

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
.center[
  ![bbv_logo](logo_bbv_thumb.png)
  ]
]
 

???

# 10+ Jahre erfahrung mit C++
# Seit Anfang an auf c++11 (Cx::TR1)
# Bürokollege der an Eiffel mitgearbeitet hat - Intro in Design by COntract
# Grafik- und Simulationsengine ca 300'000 Zeilen Code mit Design by Contract

Computergrafik, Medtech

# Agilist -> Konstantes Refactoren

# Arbeiten mit gutem code ist ein Genuss

### Pfadfinder-mentalität: Lass den Code etwas besser zurück als du ihn angetroffen hast

---

# Guter Code? 
.left[
```cpp
double squareroot(double x) {
  static constexpr int num_iterations = 101;
  if (x == 0)
    return 0;

  double guess = x;
  for (int i = 0; i < num_iterations; i++)
    guess -= (guess * guess - x) / (2 * guess);
  return guess;
}
```
]

???

# TODO tabelle mit ergebnissen

Guter Code
* lässt die Absicht dahinter erkennen
* Falsche Verwendung durch Programmierer schwierig
* Korrekt - tut was er soll, in dem Kontext den er soll

Newtonsches Wurzelziehen
Probleme hier: Negative zahlen? Performance optimierung = weniger iterationen = resultat falsch 
Sollte man ja eigentlich nicht selbst implementieren - Nur illustratives beispiel 
--

### Nicht schlecht, aber...

* Was passiert mit negativen Zahlen? 
* Kann der mit NaN umgehen?
* Wartbarkeit? Refactorings & Optimierungen?

???

Fragen über Fragen, hier hilft design by contract

# Robuster code == Gegen regression bugs und falsche verwendung geschützt

---

# Design by Contract?!

### "Der 'Contract' ist eine Metapher für die Beziehung zwischen dem Programmierer als 'Konsument' und einer Software als 'Anbieter' von Code."

.left[
* Formale Software-Spezifikation
* Dokumentation
* Hilfestellung beim Design-Prozess
* Definition vom Verwendungskontext der Softwarefunktionen
]

#### Und das alles im Code drin!

???

# Fail early, fail hard

Bertrand Meyer - Aus der programmiersprache eiffel 1986 erstmals in einem Artikel beschrieben

* formale software spezifikation und verifikation
* Dokumentation
* hilfestellung beim Design-Prozess
* Klare Abgenzung über verwendungskontext von Softwarefunktionen

* KEINE Fehlermeldungen, diagnostics
* Informiert den Programmierer, nicht den benutzer

"contract" ist eine Metapher - Vertrag zwischen benutzer und anbieter von code
    What does the contract expect?
    What does the contract guarantee?
    What does the contract maintain?

# hoare Tripple

---

# Ein Hoare-Tripel als Vertrag 

#### `{P}C{Q}` - Wenn '`P`' dann stellt die Ausführung von '`C`' sicher dass '`Q`' 
Oder als Contract formuliert
#### **require** `P`, so execution of `C` **ensures** `Q`

 |               | **Verpflichtung**             | **Nutzen**                        |
 | ------------- | ----------------------------- | --------------------------------- |
 | **Konsument** | *Muss Vorbedingung erfüllen*  | *Darf die Nachbedingung erwarten* |
 | **Anbieter**  | *Muss Nachbedingung erfüllen* | *Darf die Vorbedingung erwarten*  |

???


---

# Beispiel - Quadratwurzel

 |               | **Verpflichtung**                 | **Nutzen**                                 |
 | ------------- | --------------------------------- | ------------------------------------------ |
 | **Konsument** | Der Eingabewert muss positiv sein | Erhalte die Quadratwurzel des Eingabewerts |
 | **Anbieter**  | Berechne die Quadratwurzel        | Muss imaginäre Zahlen nicht implementieren |


???

--

.left[
```cpp
double squareroot(double x) {
* require(x >= 0);
  static constexpr int num_iterations = 101;
  if (x == 0)
    return 0;

  double guess = x;
  for (int i = 0; i < num_iterations; i++)
    guess -= (guess * guess - x) / (2 * guess);
* ensure(fabs(guess * guess - x) < numeric_limits<double>::epsilon());
  return guess;
}
```
]

???

require handled Nan auch gleich, weil alle vergleiche mit NaN false sind

---

# Eine Vertraglich abgesicherte Klasse

.left[
```cpp
class uniqueIntList {
public:
  void add(int element) {
*   require(!has_element(element));
    list_.emplace_back(element);

*   ensure(has_element(element));
*   invariant(count() <= capacity());
  }

  bool has_element(int element) const {
    return std::find(list_.begin(), list_.end(), element) \
      != list_.end();
  }
  size_t capacity() const { return list_.capacity(); }
  size_t count() const { return list_.size(); }

private:
  vector<int> list_;
};
```
]

---

# Objektorientierung und Contracts

### Klasseninvarianten

.left[
* Garantieren konsitenten Objektzustand zwischen ausführungen von public Methoden
]

### Vererbung: 

.left[
* **Invarianten** bleiben bei bestehen
* **Vorbedingungen** dürfen abgeschwächt werden, aber nicht stärker werden
* **Nachbedingungen** dürfen stärker sein, aber nicht abgeschwächt werden
]

---

# Implementierung (in C++)

* In wenigen Sprachen nativer support (Eiffel, D, Kotlin...) :(
* Als natürliches Sprachfeature vielleicht in ~~C++20~~ C++23
* Oft Support durch externe Libraries z.b. Boost.Contract, Loki
* Eigene triviale implementation als "`contract`" entspricht `assert`


???

triviale Umsetzung mit Asserts, boost.contract

--

.left[
```cpp
#include <cassert>
#define require assert
#define ensure assert
#define invariant assert
```
]

Beispiel: https://github.com/bernedom/bertrand/ 

---

# Schön, aber was jetzt - Nutzen in der Praxis

.left[
 
* Fail early, fail hard
* Dokumentation - Verwendungskontext schaffen
* Weitere elemente z.b. Text zum Contract und Stack traces
* Ort der Fehlerbehandlung klar definieren - Weniger Code, Weniger Bugs
* Komplexität des Codes wird reduziert
  
]

###  Contracts sind ein Werkzeug für den Programmierer - Nicht für den Endbenutzer!
---

# Ist das nicht testing?

![Venn diagramm testing, docu, dbc](images/contract_testing_docu.png)

???

Dbc - Korrekte verwendung der Software
Unittesting - Verhält sich die Software korrekt
Dokumentation - Wie verwende ich das richtig

DbC ersetzt (unit) testen nicht, sondern komplementiert
Tests werden simpler, weil edge cases anders abgefangen

Wenn contracts failen, soll nicht getestet werden

---

# Fazit

* Starkes Mittel für Codequalität
* Leider zu wenig bekannt/gebraucht
* Formale Spezifikation im code - Regulatorisch interessant
* Anfangs gewöhnungsbedürftig, dann nicht mehr wegzudenken

---

# Fragen

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

---

Notizen / Backup

???


Vertraglich zugesicherte Code-Robustheit
Robuster, Lesbarer Code mit Design by Contract

100% der Softwarefehler werden vom Programmierer verursacht. Testen und Code Reviews helfen zwar, sind aber nicht genug. Viel schöner wäre es, wenn ich als Programmierer eine falsche Verwendung meines Codes von vornherein Abfangen könnte. Mit "Design by Contract" kriegen wir ein Werkzeug für genau diesen Zweck in die Hände. Aber nicht nur die Korrektheit, sondern auch die Lesbarkeit, Wartbarkeit und Robustheit des Codes wird damit erhöht. Ab C++20 ist dieses Konzept endlich auch "nativ" in C++ verfügbar, aber auch heute lässt es sich schon mit wenig Aufwand anwenden. Wie funktioniert dieses Konzept? Wie setze ich es um? Und welchen Einfluss hat das auf das Testing? In diesem Vortrag werden die Antworten auf diese und weitere Fragen ausführlich erläutert. 
 

Gliederung
* Was heisst Design by Contract?
* Wie setzte ich das mit C++ in der Praxis um?
* Wie sieht das C++20 vor?
* Wie spielt dies mit meinem Testing zusammen? 

Nutzen und Besonderheiten
Die Teilnehmer erhalten eine Einführung in "Design by Contract" sowie konkrete Hinweise zur Anwendung in bestehendem C++ Code. Nebst der Anwendung auf kleiner Stufe wird der Einsatz im kompletten Entwicklungszyklus besprochen. Die Teilnehmer erhalten die Möglichkeit Fragen zum Konzept von "Design by Contract" zu stellen und das Konzept kritisch zu diskutieren.

Über den Referenten
	
Dominik Berner ist ein Senior Software-Ingenieur bei der bbv Software Services AG mit einer Leidenschaft für modernes C++. Die Wartbarkeit von Code ist für ihn kein Nebeneffekt, sondern ein primäres Qualitätsmerkmal das für die Entwicklung von langlebiger Software unabdingbar ist. Als Blogger und Speaker and Konferenzen und Meetups weiss er wie Inhalte zu verpacken sind, damit für das Publikum ein Mehrwert entsteht.

http://docplayer.org/4165643-Design-by-contract-in-java.html