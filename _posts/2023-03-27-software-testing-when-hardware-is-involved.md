---
layout: post
title: Testing strategies for software that interacts with hardware
description: Whenever software that interacts closely with hardware is developed, testing becomes more complicated. This article discusses some strategies to make testing easier and more effective.
thumbnail: images/cmake-logo.png
---

**"Testing our software is difficult, because of the hardware involved."** This is a common problem that I hear from many people that are involved with developing software that runs on specific hardware. Be it low-level firmware running on a specific chip or software running on a specifically designed embedded environment. Testing software that interacts closely with hardware indeed complicates the testing setup and in turn, often means that additional cost and effort is required. In this article, I will discuss some strategies that can help you to make testing easier and more effective.

The obvious goal of testing is to ensure that the software works as expected and to catch regression bugs as early as possible. With hardware involved often catching regression becomes quite important as the specific environment that the software is running on might evolve and introduce new bugs. However "just run your code on the hardware" might not always work. The hardware might be too expensive to have available just like that or it might be too complicated to setup. One thing a good testing strategy included is quick and timely feedback to the developers. Good testing strategies leverage the balance of fast feedback and thorough testing. Essentially developers want to have fast and reliable feedback if their code breaks something. 



## Testing strategies

{% include cmake-best-practices-ad.html %}

* Have it in CI - run the tests on every commit
* Cross compile - run it on dev machine and target machine
* emulators
* simulators
* Hardware in the loop
* Manual testing
* Deployment has to be easy and tested as well




