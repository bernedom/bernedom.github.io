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

## Good software design is a survival trait 

Before the massive adoption of AI-assisted coding, producing running software was expensive and time-consuming, not just in money, but in focus, time and cognitive energy. This scarcity forced software engineers to think about the design of their software. A badly written system meant weeks of lost work and frustration. A wrongly chosen data structure could jeopardize the performance of an entire system and a rewrite of it could take months.

This is why practices such as domain driven design, test-driven development, and code reviews were invented and popularized. They were not academic exercises, but survival traits.

> If implementing is expensive, you have to think before you implement.

An architect spending days thinking about how data is modeled doesn't do this out of nostalgia. She does it because mistakes there could cost months of work later. This economic pressure is what formed modern software craft.

## What AI-Agents really change

The adoption of AI-assisted coding relieves this economic pressure. An AI-Agent doesn't iterate two or three times on a feature, it iterates twenty or thirty times, and can implement it in a few hours instead of days. This is technically impressive. But it is a brute-force approach to the problem. Instead of reducing the problem scope through careful design, the solution space is explored through sheer computational power.

The principle is not new. Brute-Force approaches are a legitimate strategy, as long as the problem space is small enough. But software design does not have a small - or even bounded - problem space. The combination of requirements, architectures, use cases and systematic constraints are exponential. And so is the needed power to cover this with a brute-force approach.

One could argue that reflection hasn't disappeared, it has just moved into the prompt: writing a good request requires thinking too. But specifying a request is not the same act as designing a system.

> The old reflection didn't come from developers being virtuous, it came from hitting resistance while building.

You'd start modeling a piece of data, run into an edge case mid-implementation, and that friction would force a redesign. Agentic coding absorbs that friction on the agent's side: the human never hits the wall that used to trigger the rethink, because the wall gets hit and silently worked around inside the AI's iteration loop. And design thinking has always depended on stepping away from the keyboard: sleeping on a decision, sketching it out, arguing about it with a colleague. The faster and tighter the prompt-to-code loop gets, the less room there is for that incubation. Prompting is optimized for continuous momentum, which is structurally opposed to the pause that produces the best design decisions.

{% include services-ad.html %}

## Trading thinking time for production time

That lost friction doesn't just remove a delay, it skips the specific questions it used to force: is this really needed? Is it the right approach, and is it the right time? Which edge-cases are relevant, which trade-offs are acceptable, and which requirements actually matter if they change? Agentic coding jumps straight over these questions. Humans front-feed requirements to the AI-Agent, and the AI-Agent produces code: the code is written and in production before the questions even get asked. And why not - if it proves to be a wrong decision, the AI-Agent can just iterate again and produce a new version. 

The problem here is that the most expensive part of developing and running software are often not bugs, but incorrect requirements, dead code that needs maintenance and accidental complexity in products.

> The cost of a wrong decision is not the cost of fixing a bug, but the cost of maintaining a wrong decision for years.

And this is where agentic coding fails: it does not help to make better decisions, it only helps to implement them faster. **Implementing a feature, that nobody needs in lightning fast time is not efficiency it is fully automated waste of resources.**

## Other symptoms to watch out for

We all cheer the speed of agentic coding, but we should also watch out for the symptoms of a growing problem. There are several other symptoms that indicate that we are heading for a smelly place in software engineering. 

Teams are losing collective understanding of the system they are trying to build and systems are losing their architectural cohesion. For a long time system understanding was gained by building the system itself. The act of implementing, testing and refactoring a system was the way to gain understanding of it. If implementation is treated as an afterthought, systems become black boxes within their own product. The team is degraded to archivists of code they no longer understand. 

With this brute force approach where AI-Agents optimize for local goals, the overall system architecture is at risk and software becomes bloated. As a result operating costs will rise and the system will become more fragile. The cost of maintaining a system is not just the cost of fixing bugs, but also the cost of understanding it.

> If the system becomes too complex to understand, it becomes too expensive to maintain.

Technical debts rise faster and so does the interest paid into it through refactoring. Even with assisted refactorings if they are large enough they carry risks in destabilizing a running system. Watching out for code churn and the growth of the code base is a good indicator for the health of a software project.

A common pitch from AI-tooling vendors is deceptively simple: just wrap the whole process into another AI-Agent that is responsible for the overall system architecture. But "just add another layer of abstraction" is a long known anti-pattern in software engineering. It is again a brute-force approach to a problem that is not bounded.

## Conclusion

So what is the solution? Should we stop using AI-assisted coding? No, it is a productivity boost and it can help to implement features faster. But it does not eliminate the need for good design, reflection and above all it does not invalidate many of the practices around good software craft. 

> The answer is not more AI, but more discipline in software engineering.

The practices that were adopted because implementation was expensive are still valid, even if implementation becomes cheap. The need for good design, reflection and discipline in software engineering is not going away. It is just that the economic pressure that forced us to adopt these practices has shifted. If implementation becomes cheap and we don't stop to think, we will end up in a world of bloated, fragile and unmaintainable software. 

The term "software craft" has two dimensions: The craft of producing running software and the intellectual judgment on what to produce in the first place. The first dimension is what AI-assisted coding is good at, the second dimension is what it is bad at. The question whether a system is still suited to its purpose in a few years from now is not a question of implementation speed and will remain a question of human judgment in many cases. If you think agentic coding is a silver bullet for software engineering, you are mistaking speed for direction and you might be in for a rude awakening.