---
layout: post
title: Vertraglich zugesicherte Code-Robustheit
thumbnail: images/cpp_logo.png
unlisted: true
---

**99.9% der Softwarefehler werden von Programmierer verursacht.** Testen und Code Reviews helfen zwar, sind aber nicht immer genug. Viel schöner wäre es, wenn ich als Programmierer eine falsche Verwendung meines Codes von vornherein Abfangen könnte. Mit "Design by Contract" kriegen wir Softwareingenieure ein Werkzeug für genau diesen Zweck in die Hände. 
Programmcode wird durch "Design by Contract" aber nicht nur korrekter, sondern auch lesbarer und somit wartbarer. Und nicht zuletzt wird mit diesem Werkzeug Code auch robuster gegenüber Regressionsfehler. 
Einige Programmiersprachen kennen das Konzept bereits als natürliche Spracheigenschaft[^1], aber auch wenn dies nicht der Fall ist, lässt sich die Unterstützung für "Contracts" leicht einbauen. 

## Wartbarer und robuster Code

Dinge wie Clean Code, das SOLID-Prinzip oder Paradigmen wie Low Coupling, Strong Cohesion sind wichtige Aspekte von Codequalität und der Softwarewartbarkeit. Aber Wartbarkeit beginnt bereits bei der Lesbarkeit eines Programmcodes und das das heisst auch, die **Absicht die hinter dem geschriebenen Code steckt einfach erkennbar ist**. 
Kann diese  Absicht nun auch formal verifiziert werden wird der Wartbarkeit auch noch Robustheit hinzugefügt. Robuster Code heisst, dass eine Software nicht **unerwartet** in einen undefinierten Zustand fällt. Robust heisst aber auch, dass eine Software sich bei Veränderungen am Code nicht unerwartet anders als gewollt verhält. Unabhängig vom Problem das eine Software löst ist es ein innerste Qualitätsmerkmal, dass sich die Software so wie erwartet verhält. Bringt eine Software dies nicht mit sind eingefrorene Displays, unerwartete Abstürze und häufige Neustarts oder schlimmeres das Ergebnis. 

Mit Design by Contract können wir diese Robustheit wirkungsvoll erhöhen und so dem Programmierer in seiner oder ihrer Kernaufgabe helfen. 

## Was ist nun Design by Contract? 

Design by Contract ist ein Mittel um präzise und verifizierbare Interface-Spezifikationen für Funktionen und Klassen direkt im Programmcode definieren zu können. Der Begriff "Design by Contract" wurde von [Bertrand Meyer](https://en.wikipedia.org/wiki/Bertrand_Meyer) im Zusammenhang mit der von ihm entwickelten Programmiersprache Eiffel bekannt gemacht. Heute werden auch *Contract Programming*, *Programming by Contracts* oder einfach nur *Contracts* als Synonyme verwendet. Im wesentlichen beschreibt das Konzept die Umsetzung des [Hoare Tripels](https://de.wikipedia.org/wiki/Hoare-Kalk%C3%BCl) zur Überprüfung der Korrektheit von Software. 
Dieses wird definiert als `{P}C{Q}`, wobei `P` und `Q` Assertions sind und `C` das ausführende Programm. Ist die Vorbedingung `P` gegeben wird durch die Ausführung von `C` die Nachbedingung `Q` sichergestellt.  

Der "Contract" - zu Deutsch Vertrag - ist eine Metapher für die Beziehung zwischen dem Programmierer als "Konsument" und einer Software als "Anbieter" von Code. Der so aufgesetzte sinngemässe vertrag regelt die zu erwarteten Nutzen unter der Voraussetzung der Erfüllung der Verpflichtungen der beiden Vertragsparteien. Ein Beispiel für einen Vertrag für eine Funktion um Wurzeln zu ziehen könnte lauten: 

 |               | **Verpflichtung**                                                  | **Nutzen**                                                                       |
 | ------------- | ------------------------------------------------------------------ | -------------------------------------------------------------------------------- |
 | **Konsument** | *Muss Vorbedingung erfüllen* <br>Der Eingabewert muss positiv sein | *Darf die Nachbedingung erwarten*<br> Erhalte die Quadratwurzel des Eingabewerts |
 | **Anbieter**  | *Muss Nachbedingung erfüllen* <br>Berechne die Quadratwurzel       | *Darf die Vorbedingung erwarten*<br> Muss imaginäre Zahlen nicht implementieren  |

Typischerweise werden `require` und `ensure` als Schlüsselwörter für die Vor- und die Nachbedingungen gewählt. der "Vertragsinhalt" ist dabei ein konstanter boolscher Ausdruck. [^2] 

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

Ein weiteres Schlüsselwort ist `invariant` dieses Zeigt an, dass diese Bedingung zu keinem Punkt der Laufzeit verletzt werden darf und ist somit in diesem Programmkontext ein Axiom ist. Diese invarianten treten häufig im Zusammenhang mit Klassen aus der Objektorientierten Programmierung auf um sicherzustellen, dass der Zustand eines Objekts konsistent ist. Zudem liefern solche invarianten oft auf wertvolle hinweise zum erwarteten Verhalten. 

In einer Containerklasse muss zum Beispiel die Anzahl der gespeicherten Elemente immer kleiner-gleich der Speicherkapazität sein, ansonsten funktioniert die Software nicht mehr korrekt. Festzustellen ob diese Invariante nun durch einen Fehler in der Implementierung oder durch einen äusseren Einfluss verletzt wurde ist jedoch Aufgabe des Programmierers. 

Stellen wir uns eine Liste vor, die jeden Wert nur einmal beinhalten darf könnte die Anwendung von Contracts wie folgt aussehen. 

```cpp
class uniqueList {
public:
  void add(int element) {
    require(!has_element(element));
    // implementation
    invariant(count() <= capacity());

    ensure(!has_element(element));
  }

  bool has_element(int element) const {
    // implementation
  }
  size_t capacity() const {
    // implementation
  }
  size_t count() const {
    // implementation
  }
};
```

Durch die Verwendung der Contracts wird in diesem Beispiel definiert dass Sicherzustellen dass die Werte einzigartig sind ausserhalb der Klasse implementiert werden muss. Somit reduziert sich die Komplexität des Codes in der Klasse drastisch und die Diskussion was das "korrekte" verhalten im Falle von Duplikaten ist muss in diesem Kontext nicht beantwortet werden.  

### Contracts und Vererbung

Wird von einer Klasse abgeleitet und Funktionen überschrieben gelten folgende Regeln: 
* **Invarianten** bleiben erhalten
* **Vorbedingungen** dürfen abgeschwächt werden, aber nicht stärker werden
* **Nachbedingungen** dürfen stärker sein, aber nicht abgeschwächt werden

In anderen Worten dürfen abgeleitete Klassen in einem lockereren Kontext funktionieren, müssen aber nach Ausführung im Minimum die selben Nachbedingungen erfüllen. 

## Nutzen in der Praxis

Der primäre Nutzen von Contracts besteht darin, dass Programmierfehler früh aufgedeckt werden und zielgerichteter gefunden werden können. Ausgefeiltere Implementationen bieten dem Programmierer hier wertvolle Hinweise wie an welcher Zeile des Codes ein Contract verletzt wurde, Stack-Traces oder sogar die Möglichkeit direkt mit dem Debugger an die richtige Stelle zu springen.     

Nebst der formalen Überprüfung (meist zur Laufzeit) kann Design by Contract auch als Dokumentation gelesen werden. Durch die konsequente Anwendung wird der Design -prozess unterstützt, dadurch das Schnittstellen bereits früh formal definiert werden. Zudem wird der vorgesehene Verwendungskontext der Software beschrieben und eingeengt, was einer falschen Verwendung entgegen wirkt. So wird der Verwendungskontext unserer Funktion zum Wurzelziehen auf die "Nicht-Negative Fliesskommazahlen" reduziert. Dadurch erübrigt sich eine aufwändige Fehlerbehandlung von Zahlen die nicht in unserem Verwendungskontext sind und der Code wird deutlich weniger Komplex. 

Dabei ist aber anzumerken, dass Contracts eine Hilfestellung bzw. ein Werkzeug für Softwareentwickler sind und keine Fehlermeldungen für den Endbenutzer. 

## Zusammenspiel mit (unit-) Testing

Design by Contract ersetzt das Testing nicht, sondern ergänzt es. Während klassisches Testing, wie z.b. Unit-Testing überprüft ob sich eine Software korrekt verhält, überprüfen contracts ob eine Software vom Programmierer richtig verwendet wird. Schlägt ein contract fehl, darf als Konsequenz auch einem positiven Testergebnis nicht vertraut werden. Typischerweise setzen Contracts aber durchgängig bei allen Stufen der Testpyramide an. 
Die Verwendung von Design by Contracts vermindert oft die Komplexität der Tests, weil nicht jeder Edge Case getestet werden muss, sondern zum mit Contracts abgefangen werden kann. 

Da die Überprüfung der Contracts oft nicht ohne Einfluss auf die Laufzeit geschieht, werden contracts üblicherweise aus der ausgelieferten, getesteten Software entfernt. Der Programmierer muss sich diesem Einfluss bewusst sein um so klar funktionales Testing von nicht-funktionalem Testing wie Speicherverbrauch, Laufzeit- und Echtzeitverhalten zu trennen.

## Fazit

Design by Contract ist eine - leider - sehr wenig beachtete Methode um Software qualitativ besser zu machen. Dies einerseits durch das hinzufügen einer weiteren Stufe zur "Qualitätskontrolle" die Orthogonal zum klassischen Test-Ansatz steht, aber auch durch einen Eingriff in die Softwareentwicklungspraxis selbst. Der Programmierer wird mit Nachdruck dazu angehalten sich Gedanken zu machen in welchem Kontext seine Software funktionieren soll und dies dann explizit und überprüfbar auszudrücken. Dies erlaubt unter anderem eine differenziertere Diskussion über den Code beim Pair-Programming oder bei Code Reviews. 

Und schlussendlich treibt Design by Contract die "Fail early, fail hard" Mentalität vorwärts. Eine Software lässt sich beim Entdecken von Qualitätsmängel nicht mehr weiter betreiben bzw.. weiter  entwickeln bevor diese Qualitätsmängel nicht behoben sind. Bevor Festgestellt wird ob eine Software das tut was sie soll, wird so sichergestellt dass sie zumindest so funktioniert wie definiert. 

Alles in Allem ist Design by Contract eine Methode um Code mit wenig Aufwand robuster im Betrieb und in der Wartung zu machen. 


[^1]: Contracts sollten ursprünglich in C++20 integriert werden, wurden jedoch im Juli 2019 beim Komiteetreffen in Köln wieder herausgestrichen

[^2]: Eine simple Beispielimplementation für Contracts findet sich hier: https://github.com/bernedom/bertrand/ 

--- 

Quellen: 
* https://www.eiffel.com/values/design-by-contract/introduction/
* http://se.inf.ethz.ch/~meyer/publications/computer/contract.pdf 


