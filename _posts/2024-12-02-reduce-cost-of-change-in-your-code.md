---
layout: post
title:  "Optimize your code for reduced cost of change"
description: ""
thumbnail: images/cmake-conan-logo.png
---

**Software development is an expensive business.** Measured over the lifespan of a product, the cost of maintaining and changing the code over time greatly outweights the initial cost spent to bring a first usable version of a product to the market. Successful software products nowadays often have lifespans measured in decades rather than years and often they are kept under more or less active devlopment throughout the whole period. So while the initial project might be a success and the product might be well received by the market, the real challenge is to keep the product relevant and competitive over time. Changing technology, fixing defects, adaptation to customer needs or pressure from competition are common needs why software needs change. In the view of this it is paramount that when designing software and writing code you should optimize for reducing future cost of change first before anything else. In this post, we'll explore some strategies for optimizing your code to reduce the cost of change and improve the overall quality of your software.

## What drives cost of change in software?

When talking about the cost of change in software or the total cost of ownership (TCO) of software, we are talking about the cost of maintaining and changing the software over time. While the cost of operating a software for instance in the cloud can be a significant cost factor, the biggest contributor to the TCO is the amount of time software developers spend maintaining and changing the code.

So what drives this cost? For every piece of software there is a standing base layer of cost that is needed to keep the software running. 

Cost of change in software is driven by a number of factors. Some of the most common factors include:

* **Poor readability**: Code that is difficult to read and understand is difficult to change. If you can't understand what the code is doing, you can't change it without introducing bugs.
* **Poor test coverage and very coarse tests**: Code that is not well tested is difficult to change. Without tests, you can't be sure that your changes haven't introduced new bugs.
* **High coupling**: Code that is tightly coupled is difficult to change. When you change one part of the code, you have to change many other parts as well.
* **High complexity**: Code that is overly complex is difficult to change. The more complex the code, the more likely you are to introduce bugs when you change it.
* **Lack of visible intent**: Code that doesn't clearly express its intent is difficult to change. If you can't tell what the code is supposed to do, you can't be sure that your changes are correct.



Braindump:

* Fixed cost drivers- Changing OS, changing language, changing framework, changing architecture... (external, technical factors)
* Variable cost drivers - Amount of defects reported, amount of feature requests and changes, change in personell (knowledge shift), volatilty of user base, evolving user needs
* Cost: Time identifying requirements, looking for parts to change, time changing code (amount of code & localisation), testing, validation, deployment cost 
* Changes frequently on a "as needed basis" - Hard to plan ahead
* Measure: Amount of features per time, amount of defects returned, cycle time from When a change is requested to when it is deployed

Measures:
* Modularize and decouple your code as much as possible
* Write clean, readable code, pair programming, code reviews
* Write tests, test driven development - Don't skip the refactoring step, small tests to zoom in on probles caused by refactorings fast
* Frequent deployments (keeps you informed on the state of CI/CD), CI/CD, deploy per feature (feature toggles)?
* Detect accidential changes (linters, static analysis, code coverage), minimize regression