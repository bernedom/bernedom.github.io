name: title
layout: true
class: center, middle, inverse

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
---

Vertraglich zugesicherte code-robustheit
===

## Robuster, Lesbarer Code mit Design by Contract

### Dominik Berner - Coder, Agilist, rock Climber

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

```cpp
double squareroot(double x) {
  static constexpr int num_iterations = 10;
  if (x == 0)
    return 0;

  double guess = x;
  for (int i = 0; i < num_iterations; i++)
    guess -= (guess * guess - x) / (2 * guess);
  return guess;
}
```

???

Guter Code
* lässt die Absicht dahinter erkennen
* Falsche Verwendung durch Programmierer schwierig
* Korrekt - tut was er soll, in dem Kontext den er soll

Newtonsches Wurzelziehen
Probleme hier: Negative zahlen? Performance optimierung = weniger iterationen = resultat falsch 
Sollte man ja eigentlich nicht selbst implementieren - Nur illustratives beispiel 

Was nun tun 

---

# Design by Contract?!

???

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

# ein Vertrag 

https://www.eiffel.com/values/design-by-contract/introduction/

 	Obligations 	Benefits
Client 	(Must ensure precondition)

Be at the Santa Barbara airport at least 5 minutes before scheduled departure time. Bring only acceptable baggage. Pay ticket price.
	(May benefit from postcondition)

Reach Chicago.
Supplier 	(Must ensure postcondition)

Bring customer to Chicago.
	(May assume precondition)

No need to carry passenger who is late, has unacceptable baggage, or has not paid ticket price.

---

# Beispiel

TBD

??? 

Beispiel simple funktion
Beispiel klasse, objekt invariante

---

# Umsetzung

???

triviale umsetzung mit Asserts, boost.contract

# Fail hard, fail early 

C++20 proposal

Bei failure korrekte funktion der software nicht garantiert

Dokumentation

---

# Gefahren

???

Langsam, sollten im echten leben draussen sein
- Vererbung: Subklassen dürfen preconditions abschwächen und post conditions und invarianten stärken

---

# Ist das nicht testing?

???

DbC ersetzt (unit) testen nicht, sondern komplementiert
Tests werden simpler, weil edge cases anders abgefangen

Wenn contracts failen, soll nicht getestet werden

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