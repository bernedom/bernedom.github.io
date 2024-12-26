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

The *controllable cost of change* on the other hand is driven by the amount of defects reported, the amount of feature requests and changes, changes in personnel (knowledge shift), volatility of the user base and evolving user needs. While these factors that are often difficult to predict and plan, a development team can usually exert some control over these factors through deciding when, how or if to implement a change or by accepting certain limitations in functionality or stability instead of fixing a defect. The other way to exert control over the cost of change is by by rigorously applying good software development practices and principles.

Looking at the typical software development process, any change made on an existing codebase usually involves the following steps:

1. identifying the requirements of the change
1. looking for the parts of the code that need to be changed
1. changing the code and implementing the change
1. testing and validating the changes
1. deploying the changes to the production environment

Each of these steps can be a source of cost and each of them can be optimized to reduce the cost of change. An important factor here is also, that not just the amount of time spent actually doing these steps is a cost driving factor, but also the speed at which these steps can be done. The faster a change can be implemented, tested and deployed the faster the feedback loop can be closed and the faster value is generated. Nothing costs more than a change that is lying around for weeks or months before it is deployed and validated.

## How to reduce the cost of change in your code?

One of the most frequent shortcomings regarding high cost of change that I see is not investing the fixed cost of change frequently. *Keeping your software reasonably up to date and doing so in frequent, but small increments is one of the major investments into keeping the cost of change small*. A frequent mistake of software teams is not keeping the software stack current and up to date, especially once the speed of feature development slows down and once the software is considered mature. The effect is then that even if a small change is needed, the cost of change is high, because the first thing a developer has to do is to update the software stack to a version that is still supported and maintained. While this is not only a time consuming factor, it is often a high risk to introduce hidden regression bugs into the software, leading to a much higher validation and testing cost than what would be needed just to test the new feature.

> Keeping your software stack up to date is not glamorous work, but it is one of the most important investments into keeping the cost of change low.

When it comes to the controllable cost of change, there are a number of strategies that can be applied to reduce the cost of change in your code. Of the steps identifying the requirements, looking for the parts of the code that need to be changed, changing the code, testing the changes, validating the changes and deploying the changes all have potential for optimization. Here are some strategies that can be applied to reduce the cost of change in your code:

### Identify requirements - Say "No" to a change

Let's start at the very beginning at *identifying requirements*. The biggest cost saver here is saying "No" to a change. One of the twelve principles of the agile manifesto is "Simplicity--the art of maximizing the amount of work not done--is essential." The equation is simple, the less features and code there is in a product, the less there is to maintain. To do so a clear discussion about the value of the change is necessary,  Ask "do we (or one of our stakeholders) benefit if we do this?" if the answer is not a clear "yes", then don't do it. A frequent mistake here is that teams at this point are not talking about the value, but about the predicted cost only. A typical pattern I observe is that developers are asked to estimate the change and if they give a low enough number, the change is applied. 

> A common mistake when deciding whether to fix a defect or add a feature is to talk about cost only instead of value first.

Another frequent omission at that stage is to not talk about what to remove from the product and talk about deprecation. If a product is running over decades, it is natural that some features at one point will become obsolete or too cumbersome to use and maintain. Having a clear strategy on how to remove or replace features from a product is as important as adding new ones. That usually involves a clear communication strategy to the users and stakeholders, a clear way to mark features as being phased out and a clear plan on how to remove the feature from the codebase. Handling deprecation well can save a lot of cost in the long run. Removing bad or dead code reduces the noise developers have to dig through when looking for the parts of the code that need to be changed.

### Finding the parts of the code that need to be changed

Once the decision is made to implement a change, the next step is to find the parts of the code that need to be changed. This is where good software design and architecture comes into play. The more modularized and decoupled your code is, the easier it is to find the parts of the code that need to be changed. There is a high chance that after a few years of development, the people maintaining the code are no longer the same people who wrote the code. And even if they are, there is a high chance that a lot of detail just got forgotten. If the code is well structured and modularized, it is much easier for new developers to find their way around the codebase and to understand what needs to be changed. Build your software around a consistent architecture and design patterns, so it is easier to find the parts of the code that need to be changed. This can start a he smallest level for instance on how you use functions, are you using non-const output-parameters in functions or are you strictly using structs as return values? Do you use exceptions or error codes to signal errors? You may like or not like some of these patterns, but whatever you choose, be consistent.  
On a higher level, are you using a consistent architecture pattern like MVC, MVVM, Clean Architecture or Hexagonal Architecture? Are you using a consistent way to structure your codebase, like for instance grouping code by feature or by layer? Again consistency is more important than the actual choice of the pattern, although choosing the completely wrong architecture can be a major cost driver. However, here the cost of change can also by reducing by going for low coupling, high cohesion and high modularity.

Stick to your chosen design within a module, but decouple modules as much as possible. If your code is tightly coupled, you will have to change many other parts of the code when you change one part. This is a major cost driver in software development. The more code changed, the more likely you are to introduce bugs and the higher the testing effort will be. This of course has a backwards effect on the decision whether to implement the changed requirement or not. If you are sure that the change will be localized and not affect other parts of the code, it's way easier to say "yes" to a change.
Once you found the code, the fun part starts - changing the code and implementing the change. 

### Implementing the change

When implementing a change having invested in good software practices up front pays off a lot. But even if you have not, then start with that change. It might as well be that when the original code was written there were no proper unit tests around, TDD was not practiced and no code reviews were done. So what? Start doing that now! One of the most important things you can do at that stage is to further reduce the cost of change. I tend to say that every implementation should start with a refactoring first. Maybe the code is not following the current coding standard, has the wrong level of abstraction or is not using any of the patterns you have chosen for that particular module. Refactor the code first, so it is easier to understand and change. 

> Every implementation should strive to further reduce the cost of change (or at least not increase it significantly).

There is of course a trade-off on how much can be done, at one point we might have to accept that some parts of the code are just too costly to repair and that we hit a flat spot on how much we can reduce the cost of change. The trade off here is usually whether to sacrifice internal coherence of a module but improving decoupling and isolation of "bad code" more. On a whim I usually try to isolate first rather than to keep coherence, but that is a personal preference and depends on a lot of factors. 

A very good practice to make sure the cost of change stays manageable when implementing new features is to use a TDD approach and relentlessly apply the full cycle, which includes refactoring of the original code. To skip the last step in the TDD cycle is a direct invitation to increase the cost of change. The other benefit of a TDD approach is that test coverage of new code stays high. Which helps with verifying that the change is correct and that no regression bugs are introduced.

### Testing and validating the changes

When thinking about the cost of a new feature, the testing and validation cost is often forgotten or underestimated. This often goes back to the segmentation of the system and how localized the change is. The splash radius of a change is often a very good indicator on how high the testing and validation cost will be. If the change is localized, the testing effort is usually low, the wider the effects the more expensive testing goes. For instance optimizing the performance of a single algorithm is usually a very localized change and testing through an benchmark of before/after can be sufficient. Optimizing or changing a full workflow in the business logic could have a much wider effect and require a lot more testing, often involving manual testing - which is expensive.

While the verification of a feature - aka it works as defined - can often be automated, the validation - aka it works as expected - is often a manual process. The more manual the validation process is, the higher the cost of change. It often pays off to think of what kind of validation is needed for a feature before actually implementing it. Sometimes validation of a change can only be done by the end user, so an easy way for (selectively) deploying changes to a subset of users can be a good strategy to reduce the cost of change.

### Deploying the changes

So the change is now implemented and tested! Very good, now let's ask the developers to roll it out to the production environment. This is where the cost of change can skyrocket. If the deployment process is manual, error prone and time consuming, the cost of change is high even for the tiniest change. The deployment process is often a neglected part of the software development process, but it is a very important part of the cost of change. If deployment to production is hard and involves jumping through seven hoops to get it done, a common pattern is that multiple changes are bundled together to reduce the cost of deployment. The problem here arises that at one point the feedback loop gets a lot longer and that big releases have a much higher chance to introduce hidden regression. 

Also as long as a feature is not deployed it only generates cost, but no value. The most beautiful feature is worthless if no-one is using it. One of the major problems in software engineering is that it is often viewed as expensive and the cost factor is the main discussion point. While it might be true, that software development is not cheap, holding back the work done and not letting if generate value is even more expensive. 



Braindump:

Cost of change in software is driven by a number of factors. Some of the most common factors include:

* **Poor readability**: Code that is difficult to read and understand is difficult to change. If you can't understand what the code is doing, you can't change it without introducing bugs.
* **Poor test coverage and very coarse tests**: Code that is not well tested is difficult to change. Without tests, you can't be sure that your changes haven't introduced new bugs.
* **High coupling**: Code that is tightly coupled is difficult to change. When you change one part of the code, you have to change many other parts as well.
* **High complexity**: Code that is overly complex is difficult to change. The more complex the code, the more likely you are to introduce bugs when you change it.
* **Lack of visible intent**: Code that doesn't clearly express its intent is difficult to change. If you can't tell what the code is supposed to do, you can't be sure that your changes are correct.



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