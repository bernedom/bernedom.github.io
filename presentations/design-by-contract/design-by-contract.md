name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
---

Vertraglich zugesicherte Code-Robustheit
===

### Robuster, Lesbarer Code mit Design by Contract

#### Dominik Berner - Coder, Agilist, Rock Climber

![](logo_bbv_thumb.png)

???

# Begrüssung

## Die meisten Softwarefehler werden durch Programmierer verursacht

## Code wird heute nicht nur einmal geschrieben, sondern auch in Zukunft oft wieder angefasst

## unerwünschte Nebeneffekte und Regression Bugs sind dabei natürlich unerwünscht. 

# Design by contract ist eine Software-Engineering-Praxis für besseren Code. 

# Intro - keine vertiefte analyse

# Überblick & Ablauf

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

# 10+ Jahre erfahrung mit (modernem) C++
# Bürokollege der an Eiffel mitgearbeitet hat - Intro in Design by COntract
# Grafik- und Simulationsengine ca 300'000 Zeilen Code mit Design by Contract

# Agilist -> Konstantes Refactoren


## Pfadfinder-mentalität: Lass den Code etwas besser zurück als du ihn angetroffen hast

# Arbeiten mit gutem code ist ein Genuss

---

# Guter Code? 


???

Guter Code
* lässt die Absicht dahinter erkennen
* Falsche Verwendung durch Programmierer schwierig
* Korrekt - tut was er soll, in dem Kontext den er soll
* Kann gewartet werden
* lesbar 

--

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
## Newtonsches Wurzelziehen
Wert Konvergiert zum Ergebnis

# Ist das guter code?

## Sollte man ja eigentlich nicht selbst implementieren - Nur illustratives Beispiel 

13
7.46154
5.40603
5.01525
5.00002
5
5

--

### Naja...

* Was passiert mit negativen Zahlen? 
* Kann der mit NaN umgehen?
* Wartbarkeit? Refactorings & Optimierungen?
* Implementation durch library-funktion ersetzen? 
* Fehlerbehandlung?

???

## Probleme hier: Negative zahlen? Performance optimierung = weniger iterationen = resultat falsch 

Fragen über Fragen, hier hilft design by contract

# Robuster code == Gegen regression bugs und falsche verwendung geschützt

# Hier hilft Design by Contract


---

# Asserts!

.left[
```cpp
double squareroot(double x) {
* Require(x >= 0); // <-- This is an assert
  static constexpr int num_iterations = 101;
  if (x == 0)
    return 0;

  double guess = x;
  for (int i = 0; i < num_iterations; i++)
    guess -= (guess * guess - x) / (2 * guess);
* Ensure(fabs(guess * guess - x) < \
*    numeric_limits<double>::epsilon()); // <-- Also an assert
  return guess;
}
```
]

### Das ist Design by Contract!

???

# Assert

# wird der Vertrag verletzt, beendet das programm mit einem Fehler!

require handled Nan auch gleich, weil alle vergleiche mit NaN false sind

# Negative Zahlen Behandelt, NaN Behandelt
# Fehlerbehandlung dieser Fälle hat bitteschön ausserhalb zu geschehen
# Hardening gegen refactoring (auch im umliegenden kontext)

---



# Design by Contract?!

### "Der 'Contract' bzw. 'Vertrag' ist eine Metapher für die Beziehung zwischen dem Programmierer als *'Konsument'* und einer Software als *'Anbieter'* von Code."

???

# Was ist design by contract?

* Hilft genau solche Fragen zu beantworten

# Bertrand Meyer - Aus der programmiersprache eiffel 1986 erstmals in einem Artikel beschrieben

## Programmierer Werkzeug

## Fail early, fail hard

* KEINE Fehlermeldungen, diagnostics
* Informiert den Programmierer, nicht den benutzer

# Wie sieht ein korrekt implementiertes Programm in der Theoretischen Informatik aus?
# hoare Triple

 
---

# Achtung Theorie! - Hoare Logik

### `{P}C{Q}` - Wenn '`P`' dann stellt die Ausführung von '`C`' sicher dass '`Q`' 
Oder als Contract formuliert
### **require** that `P`, so execution of `C` **ensures** `Q`

???

## Hoare-Logik ist ein formales System, um die Korrektheit von Programmen nachzuweisen

# Set von Regeln, die aussagen über Korrektheit von Software zu treffen

# Korrektheit - Verhält sich die Software wie sie soll, nicht ist das was sie tut sinnvoll

## Require und Ensure Schlüsselwörter design by contract

## Umgekehrt nicht gültig: Nur weil Q heisst nicht, dass P auch wahr ist

--

 |               | **Verpflichtung**             | **Nutzen**                        |
 | ------------- | ----------------------------- | --------------------------------- |
 | **Konsument** | *Muss Vorbedingung erfüllen*  | *Darf die Nachbedingung erwarten* |
 | **Anbieter**  | *Muss Nachbedingung erfüllen* | *Darf die Vorbedingung erwarten*  |

???

# Wenn wir das als Vertrag auslegen: Muss und Darf 

---

# Beispiel - Quadratwurzel

 |               | **Verpflichtung** | **Nutzen**                                     |
 | ------------- | ----------------- | ---------------------------------------------- |
 | **Konsument** | ?                 | **Erhalte die Quadratwurzel des Eingabewerts** |
 | **Anbieter**  | ?                 | ?                                              |


???

# Ich will die Quadratwurzel des Eingabewerts kriegen
---

# Beispiel - Quadratwurzel

 |               | **Verpflichtung**              | **Nutzen**                                 |
 | ------------- | ------------------------------ | ------------------------------------------ |
 | **Konsument** | ?                              | Erhalte die Quadratwurzel des Eingabewerts |
 | **Anbieter**  | **Berechne die Quadratwurzel** | ?                                          |

???

# Der Anbieter soll mir das liefern

# Unter allen Umständen???

---

# Beispiel - Quadratwurzel

 |               | **Verpflichtung**          | **Nutzen**                                     |
 | ------------- | -------------------------- | ---------------------------------------------- |
 | **Konsument** | ?                          | Erhalte die Quadratwurzel des Eingabewerts     |
 | **Anbieter**  | Berechne die Quadratwurzel | **Muss imaginäre Zahlen nicht implementieren** |

???

# Der Anbieter soll mir das liefern

# Unter allen Umständen???

---

# Beispiel - Quadratwurzel

 |               | **Verpflichtung**                 | **Nutzen**                                 |
 | ------------- | --------------------------------- | ------------------------------------------ |
 | **Konsument** | Der Eingabewert muss positiv sein | Erhalte die Quadratwurzel des Eingabewerts |
 | **Anbieter**  | Berechne die Quadratwurzel        | Muss imaginäre Zahlen nicht implementieren |

???

# Konsument, Ok ich fütter dich nur mit positiven Zahlen (und 0)

---

# Eine vertraglich abgesicherte Klasse

.left[
```cpp
class UniqueIntList {
public:
  void add(int element); 



  bool has_element(int element) const;
  
  size_t capacity() const;

  size_t count() const; 

};
```
]

???

# Beispiel, Liste mit einmaligen werden (Macht das nicht selbst!)

# Entweder aufwändige Fehlerbehandlung ODER absicherung mit contracts

# Benutzer soll schauen, dass die Werte einmaligs sind

---

# Eine vertraglich abgesicherte Klasse

.left[
```cpp
class UniqueIntList {
public:
  void add(int element) {
*   Require(!has_element(element));
    list_.emplace_back(element);

*   Ensure(has_element(element));
*   Invariant(count() <= capacity());
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

???

# Mit code befüllt

## Invarianten: Garantieren konsitenten Objektzustand zwischen ausführungen von public Methoden

## Was passiert bei Vererbung?

---

# Vererbung und Verträge

.left[
* **Invarianten** bleiben bei bestehen
* **Vorbedingungen** dürfen abgeschwächt werden, aber nicht stärker werden
* **Nachbedingungen** dürfen stärker sein, aber nicht abgeschwächt werden
]

???

# Erbende Klassen müssen Verträge der Eltern erfüllen. 

# Das ist eigentlich schon das meiste. Require, Ensure, Invariant

---

# Aus der Praxis: Implementierung (in C++)
.left[
* In wenigen Sprachen nativer Support (Eiffel, D, Kotlin...)
* Vielleicht in ~~C++20~~ C++23
* Support durch externe Libraries z.b. Boost.Contract, Loki
* Eigene triviale Implementation als "`contract`" entspricht `assert`
]

???

# triviale Umsetzung mit Asserts, boost.contract

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

???

# Wichtig: Contracts gehören nicht in produktiven code!

---

# DbC und Softwarequalität

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

.left[
 
* Umsetzung von "Fail early fail hard" bzw. Stop and Fix
* Verwendungskontext und Ort der Fehlerbehandlung klar definieren
  * Komplexität des Codes wird reduziert
  * Weniger Code, Weniger Bugs
* Formale Spezifikation im Code - Regulatorisch interessant
* Weitere Elemente z.b. Text zum Contract und Stack Traces
* Einfacher Einbau in bestehenden Code
  
]

###  Contracts sind ein Werkzeug für den Programmierer - Nicht für den Endbenutzer!

???

# Fragen und Beispiele für den Verwendungszweck? 

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