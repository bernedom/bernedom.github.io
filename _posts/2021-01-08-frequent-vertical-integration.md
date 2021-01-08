---
layout: post
title: Frequent vertical integration for the win
description: How early and frequent vertical integration will increase the quality of embedded products and help projects running on schedule
thumbnail: images/vertical_integration/thumbnail.jpg
---

**"The software is almost done, we *just* need to integrate it on the device."** Is one of the biggest self-deceptions in embedded software development. What often follows are failed deadlines and weeks or months of everybody taking shortcuts and hacks to finally ship that device. And often enough, what could have been an awesome product severely lacks quality in the end. Early and frequent vertical integration is THE way out of this deadlock and often a huge game-changer towards better products and agility.

The people involved in embedded software development are often very well aware that integration is often the tricky part of product development. Nevertheless, lots of companies still develop various parts of an embedded device - OS, hardware, and applications - side by side with only occasional handovers and only integrate once everything is "done". While this might work, I have yet to see this approach succeed on schedule and without a painful reduction in product quality. 

## Integrate early, integrate often

Early and frequent integration is a must for high-quality products and keeping a schedule. If developers are unable to see how their code performs in a real-life (or at least close to real-life) situation, they have to make assumptions - and assumptions are the root of lots of software bugs and undefined behavior. Integrating the whole product as far as possible very frequently often shows weaknesses in the system that would not be detected otherwise. 

Another benefit is that by integrating every commit to the hardware is that the team practices deployment frequently. Since one doesn't want to spend days and weeks every time the software is deployed to a target system there often follows a good effort to automate deployment and make it a non-issue in the development process. The great reward of it is increased system stability in production. 

> Frequent vertical integration is a great way to unlock the emerging intelligence of a group of interdisciplinary engineers

A very prominent example of frequent and early integration are spaceX's rockets. Remember all those [crashing rockets on youtube](https://www.youtube.com/watch?v=bvim4rsNHkQ)? That is vertical integration on a massive scale. I'm very sure that all parts of the early [falcon 9](https://www.spacex.com/vehicles/falcon-9/) were performing admirably in the lab environment and under testing conditions. But still the first few times the full rocket was assembled and launched a new unexpected glitch came up. Blowing up a rocket every time is of course extreme and needs funding that not every company has available, but one can get pretty far without big explosions at the end. 

Frequent vertical integration is a great way to unlock the emerging intelligence of a group of interdisciplinary engineers. Building an (automated) system for easy integration and deployment will require people from all aspects of the device to work together and close collaboration is a good way of uncovering hidden assumptions. 

## integrate, deploy and monitor

If vertical integration is one side of the coin, then measuring and monitoring is the other side. Every time a system is deployed during development get a series of meaningful tests running and deliver the result back to everyone involved. Whenever there is a lull in activity - such as over the weekends - go the extra mile and run some more demanding tests on the latest deployed version. Nothing gets a developer awake faster on a foggy Monday morning than a failed integration test.

There is no denying that the initial cost of setting up an environment for vertical integration. There is the amount of hardware and test-systems needed to be considered. Then there is the time invested in building an environment for testing, and monitoring the products and ends with the running costs of the infrastructure for easy deployment. But often enough these costs get amortized later easily, because the time to reproduce bugs and create patches is often much reduced and the infrastructure can be used to deliver software in production as well. 

At least one set of hardware for every developer would be optimal, to enable testing independently from the rest of the team and to reduce waiting time for the testing resources. Of course, this might not be possible if the machine big or expensive enough, considering the developer's wages saving a few hundred bucks on hardware during development seems a bit of a joke. Finding a critical bug late in the development is often much more expensive than buying or building additional hardware.

{% include figure.html url="images/vertical_integration/AgileCostChangeCurve_english.jpg" description="The cost of finding a defect rises exponentially in the development process" %}

## Get live updates for free

Nowadays more and more software gets frequently updated, even if already in a productive environment. "Over the air updates" are often among the first benefits mentioned when asked if a device should be operated offline or connected to the internet. Over the air updates are a kind of risky business, because a failed update might brick a device and severely disrupt a business operation or even endanger people. Testing deployment not just once or twice, but every time the code changes, increases the chance of catching possible hiccups in a non-critical environment. Considering the cost of whole factories standing still for days because of a failed update puts the additional cost and effort of continuous vertical integration nicely into perspective.

## Engineers assemble!

Early and frequent vertical integration might have a high upfront cost, but it yields massive benefits. It is a classical gamble of sacrificing short time gains in favor of going fast over a long time. Considered that embedded devices tend to be maintained and improved for years and decades, the investment usually pays off pretty well. 