---
layout: post
title: Frequent, vertical integration for the win
thumbnail: images/vertical_integration/thumbnail.jpg
---

**"The software is almost done, we *just* need to integrate it on the device."** Is one of the biggest self-deceptions that I hear from teams developing embedded software. What often follows are failed deadlines and weeks and months of everybody working under immense pressure to finally ship that device. Taking shortcuts and hacks to get everything together is often the consequence of this and in the end what could have been an awesome product often severely lacks quality. To avoid this trap, early and frequent vertical integration is a huge game changer and a step towards better products and agility.

Interesting enough, the people involved are often very well aware that integration is the part with the most pitfalls and fiddling involved when creating an embedded product. Nevertheless, lots of companies still develop various parts of an embedded device - OS, hardware, and applications - side by side and only integrate once everything is "done". I have yet to see that working out as intended and inside schedule. 

If you want to go fast and produce high quality when developing software, early and frequent integration is a must. If developers are unable to see how their code performs in a real-life (or at least close to real life) situation they have to make assumptions and assumptions are the root of lots of software bugs and undefined behavior. Integrating the whole product as far as possible very frequently often shows weaknesses in the system that would not be detected otherwise. 

Another benefit is that by integrating every commit is that the team practices deployment frequently. Since one doesn't want to spend days and weeks every time the software is deployed to a target system there often follows some effort to automate deployment and make it a non-issue. Increased system stability is the great reward that follows quickly. 
Failure to deploy? No problem, the automatic rollback has you covered. Bad system performance and a hiccuping service after an update? No worries - The self diagnosis notifies you soon enough.

A very prominent example of frequent and early integration is of course spaceX's rockets. Remember all those [crashing rockets on youtube](https://www.youtube.com/watch?v=bvim4rsNHkQ)? That is vertical integration on a massive scale. I'm very sure that all parts of the early falcon 9 were performing admirably in the lab environment and under testing conditions. But still every time the full rocket was assembled a new unexpected glitch came up. Blowing up a rocket every time is of course extreme and needs funding that not every company has available, but one can get pretty far without big explosions at the end. 

## integrate, deploy and monitor

If vertical integration is one side of the coin, measuring and monitoring is the other side. Every time a system is deployed during development get a series of meaningful tests running and deliver the result back to everyone involved. Whenever there is a lull in activity - such as over the weekends - go the extra mile and run some more demanding tests on the latest deployed version. Nothing gets a developer awake faster on a foggy Monday morning than a failed integration test.

There is no denying that the initial cost of setting up an environment for vertical integration. This begins with the amount of hardware and test-systems that need to be available and goes over to the time invested in building a test environment, monitoring, and infrastructure for easy deployment.
Preferably have one set of hardware for every developer, so they can test independently from the rest of the team and nobody has to wait for the testing system to be available. Of course, this might not be possible if the machine big or expensive enough, but try to have as many testing systems as possible at the developer's hands. Finding a critical bug late in the development is often much more expensive than buying and building additional hardware.

{% include figure.html url="images/vertical_integration/AgileCostChangeCurve_english.jpg" description="The cost fost of finding a defect at various times in the development process" %}

## Get live updates for free

Nowadays more and more software gets frequently updated, even if already in a productive environment. "Over the air updates" are often among the first benefits mentioned when asked if a device should be operated offline or connected to the internet. In the field  updates are kind of risky, because a failed  update might brick a device. Testing this deployment not just once or twice, but every time the code changes increases the chance of catching possible hiccups in a non-critical environment. Considering the cost of whole factories standing still for days because of a failed update puts the additional cost and effort of continuous vertical integration nicely into perspective.

## Engineers assemble!

Frequent vertical integration is often a great way to unlock the emerging intelligence of a group of interdisciplinary engineers. Building an (automated) system for easy integration and deployment often requires people from all aspects of the device to work together and this close collaboration is a good way of uncovering hidden assumptions early on.
And last but not least as a developer, knowing that every line of code is automatically tested is a very comforting tought that helps to lessen the mental strain of coding significantly. 

All in all frequent vertical integration might be cost intensive but it yields massive benefits. It is a classical gamble of sacrificing short time gains in favor of going fast over a long time. But as embedded devices tend to be maintained and improved for years and decades, so usually the investment pays off pretty well. 