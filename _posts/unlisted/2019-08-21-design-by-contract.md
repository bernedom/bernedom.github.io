---
layout: post
title: Vertraglich zugesicherte Code-Robustheit
thumbnail: images/cpp_logo.png
unlisted: true
---

100% der Softwarefehler werden vom Programmierer verursacht. Testen und Code Reviews helfen zwar, sind aber nicht genug. Viel schöner wäre es, wenn ich als Programmierer eine falsche Verwendung meines Codes von vornherein Abfangen könnte. Mit "Design by Contract" kriegen wir ein Werkzeug für genau diesen Zweck in die Hände. Aber nicht nur die Korrektheit, sondern auch die Lesbarkeit, Wartbarkeit und Robustheit des Codes wird damit erhöht. Es ist sogar geplant diese Konzept in nächsten C++ Standard nativ einzubauen leider ist der Zeitpunkt dafür noch nicht definiert[^1]. Aber auch heute lassen sich sogenannte Contracts auch mit wenig Aufwand anwenden und auch in bestehende Software einbauen. 

# Robuster, wartbarer code

Dinge wie Clean Code, das SOLID-Prinzip oder Paradigmen wie Low Coupling, Strong Cohesion sind wichtige Aspekte von Codequalität und der Softwarewartbarkeit. Aber Wartbarkeit beginnt bereits bei der Lesbarkeit eines Programmcodes und das das heisst auch, die **Absicht die hinter dem geschriebenen Code steckt einfach erkennbar ist**. 
Kann diese  Absicht nun auch formal verifiziert werden wird der wartbarkeit auch noch robustheit hinzugefügt. Robuster code heisst, dass eine software nicht **unerwartet** in einen undefinierten Zustand fallen darf. Mit design by contract können wir dies wirkungsvoll verhindern und so dem Programmierer in seiner oder ihrer Kernaufgabe helfen. Unabhängig vom Problem das eine Software löst ist es das innerste Qualitätsmerkmal, dass sie nicht unerwartet in einen undefinierten Zustand fallen kann und zu jedem Zeitpunkt deterministisch verhält. Eingefrorene Displays, unerwartete Abstürze und häufige Reboots sind das Ergebnis von Software die diese Robustheit nicht mit sich bringt. 

# Was ist nun design by contract? 

Design by contract ist ein Mittel, wie Programmierer formelle, präzise und verfizierbare interface-spezifikationen für Softwarekomponententen definieren können. [Bertrand Meyer](https://en.wikipedia.org/wiki/Bertrand_Meyer) hat den Begriff "Design by Contract" im zusammenhang mit der von ihm entwickelten Programmiersprache Eiffel bekannt gemacht. Das Konzept ist auch unter *Contract Programming*, *Programming by Contracts* oder einfach kurz als *Contracts* bekannt. Im wesentlichen beschreibt das Konzept die Umsetzung bzw. eine Analogie für des [Hoare Triple](https://de.wikipedia.org/wiki/Hoare-Kalk%C3%BCl) zur Überprüfung der Korrektheit von Software. Dieses wird definiert als `{P}C{Q}` wobei `P` und `Q` assertions sind und `C` das ausführende Programm. Ist die Vorbedingung `P` gegeben wird durch die Ausführung von `C` die Nachbedingung `Q` sichergestellt.  

Der "Contract" - zu Deutsch Vertrag - ist eine Metapher für die Beziehung zwischen dem Programmierer als "Konsument" und einer Software als "Anbieter" von code. Der so aufgesetzte sinngemässe vertrag regelt die zu erwarteten Nutzen unter der Voraussetzung der erfüllung der Verpflichtungen der beiden Vertragsparteien. Ein Beispiel für einen Vertrag für eine Funktion um Wurzeln zu ziehen könnte lauten: 

 |               | **Verpflichtung**                                              | **Nutzen**                                                                   |
 | ------------- | -------------------------------------------------------------- | ---------------------------------------------------------------------------- |
 | **Konsument** | *Muss Vorbedingung erfüllen* Der Eingabewert muss positiv sein | *Darf die Nachbedingung erwarten* Erhalte die Quadratwurzel des Eingabewerts |
 | ** Anbieter** | *Muss Nachbedingung erfüllen* Berechne die Quadratwurzel       | *Darf die Vorbedingung erwarten* Muss imaginäre Zahlen nicht implementieren  |

Oder als Code formuliert: 
```cpp

float square_root(float f)
{
    require(f => 0); // precondition
     /// implementation
    ensure((result * result) - f < std::numeric_limimts<float>::epsilon); // post condition
    return result; 
}
```
`require` und `ensure` sind Schlüsselwörter aus design by contract und dienen zur überprüfung der Verpflichtungen. 

Ein weiteres Schlüsselwort ist `invariant` dieses Zeigt an, dass diese Bediungung zu keinem Punkt der Laufzeit verletzt werden darf und ist somit als eine Art Axiom im Programmkontext zu verstehen. Diese invarianten treten häufig im Zusammenhang mit Klassen aus der Objektorientierten Programmierung auf um sicherzustellen, dass der Zustand eines Objekts konsitent ist. Zudem liefern solche invarianten oft auf wertvolle hinweise zum erwarteten Verhalten. 

In einer Containerklasse muss zum beispiel die Anzahl der gespeicherten Elemente immer kleiner-gleich der Speicherkapazität sein, ansonsten funktioniert die Software nicht mehr korrekt. Festzustellen ob diese Invariante nun durch einen Fehler in der Implementierung oder durch einen äusseren Einfluss  verletzt wurde ist jedoch aufgabe des Programmierers. 

Der primäre Nutzen von Contracts besteht darin, dass Programmierfehler früh aufgedeckt werden und zielgerichteter gefunden werden können. Ausgefeiltere Implementationen bieten dem Programmierer hier wertvolle Hinweise wie an werlcher Zeile des Codes ein Contract verletzt wurde, Stack-Traces oder sogar die Möglichkeit direkt mit dem Debugger an die richtie Stelle zu springen.     

Nebst der formalen Überprüfung (meist zur Laufzeit) kann design by contract auch als Dokumentation gelesen werden. Durch die konsequente Anwendung wird der Design-prozess unterstützt, dadurch das Schnittstellen bereits früh formal definiert werden. Zudem wird der vorgesehene Verwendungskontext der Software beschrieben und eingegengt, was einer falschen Verwendung entgegen wirkt. So wird der Verwendungskontext unserer Funktion zum Wurzelziehen auf die "Nicht-Negative Fliesskommazahlen" reduziert. Dadurch erübrigt sich eine aufwändige Fehlerbehandlung von Zahlen, die nicht in unserem Verwendungskontext sind. 

Dabei ist aber anzumerken, dass Contracts eine Hilfestellung bzw. ein Werkzeug für Softwareentwickler sind und keine Fehlermeldungen für den Endbenutzer. 

## Umsetzung von Design by contract

Es existieren verschieden Implementierungen für Design-by-contract, einei Sprachen beinhalten das Konzept sogar als natürliche Sprachfeature. Die einfachst denkbare Implementation ist die verwendung von `asserts` als contracts und die Maskierung mit den spezifischen Schlüsselwörtern `require`, `ensure` und `invariant`. 

Wird ein Contract nicht erfüllt, stoppt das Programm unmittelbar mit einem Fehler/Nicht-0 Rückgabewert. Eine ganz triviale Implementation könnte wie folgt aussehen. 

```cpp
#ifndef NDEBUG
#include <cassert>
#define require(ARG) assert(ARG)
#define ensure(ARG) assert(ARG)
#define invariant(ARG) assert(ARG)
#else
#define require(ARG) (void(0))
#define ensure(ARG) (void(0))
#define invariant(ARG) (void(0))
#endif
```

## Zusammenspiel mit dem (unit-) Testing

Design by contract ersetzt das Testing nicht, sondern ergänzt es. Während klassisches Testing, wie z.b. Unit-Testing überprüft ob sich eine Software korrekt verhält, überprüfen contracts ob eine Software vom Programmierer richtig verwendet wird. Schlägt ein contract fehl, darf als Konsequenz auch einem positiven Testergebnis nicht vertraut werden. Typischerweise setzen contracts aber durchgängig bei allen Stufen der Testpyramide, von einfachen unit-test bis hin zum komplexen Systemtest an. 

Da die Überprüfung der Contracts oft nicht ohne Einfluss auf die Laufzeit geschieht, werden contracts üblicherweise aus der ausgelieferten, getesteten Software entfernt. 


[^1]: Contracts sollten ursprünglich in C++20 integriert werden, wurden jedoch im Juli 2019 beim Komittetreffen in Köln wieder herausgestrichen

--- 

Quellen: https://www.eiffel.com/values/design-by-contract/introduction/


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


https://www.javaworld.com/article/2074956/icontract--design-by-contract-in-java.html