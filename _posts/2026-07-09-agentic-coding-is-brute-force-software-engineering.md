--- 
layout: post
title: "Agentic Coding is Brute-Force Software Engineering"
description: ""
image: /images/agentic-coding-brute-force/thumbnail.jpg
hero_image: /images/agentic-coding-brute-force/hero.jpg
hero_darken: true
tags: agile software-delivery
lang: en
author: Dominik Berner
---

**Writing code faster is not the same as delivering better software.**  There is an inconvenient truth about agentic and AI-assisted coding: it is brute-force software engineering. It can help you write code faster, but it does not help you deliver better software faster. Working with AI-assisted coding is a productivity boost. Features get implemented in mere hours instead of days and weeks, each iteration on the software becomes cheaper and faster. This sounds like the holy grail of software development, but is it?

== Good software design is a survival trait ==

Before the massive adoption of AI-assisted coding, producing running software was expensive and time-consuming. Not just in money, but also in focus, time and cognitive energy. This scarcity of resources forced software engineers to think about the design of their software. A badly written system meant weeks of lost work and frustration. A wrongly choosen data structure could jeopardize the performance of an entire system and a rewrite of it could take months. 

This is why practices such as domain driven design, test-driven development, and code reviews were invented and popularized. They were not academic exercises, but survival traits. They helped software engineers to make better decisions and avoid costly mistakes. If implementing is expensive, you **have to** think before you implement. The constraint-system of software engineering forced engineers to deliver quality software.

An architect thinking several days about the way data is modeled and about interactions between components doesn't do this because of nostalgia. She does it because mistakes here could cost weeks or months of work in the future. This economic pressure is what formed modern software craft. 

== What AI-Agents really change ==

The adoption of AI-assisted coding changes this economic pressure. It relieves the economic pressure of implementation. An AI-Agents doesn't iterate two or three times on a feature, it iterates twenty or thirty times. It can implement a feature in a few hours instead of days. This is technically impressive. But it is a brute-force approach to the problem. Instead of reducing the problem scope through careful design, the solution space is explored through sheer computational power.

The principle is not new. Brute-Force approaches are a legitmiate strategy, as long as the problem space is small enough. But software design does not have a small - or even bounded - problem space. The combination of requirements, architecturs, use cases and systematic constraints are exponential. An so is the needed power to cover this with a brute-force approach. 

== Trading thinking time for production time ==

Here lies the inherent risk of the AI-assisted coding approach: it prevents reflection. The moment developers implemented a feature was not just "production time", it was also "thinking time". While designing a piece of software, developers automatically reflect on wheter this is really needed, if it is the right approach, and if it is the right time to implement it. Which edge-cases are relevant? Which trade-offs are acceptable? Which requirements are really needed and what happens if they change? 

Agentic coding tends to jump over this reflection. With agentic coding humans are front-feeding the requirements to the AI-Agent, and the AI-Agent is producing code. The code is written and in production before the reflection process even kicks in. And why not - if it proves to be a wrong decision, the AI-Agent can just iterate again and produce a new version. 

The problem here is that the most expensive part of developing and running software are often not bugs, but incorrect requirements, dead code that needs maintenance and accidential complexity in products. The cost of a wrong decision is not the cost of fixing a bug, but the cost of maintaining a wrong decision for years. And this is where agentic coding fails: it does not help to make better decisions, it only helps to implement them faster. **Implementing a feature, that nobody needs in lightning fast time is not efficiency it is fully automated waste of resources.**

== Other symptoms to watch out for ==

We all cheer the speed of agentic coding, but we should also watch out for the symptoms of a growing problem. There are several other symptoms that indicate that that we are heading for a smelly place in software engineering. 

Teams are losing collective understanding of the system they are trying to build and systems are losing their architectural cohesion. For a long time system understanding was gained by building the system itself. The act of implementing, testing and refactoring a system was the way to gain understanding of it. If the implementation becomes a thing of casualness they become black boxes within the own product. The team is degraded to archivists of code they no longer undestand. 

With this brute force approach where AI-Agents optimize for local goals, the overall system architecture is at risk and software becomes bloated. As a result operating costs will rise and the system will become more fragile. The cost of maintaining a system is not just the cost of fixing bugs, but also the cost of understanding it. If the system becomes too complex to understand, it becomes too expensive to maintain.

Technical debts rise faster and so does the interest paid into it through refactoring. Even with assisted refactorings if they are large enough they carry risks in destabilizing a running system. Watching out for code churn and the growth of the code base is a good indicator for the health of a software project.

The solution proposal from the AI-side is simple, just wrap the whole process into another AI-Agent that is responsible for the overall system architecture. But "just add another layer of abstraction" is a long known anti-pattern in software engineering. It is again a brute-force approach to a problem that is not bounded.

== Conclusion ==

So what is the solution? Should we stop using AI-assisted coding? No, it is a productivity boost and it can help to implement features faster. But it does not eliminate the need for good design, reflection and above all it does not invalidate many of the practices around good software craft. 

The answer is not more AI, but **more discipline in software engineering**. The practices that were adopted because implementation was expensive are still valid, even if implementation becomes cheap. The need for good design, reflection and discipline in software engineering is not going away. It is just that the economic pressure that forced us to adopt these practices has shifted. We need to find new ways to enforce these practices, even if implementation becomes cheap or else we will end up in a world of bloated, fragile and unmaintainable software. 

The term "software craft" has two dimensions: The craft of producing running software and the intellectual judgment on what to produce in the first place. The first dimension is what AI-assisted coding is good at, the second dimension is what it is bad at. The question wether a system is still suited to its purpose in a few years from now is not a question of implementation speed and will remain a question of human judgment in many cases. If you think agentic coding is a silver bullet for software engineering, you are mistaking speed for direction and you might be in for a rude awakening.