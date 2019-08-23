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

Design by contract ist ein Mittel, wie Programmierer formelle, präzise und verfizierbare interface-spezifikationen für Softwarekomponententen definieren können. [Bertrand Meyer](https://en.wikipedia.org/wiki/Bertrand_Meyer) hat den Begriff "Design by Contract" im zusammenhang mit der von ihm entwickelten Programmiersprache Eiffel bekannt gemacht. Das Konzept ist auch unter *Contract Programming*, *Programming by Contracts* oder einfach kurz als *Contracts* bekannt.



```cpp

float square_root(float f)
{
    require(f => 0); // precondition
     /// implentatoin
    ensure((result * result) - f < std::numeric_limimts<float>::epsilon); // post condition
    return result; 
}

```


[^1]: Contracts sollten ursprünglich in C++20 integriert werden, wurden jedoch im Juli 2019 beim Komittetreffen in Köln wieder herausgestrichen

--- 


Vertraglich zugesicherte Code-Robustheit
Robuster, Lesbarer Code mit Design by Contract

100% der Softwarefehler werden vom Programmierer verursacht. Testen und Code Reviews helfen zwar, sind aber nicht genug. Viel schöner wäre es, wenn ich als Programmierer eine falsche Verwendung meines Codes von vornherein Abfangen könnte. Mit "Design by Contract" kriegen wir ein Werkzeug für genau diesen Zweck in die Hände. Aber nicht nur die Korrektheit, sondern auch die Lesbarkeit, Wartbarkeit und Robustheit des Codes wird damit erhöht. Ab C++20 ist dieses Konzept endlich auch "nativ" in C++ verfügbar, aber auch heute lässt es sich schon mit wenig Aufwand anwenden. Wie funktioniert dieses Konzept? Wie setze ich es um? Und welchen Einfluss hat das auf das Testing? In diesem Vortrag werden die Antworten auf diese und weitere Fragen ausführlich erläutert. 
 

Gliederung
* Was heisst Design by Contract?
* Wie setzte ich das mit C++ in der Praxis um?
* Wie sieht das C++20 vor?
* Wie spielt dies mit meinem Testing zusammen? 

https://www.javaworld.com/article/2074956/icontract--design-by-contract-in-java.html