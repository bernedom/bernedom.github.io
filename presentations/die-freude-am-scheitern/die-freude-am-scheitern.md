name: title
layout: true
class: center, top, inverse
background-position: center
background-repeat: no-repeat
background-size: contain

.footer[ [![twitter](twitter_icon.png) @BernerDominik](https://twitter.com/BernerDominik)]
---
class: center, middle, inverse
background-image: url(images/title_background.jpg)

# Die Freude am Scheitern

## Dominik Berner
### Software Engineer, Agilist, Rock Climber


![](logo_bbv_thumb.png)

???
 
#"Wir lernen nur durch scheitern" - reinhold messner

Das gilt nicht nur fürs Klettern, sondern überall im Leben. 

Ihr kennt mich als Software Ingineur und Agilist, aber ich bin auch begeisterter Kletterer
Seit über 10 Jahren besteige ich Berge. 

# Wie gehe ich mit fehlschlägen um, wo darf ich fehlschlagen, wo besser nicht

## Fehlschläge sind wichtig, aber um sie zu verstehen müssen wir auch die erfolge erleben

Erfolge sind cool und geben uns Mut

---
background-image: url(images/oben_sein.jpg)
# Erfolge feiern!

???



# Geschichte erzählen

Stellt euch vor... 
 
* Oben auf dem Gipfel stehen, wissend, dass man toughes geleistet hat. Tief einatmen, aussicht geniessen
* Software ausgeliefert, wissend dass man da was nützliches gebaut hat. Tief einatmen, Kundenfeedback geniessen

 wieder runterkommen und noch Jahrelang vom Trip Schwärmen
 - Software Ausliefern, Kundenzufriedenheit über Jahre erleben - Noch Jahrelang vom Erlebnis schwärmen


# Schön wenn es klappt - Der Alltag sieht oft anders aus!

---
background-image: url(images/Falling.jpeg)
# Fehlschläge erleben!

.credit[
  https://www.stocksy.com/1198104/rock-climber-falling-whilst-climbing-a-mountain-cliff
]
???

## hoppla das wäre schöner gegegangen
bis zu
## Fatale Konsequenzen 

Über die Jahre habe ich das Scheitern selbst etwas genauer unter die Lupe genommen. 

Das fängt beim "hups ich hab mich am Haken festgehalten" and und endet dort wo jemand verletzt wird oder stirbt. 
Kleine unschönheiten in der Software bis zu, boeing 737 debakel, Fehler die unternehmen und Lebensgrundlagen zerstören. 

Klettern gibt Einblicke in wie wir scheitern. Das Scheitern ist dort oft unmittelbarer und greifbarer als in der Software. Das Restrisiko spielt mit, aber man hat es selbst in de hand. 

# Arten von Scheitern

--

![](images/dangermeter.png)

???

# Zwischen den extremen gibt es Zwischenschritte

---
background-image: url(images/Falling.jpeg)
# Fehlschläge erleben!

![](images/dangermeter_sport.png)

???

## Am Sport Scheitern/Sportlich scheitern 
   Nicht so nice, TDD nicht geklappt, Technologie nicht ideal, route nicht rotpunkt
   **Passiert uns täglich, normalbetrieb** 

## Das soll uns nicht aufhalten
## kontiniuerlich verbessern

---
background-image: url(images/Falling.jpeg)
# Fehlschläge erleben!

![](images/dangermeter_controlled.png)

???

## Kontrollierter Abbruch 
   Stichwort kontrolliert, Der Gipfel bleibt unerreichbar, zurück auf den Boden. Feature lässt sich so nicht ausliefern, zurück auf start nochmals aufrollen, architektur überdenken. Code endet nicht in der Produktion 
   **und dann nochmals vom Boden auf einsteigen**  
   **Passiert uns ab- und zu mal** - Kann dennoch ganz OK sein. 

---
background-image: url(images/Falling.jpeg)
# Fehlschläge erleben!

![](images/dangermeter_getting_away.png)

???


## Nochmals davon kommen" 
  Teilweise Kontrollverlust. Nur Glück entscheidet über Ausgang - Code ist in produktion, man merkt es aber bevor schlimmeres passiert.  jemand ist bereits leicht verletzt, man lässt Material am Berg.
  **Selten, aber wenn...** 

---
background-image: url(images/Falling.jpeg)
# Fehlschläge erleben!

![](images/dangermeter_catastrophic.png)

???


## Katastrophaler Fehlschlag
 Glück hat nicht gereicht, Konsequenzen sind potentiell Schwerwiegend. Von längerer downtime bis "Du wirst nie mehr Klettern/Programmieren. 
 Code ist nicht nur in produktion sondern schaden ist auch aktiv
  - Herzschrittmacher mit Zeitüberlauf 256 Schläge/min
  - Boeing 737
 **Hier wollen wir ums verrrecken nicht sein!**

### Die Grenzen zwischen den Sektoren sind unscharf und individuell
- Können und Erfahrung

# Aber wo ist die Freude?

---
background-image: url(images/rega.jpg)
# Warum wird es gefährlich?

![](images/inherent_risk.png)

.credit[  ["Staying alive" by John Dill of the YSAR ](http://www.bluebison.net/yosar/alive.htm)]

???

Warum geraten wir in die orange oder rote Zone? 

Wir haben ein Restrisiko/Inherentes Risiko. 
* Steinschlag, Materialfehler trotz redundanz, freak accidents
* Finanzkrise, Heartbleed, Meltdown und Spectre, Konkurrenz ist schon viel weiter

- Können wir nicht Kontrollieren, die Umstände geben das vor
* Kletterhalle vs Alpin 
* Standard-Problem vs Forschung, Unkritische Software - Business oder lebenswichtige Software

Was tun wir um das Restrisiko zu vermindern? Wir ändern die Umstände.
Korrelation, je mehr ich kann, desto schwierigere Bedingungen, desto mehr Restrisiko. 

# Nur - Das Restrisiko ist meistens sehr klein

---

background-image: url(images/rega.jpg)
# Warum wird es gefährlich?

![](images/accidents-reasons.png)


???

Die Gründe für die meisten Unfälle. Darum befindet man sich auch der miesen Seite des Problems
Ignorance - Ignoranz, Unwissen
Casualness - Fahr-) lässigkeit
Distraction - Ablenkung

# Die Spielen zusammen

* Ignorance - Ich weiss einfach nicht genug. Kann die Knöpfe nicht - Kenn die Technologie nicht, hab meine Marktforschung nicht gemacht etc. 
  * Ganz Gemein - Unknown unknowns
* Causalness - Das passt schon so, das kann ich ungesichert. Redundanz brauch ich hier nicht. Das lern ich während ichs mache. 
  * Auch Arroganz sich selbst gegenüber
* Distraction - Nicht aufs Ziel/Problem/Hier-und-jetzt fokussiert/hab zu viel auf der Platte. - Geh nicht mit frischen Mamas und Papas klettern. Mach keine kritische Software wenn du verliebt bist. Auch momentane ablenkung. Manche Probleme brauchen ununterbrochene Aufmerksamkeit

---
background-image: url(images/Falling.jpeg)
# Zu weit gehen

![](images/dangermeter_lightened.png)

???

## An der Grenze zwischen Gelb und Orange passiert etwas spannendes

Man ist unbewusst zu weit gegangen und hat ein Teil der Kontrolle verloren. 

Orange: Vermutlich viele kleine Aspekte die uns hierhin gebracht haben.
 - Ob selbst schuld oder nicht ist egal

**Bsp. Haken nicht richtig gesetzt, Pendelsturz Fersenbeinbruch - Exit aus Route
 DB Update verhauen - Alle Order der letzten 24h weg** 

## Hier lernt man extrem viel über sich
**Man muss wissen wie weit man zu weit gehen darf**

* Kleinhirn setzt ein **"Flight, Fight or Freeze"** - Dem gilt es zu widerstehen - Erfahrung Hilft hier viel

### Ziel wieder die Kontrolle erreichen
* Voller Fokus alles gelernte wird aktiviert und angewendet
  * Rollbacks, Schaden eingrenzen, Krisenkommunikation 
* Teamwork wird enorm wichtig
  * Braucht vertrauen und brutale Ehrlichkeit auch sich selbst gegenüber
  
Schritt für Schritt wird die Lösung erarbeitet
- SW Rollback, Stabilisieren, 

**Bis man wieder im gelben ist.** 

---
background-image: url(images/retro.jpg)
# Runterkommen - Retrospektive


???

# Versuchung zu widerstehen dass nun alles Grün ist. **
ohne Abstieg auf den Boden nicht mehr werden.

# Retrospektive - Revue passieren lassen & lernen

## Offen und ehrlich 
## Wie gerieten wir in diese Situation
### Wie haben wir uns verhalten - wo müssen wir lernen
### Wer fühlte sich im Orangen bereich, wer im roten, wer im grünen
### Ganz runter, lernen, drübver schlafen

## Anruf, komm das machen wir nochmals

---
background-image: url(images/celebrate_success.jpg)
# Die Freude am Scheitern

???

Und dann ist man wieder zurück am Fels 
Oder man packt die Software nochmals an

Vorbereitet, Nervös und los gehts

Schlüsselstelle voller Angst - 

Oben ankommen wissen dass man es besser gemacht hat als man es vorher gekonnt hätte

# Das meine Freunde ist die Freude Am Scheitern 
# Danke!

