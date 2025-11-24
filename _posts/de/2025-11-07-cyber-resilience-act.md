--- 
layout: post
title: "Der Cyber Resilience Act ist keine schwarze Magie: Ein pragmatischer Einstieg"
description: "Praktischer Leitfaden zum EU Cyber Resilience Act: zentrale Anforderungen, Security-by-Design, Vulnerability Management, Incident Response, SBOM & inkrementelle Compliance."
image: /images/cyber-resilience-act/thumbnail.jpg
hero_image: /images/cyber-resilience-act/thumbnail.jpg
hero_darken: true
tags: cyber-resilience-act
lang: de
---

**Der EU Cyber Resilience Act (CRA) wird zu einer wegweisenden Regulierung für Softwaresicherheit in Europa.** Mit dem [geplanten Inkrafttreten ab September 2026](https://eur-lex.europa.eu/eli/reg/2024/2847/oj/eng) müssen Unternehmen, die Software oder eingebettete Geräte entwickeln, seine Anforderungen erfüllen - sonst riskieren sie den Zugang zum EU-Markt zu verlieren. Das klingt zunächst einschüchternd, ist aber oft weniger überwältigend als gedacht. Dieser Beitrag bietet einen praxisnahen Überblick darüber, was der CRA verlangt, was Unternehmen etablieren müssen und wie sie Schritt für Schritt beginnen können.

## Der Cyber Resilience Act auf einen Blick

Kurz gesagt ist der Cyber Resilience Act (CRA) eine Verordnung der Europäischen Union, die die Cybersicherheit von Produkten mit digitalen Elementen stärken soll - einschliesslich Software und vernetzten Hardwaregeräten. Der CRA definiert grundlegende Sicherheitsanforderungen über den gesamten Lebenszyklus eines Produkts: von Entwurf und Entwicklung über Auslieferung bis zu Wartung. Der Begriff **„Produkte mit digitalen Elementen“** ist weit gefasst und umfasst jedes Produkt, das auf Software angewiesen ist – etwa IoT-Geräte, Medizinprodukte, industrielle Steuerungen und allgemeine Softwareanwendungen.

Im Kern konzentriert sich der CRA auf drei Hauptbereiche:

* Security-by-Design: Sicherheitsmassnahmen von Anfang an in den Entwicklungs- und Designprozess integrieren.
* Vulnerability Management und Incident Response: Prozesse zum Identifizieren, Melden und Beheben von Schwachstellen über den gesamten Lebenszyklus einführen. Einen Incident-Response-Plan pflegen, um Sicherheitsvorfälle effektiv zu bewältigen.
* Compliance-Dokumentation: Umfassende Nachweise führen, die die Erfüllung der CRA-Anforderungen belegen.

{%include figure.html url="images/cyber-resilience-act/cra_pillars.jpg" description="Drei Hauptkomponenten für Compliance mit dem Cyber Resilience Act: Security-by-Design, Vulnerability Management, Compliance-Dokumentation" %}

Was versteckt sich hinter diesen Anforderungen im Detail? Schauen wir uns die wichtigsten Punkte an.

### Security-by-Design

Security-by-Design ist ein Grundprinzip des CRA und oft der technischste Teil. Sicherheitsaspekte müssen integraler Bestandteil von Architektur, Design und Entwicklung sein. Unternehmen sollen sichere Coding-Praktiken anwenden, regelmässige Sicherheitstests durchführen (z.B. statische und dynamische Analyse, Fuzzing, Penetrationstests) und sicherstellen, dass Produkte widerstandsfähig gegen verbreitete Cyberbedrohungen sind. Produkte sollten Angriffsflächen minimieren und sensible Daten schützen. Aber was ist mit bestehenden Produkten? Müssen sie komplett neu entworfen werden? Nicht zwingend. Der CRA erkennt an, dass viele Produkte bereits im Markt sind und erlaubt einen risikobasierten Ansatz für Verbesserungen.

> Der CRA erkennt an, dass viele Produkte bereits im Markt sind und erlaubt einen risikobasierten Ansatz für Sicherheitsverbesserungen.

Das bedeutet: Unternehmen sollten zunächst Sicherheitsstatus und Bedrohungslage ihrer bestehenden Produkte analysieren. Danach können sie Verbesserungen nach Risiko priorisieren und schrittweise umsetzen. Wichtig: Viele Sicherheitsprobleme lassen sich auch ohne Codeänderung mitigieren - etwa durch Begrenzung der Exposition gegenüber Angriffsvektoren oder bessere Nutzerführung.

### Vulnerability Management und Incident Response

Die Autoren des CRA wissen: Keine Software ist perfekt, und Schwachstellen werden über die Zeit gefunden. Deshalb fordert der CRA strukturierte Prozesse für Vulnerability Management und Incident Response. Kernelemente des Vulnerability Management sind: einen Kanal für Meldungen schaffen, eingehende Hinweise triagieren, Kunden über existierende Schwachstellen informieren und zeitnahe Behebung sicherstellen. Oft lassen sich bestehende Feedback- oder Bug-Report-Prozesse erweitern, statt neu zu beginnen.

Während proaktives Schwachstellenmanagement wichtig ist, müssen Unternehmen auch auf Sicherheitsvorfälle vorbereitet sein. Das hängt eng mit Vulnerability Management zusammen und kann teilweise dieselben Werkzeuge nutzen.

> Incident Response bedeutet, einen klaren Plan mit Rollen, Verantwortlichkeiten und Kommunikationswegen für den Sicherheitsvorfall bereitzuhalten.

Der entscheidendste Teil ist ein klarer Incident-Response-Plan: Wer übernimmt die Leitung? Wer muss im Krisenraum sitzen? Welche Reaktionszeiten gelten? Wer darf Entscheidungen treffen, um den Vorfall einzudämmen, Auswirkungen zu reduzieren und den Normalbetrieb wiederherzustellen? Der dritte Baustein für CRA-Bereitschaft ist eine umfassende Compliance-Dokumentation.

### Compliance-Dokumentation

Falls Ihr Unternehmen vom CRA betroffen ist, existiert oft bereits eine gewisse Compliance-Dokumentation – viele andere Regulierungen (z. B. DSGVO oder branchenspezifische Standards) verlangen ähnliche Nachweise. Gute Nachricht: Darauf lässt sich aufbauen. Falls noch nichts vorhanden ist: Keine Panik - die Erstellung ist keine unlösbare Aufgabe. Was wird benötigt? Zunächst müssen die Aktivitäten aus den vorigen Abschnitten dokumentiert werden: Security-by-Design-Praktiken, Prozesse für Vulnerability Management und Incident Response.

> Keine Panik - die Erstellung der notwendigen Dokumentation für den CRA ist keine unlösbare Aufgabe.

Zusätzlich müssen Unternehmen Aufzeichnungen über Testergebnisse, Risikoanalysen und sicherheitsrelevante Entscheidungen über den Produktlebenszyklus führen. Praktisch heisst das: CI/CD- und Testergebnisse der Releases verfügbar halten und ein aussagekräftiges Changelog pflegen. Weiter verlangt der CRA Transparenz über Drittkomponenten - inklusive Open-Source-Bibliotheken. Das heisst: Eine Software Bill of Materials (SBOM) pflegen, die alle Komponenten, Versionen und bekannte Schwachstellen aufführt. Moderne Tools können SBOMs weitgehend automatisiert im Build-Prozess erzeugen.

Die Compliance-Dokumentation ist das letzte Puzzleteil für CRA-Bereitschaft. Während Security-by-Design und Vulnerability Management die operativen Aspekte darstellen, liefert Dokumentation den Nachweis der Umsetzung. Wie startet man also?

## Einstieg in den Cyber Resilience Act

Die Vorbereitung auf den CRA mag anfangs überwältigend wirken - ein schrittweiser Ansatz macht sie aber greifbar. Inkrementelle Umsetzung ist meist der beste Weg, um auditfähige Fähigkeiten aufzubauen und Produkte zertifizierbar zu machen.

Beginnen Sie mit einem groben Gap-Assessment: Wo stehen Ihre aktuellen Praktiken relativ zu den CRA-Anforderungen? Implementieren Sie dann einen „CRA-Light“-Prozess, der kritische Elemente abdeckt, ohne Teams zu überlasten. Starten Sie beim „Wer“ für Vulnerability Management und Incident Response. Führen Sie ein hochrangiges STRIDE-Threat-Modeling für Ihre Hauptprodukte durch, um grösste Risiken zu finden. Automatisieren Sie die SBOM-Erzeugung im Build und beginnen Sie frühzeitig mit dem Sammeln von Compliance-Nachweisen.

Auch wenn dieser Ansatz zunächst nicht alles vollständig abdeckt, schafft er eine belastbare Basis. Inkrementelle Umsetzung erlaubt Anpassung und Reifung ohne Überforderung durch die gesamte Regulierung. Und denken Sie daran: Ein Audit direkt vollständig zu bestehen ist schön, aber oft nicht realistisch – bauen Sie Prozesse, die kontinuierliche Verbesserung ermöglichen.

Am Ende geht es beim CRA nicht nur um Compliance, sondern um die Stärkung Ihrer gesamten Sicherheitslage und den Schutz der Nutzer vor Cyberbedrohungen. Wer proaktiv Anforderungen erfüllt, sichert nicht nur den EU-Marktzugang, sondern trägt zu einem sichereren digitalen Ökosystem bei.
