---
layout: post
title: Testing strategies for software that interacts with hardware
description: Whenever software that interacts closely with hardware is developed, testing becomes more complicated. This article discusses some strategies to make testing easier and more effective.
thumbnail: images/cmake-logo.png
---

**"Testing our software is difficult, because of the hardware involved."** This is a common problem that I hear from many people that are involved with developing software that runs on specific hardware. Be it low-level firmware running on a specific chip or software running on a specifically designed embedded environment. Testing software that interacts closely with hardware indeed complicates the testing setup and in turn, often means that additional cost and effort are required. In this article, I will discuss some strategies that can help you to make testing easier and more effective.

The obvious goal of testing is to ensure that the software works as expected and to catch regression bugs as early as possible. With hardware involved often catching regression becomes quite important as the specific environment that the software is running on might evolve and introduce new bugs. However "just run your code on the hardware" might not always work. The hardware might be too expensive to have available just like that or it might be too complicated to set up. One thing a good testing strategy included is quick and timely feedback to the developers. Good testing strategies leverage the balance of fast feedback and thorough testing. Essentially developers want to have fast and reliable feedback if their code breaks something. 

{% include cmake-best-practices-ad.html %}

## Building a testing strategy on the test pyramid with hardware

The underlying principle of good testing strategies when hardware is to try to involve the real hardware as late as possible while still trying to include it as much as possible. This means that in your day-to-day work you want to be able test as much as possible on the development machine without the actual hardware and only use the real hardware in the CI unless you're working on something that is very closely tied to the hardware. This will most means that you should structure your code so that the hardware-specific code is isolated and can be mocked away and that the code can be cross-compiled to run on the development machine and the actual hardware as well. The further up you move on the testing pyramid the closer you get to the real hardware and the more expensive and time-consuming the tests become. 

{% include figure.html url="images/testing-with-hardware/TestingPyramid.png" description="The testing pyramid if hardware is involved" %}

I advise running all automatic tests on every commit to the main branch of your repo or even on every commit if the time frame allows that. This means that you should have a CI setup that runs the tests on every commit. I generally prefer a set up which runs all unit tests and some of the fast integration tests on every pushed commit and runs all tests except the manual ones on every commit to the main branch. This way you get fast feedback on the state of your code and you can catch regressions early. While writing code I usually only run the unit tests concerning the code I'm currently touching.

An important thing is that even if the test pyramid shows emulators, simulators etc. That the setup should be so the most of the tests can be run on the actual hardware itself as well and this should also be done regularly to catch hardware-induced regressions. The same applies for the development machines, all emulator- or simulator-based tests should be runnable on the dev's machine for easy debugging and the devs should have easy access to the hardware for debugging. Let's look at the different levels of the testing pyramid in more detail.

### The foundation: Cross-Compiling and Unit tests

At the very bottom of the test, pyramid sit the smallest but most numerous unit tests. These are intended to be run frequently. When doing test driven development (which you should) these are the workhorses regarding software quality. And because the developers need to be able to run them frequently at the very base of the pyramid is also the ability to cross-compile your code so it can be tested on the developer's machine and the target hardware. There will be parts that are hard to test without the actual hardware, but usually, the majority of the code can be tested very well by mocking the hardware away. 

// Add image highlighting the part of the pyramid

## The middle: Emulators and component tests

The boundary between unit- and component tests is often fluid. Component tests are usually a bit more complex than unit tests and they test a larger part of the system but are still pretty localised regarding the code. They are usually still fast enough to run on the developer's machine and they can be run on the CI as well. The main difference between unit- and component tests is that component tests are more likely to require some system awareness. Emulators are a great way to enable low-cost automation and bring some of the behavior of the hardware into play. Emulators mimick the hardware on a low level but often without the full setup of all running services etc. One downside of the emulators is that they cannot give any indication about runtime performance of the hardware, for this only the real hardware can be used.





* Have it in CI - run the tests on every commit
* Cross compile - run it on dev machine and target machine
* emulators
* simulators
* Hardware in the loop
* Manual testing
* Deployment has to be easy and tested as well

Graph that shows when to run which test
* commit to arbitrary branch - SW only
* commit to main line of development - include HIL
* for release - include HW on all tests


