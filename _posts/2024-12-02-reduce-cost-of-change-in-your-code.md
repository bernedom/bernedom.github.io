---
layout: post
title:  "Optimize your code for reduced cost of change"
description: ""
thumbnail: images/cmake-conan-logo.png
---

**Software development is an expensive business.** Measured over the lifespan of a product, the cost of maintaining and changing the code over time greatly outweighs the initial cost spent to bring a first usable version of a product to the market. Successful software products nowadays often have lifespans measured in decades rather than years and often they are kept under more or less active development throughout the whole period. So while the initial project might be a success and the product might be well received by the market, the real challenge is to keep the product relevant and competitive over time. Changing technology, fixing defects, adaptation to customer needs or pressure from competition are common needs why software needs change. In the view of this it is paramount that when designing software and writing code you should optimize for reducing future cost of change first before anything else. In this post, we'll explore some strategies for optimizing your code to reduce the cost of change and improve the overall quality of your software.

## What drives cost of change in software?

When talking about the cost of change in software as part of the total cost of ownership (TCO) of software, we are talking about the cost of maintaining and changing the software over time. While the cost of operating a software for instance in the cloud can be a significant cost factor contributing to the TCO, another driving cost factor is the amount of time software developers spend changing the code, improving or adding features and fixing defects.

When running and maintain software there is always a base layer of effort needed, just to keep the software running and up to date. This is what I refer as the *fixed cost of change*. This cost is driven by external factors such as operating system updates, evolving programming languages and changing frameworks or changes in the underlying hardware. These are factors that are often outside of the control of the software developers an usually require some effort to adapt the software to these changes without bringing more visible features to the software. 

The *controllable cost of change* on the other hand is driven by the amount of defects reported, the amount of feature requests and changes, changes in personnel (knowledge shift), volatility of the user base and evolving user needs. While these factors that are often difficult to predict and plan, a development team can usually exert some control over these factors through deciding when, how or if to implement a change. Secondly by applying good software development practices and principles, these cost of change can be reduced significantly.

Looking at the typical software development process, any change usually involves the following steps: identifying the requirements, looking for the parts of the code that need to be changed, changing the code, testing the changes, validating the changes and deploying the changes. Each of these steps can be a source of cost and each of them can be optimized to reduce the cost of change. An important factor here is also, that not just the amount of time spent actually doing these steps is a cost driving factor, but also the speed at which these steps can be done. The faster a change can be implemented, tested and deployed the faster the feedback loop can be closed and the faster value is generated. Nothing costs more than a change that is lying around for weeks or months before it is deployed and validated.

## How to reduce the cost of change in your code?

One of the most frequent shortcomings regarding high cost of change that I see is not investing the fixed cost of change frequently. *Keeping your software reasonably up to date and doing so in frequent, but small increments is one of the major investments into keeping the cost of change small*. A frequent mistake of software teams is not keeping the software stack current and up to date, especially once the speed of feature development slows down and once the software is considered mature. The effect is then that even if a small change is needed, the cost of change is high, because the first thing a developer has to do is to update the software stack to a version that is still supported and maintained. While this is not only a time consuming factor, it is often a high risk to introduce hidden regression bugs into the software, leading to a much higher validation and testing cost than what would be needed just to test the new feature.

> Keeping your software stack up to date is not glamorous work, but it is one of the most important investments into keeping the cost of change low.

When it comes to the controllable cost of change, there are a number of strategies that can be applied to reduce the cost of change in your code. Of the steps identifying the requirements, looking for the parts of the code that need to be changed, changing the code, testing the changes, validating the changes and deploying the changes all have potential for optimization. Here are some strategies that can be applied to reduce the cost of change in your code:

### Identify requirements - Say "No" to a change

Let's start at the very beginning at *identifying requirements*. The biggest cost saver here is saying "No" to a change. One of the twelve principles of the agile manifesto is "Simplicity--the art of maximizing the amount of work not done--is essential." The equation is simple, the less features and code there is in a product, the less there is to maintain. To do so a clear discussion about the value of the change is necessary,  Ask "do we (or one of our stakeholders) benefit if we do this?" if the answer is not a clear "yes", then don't do it. A frequent mistake here is that teams at this point are not talking about the value, but about the predicted cost only. A typical pattern I observe is that developers are asked to estimate the change and if they give a low enough number, the change is applied. 

Another frequent omission at that stage is to not talk about what to remove from the product and talk about deprecation. If a product is running over decades, it is natural that some features at one point will become obsolete or too cumbersome to use and maintain. Having a clear strategy on how to remove features from a product is as important as adding new ones. That usually involves a clear communication strategy to the users and stakeholders, a clear way to mark features as being phased out and a clear plan on how to remove the feature from the codebase. Handling deprecation well can save a lot of cost in the long run.

### Finding the parts of the code that need to be changed








Cost of change in software is driven by a number of factors. Some of the most common factors include:

* **Poor readability**: Code that is difficult to read and understand is difficult to change. If you can't understand what the code is doing, you can't change it without introducing bugs.
* **Poor test coverage and very coarse tests**: Code that is not well tested is difficult to change. Without tests, you can't be sure that your changes haven't introduced new bugs.
* **High coupling**: Code that is tightly coupled is difficult to change. When you change one part of the code, you have to change many other parts as well.
* **High complexity**: Code that is overly complex is difficult to change. The more complex the code, the more likely you are to introduce bugs when you change it.
* **Lack of visible intent**: Code that doesn't clearly express its intent is difficult to change. If you can't tell what the code is supposed to do, you can't be sure that your changes are correct.



Braindump:

* Fixed cost drivers- Changing OS, changing language, changing framework, changing architecture... (external, technical factors)
    * Keep add it, keeping it in small increments, keep it up to date reduces future cost of change
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