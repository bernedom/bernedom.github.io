---
layout: post
title: Frequent, vertical integration for the win
thumbnail: images/design-by-contract/thumbnail.png
---

**"The software is almost done, we *just* need to integrate it on the device."** Is one of the biggest self-deceptions that I hear from teams developing embedded software. Early and frequent vertical integration is a huge step towards more agility and better products when developing software. That does not just go for embedded devices, but for almost all software. 

Funny enough, the people involved are often very well aware that integration is the part with the most pitfalls and fiddling involved when creating an embedded product. Nevertheless, lots of companies still develop various parts of an embedded device - OS, hardware, and applications - side by side and only integrate once everything is "done". 

If you want to go fast and produce high quality when developing software, early and frequent integration is a must. If developers are unable to see how their code performs in a real-life (or at least close to real life) situation they have to make assumptions and assumptions are the root of lots of software bugs and undefined behavior. 

I'm developing software running close to the hardware for a living and if I can get my way all commits to the main-line of development (often known as master) are integrated on the end device or a very close emulation. 

Integrating the whole product as far as possible very frequently often shows weaknesses in the system that would not be detected otherwise. 
Another benefit is that by integrating every commit is that the team practices deployment frequently. Since one doesn't want to spend days and weeks every time the software is deployed to a target system there often follows smoe effort to automate deployment and make it a non-issue. Increased system stability are often a great reward that follows on foot. Failure to deploy? No problem, the automatic rollback has you covered. Bad system performance and a hiccuping service after an update? No worries - The self diagnosis notifies you soon enough.

A very prominent example of frequent and early integration is of course spaceXs falcon 9. Remember all those crashing rockets on youtube? That is vertical integration on a massive scale. I'm very sure that all parts of the ealry falcon 9 were performing admirably in the lab environment and under testing conditions. But still every time the full rocket was assembled a new unexpected glitch came up. Blowing up a rocket every time is of course extreme and needs funding that not every company has available, but one can get pretty far without big explosions at the end. 

Vertical integration is one part, but measuring and monitoring is the other. Every time the system is deployed during development get a series of meaningful tests running and deliver the result back to everyone involved. Whenever there is a lull in activity such as over the weekends go an extra mile and run some more tests on the latest deployed version. Nothing gets a developer awake faster in the morning than a failed integration test :) 

But isn't this expensive? There is no denying that setting up the possibility for vertical integration can be quite a cost factor. This begins with the amount of hardware and test-systems that need to be available and goes over to the time invested in building a test environment, monitoring and infrastructure for easy deployment.
Preferably have one set of hardware for every developer so they can test whatever they are working on as isolated from the rest as possible. Of course this might not be possible if the machine is big enough, but try to get as many testing systems as possible to the developers hands. Oftentimes failure to deploy correctly or finding a critical bug late in the development is much more expensive than running the tests. 

Nowadays more and more software gets frequently updated even if already in a productive environment. It is no surprise that over the air updates are often among the first benefits mentionend when asked of a device should be operated offline or online. These updates are often risky, because a failure to update might brick a device that is in use, which is the worst case scenario. Testing this deployment not just once or twice but every time the code changes is almost a no-brainer if one considers the cost of whole factories standing still for days because of a software bug.

Decoupling deployment from release increases the test coverage on a system level massivly. Deploy often release when necessary once the full system was put under extra close scrutiny or once the staging area has performed well enough for some time. 

Frequent vertical integration is the enabler to unlock the full power of a team of talented engineers. It also often the gateway to unlock the emerging intelligence of a group of interdisciplinary engineers. So the additional costs of getting something running is often well worth it. And last but not least as a developer, knowing that every line of code is automatically tested is a very comforting tought and helps to lessen the mental strain of coding significantly. 
Happy integrating!



Make deployment a non-issue for frequent vertical integration
* Frequent vertical integration increases quality and speed for delivery
* Make deployment a non-issue 
  * deploy in developemt as if it is the real thing
* decouple release from deployment
* Run tests as feasible, go the extra mile, take the weekends for long-running tests