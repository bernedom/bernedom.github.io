---
layout: post
title:  "Optimize your code for reduced cost of change"
description: "Software products might live for a long time, after the initial cost the cost of change is the major cost driver. Optimize your code for reduced cost of change is paramount."
thumbnail: images/cost-of-change/thumbnail-cost-of-change.jpg
---

**Software development is an expensive business.** Measured over the lifespan of a product, the cost of maintaining and changing the code over time often greatly outweighs the initial development cost. Successful software products nowadays often have lifespans measured in decades rather than years and often they are kept under active development throughout the whole period. Evolving technology, fixing defects, adaptation to customer needs or pressure from competition are common needs why software needs change. In the view of this, it is paramount that *when designing software and writing code you should optimize for reducing future cost of change first before anything else*.

## What drives cost of change in software?

When talking about the the cost of software products, companies often talk about total cost of ownership (TCO), which means simple terms means, "How much does it cost to keep the software running and up to date". While the cost of operating a software can be a significant cost factor contributing to the TCO, often the far larger cost factor is the amount of time software developers spend changing the code, improving or adding features and fixing defects.

> Changing and adapting software can be the major cost driver in software development, even before operational costs.

When maintaining software over time, there is always a base layer of effort needed, just to keep the software running and up to date. These are things like changes in underlying hardware, operating systems, evolution of libraries etc. This is what I refer as the *fixed cost of change*. This kind of housekeeping is an important investment into keeping the cost of change low, but it is often hard to predict when this needs to be done. However usually the far larger share of the cost is the *controllable cost of change*. This is driven by the amount of the amount of feature requests, defects reported, volatility of the user base and evolving user needs. These changes can often be planned based on observing the running system and feedback received. Thus, a development team can usually exert some control over these factors through deciding when, how or if to implement a change or by accepting certain limitations in functionality or stability instead of fixing a defect. 

Looking at the typical software development process, any change made on an existing codebase usually involves the following steps:

1. **Identifying the requirements of the change** - Slicing requirements into small, incremental changes helps to decide wether the change is worth implementing or not
1. **Looking for the parts of the code that need to be changed** - A modularized, consistently designed code base make finding the parts that need to be changed easier and reduce impact of the change
1. **Changing the code and implementing the change** - good software craft and clean implementation reduces testing effort
1. **Testing and validating the changes** - Good test coverage reduces risk for regression
1. **Deploying the changes to the production environment** - Frequent and easy deployment enable fast feedback and new requirements

{% include figure.html url="images/cost-of-change/cost-of-change-cycle.png" description="The circle of managing cost of change in software."%}

Each of these steps can be a source of cost and each of them can be optimized to reduce the cost of change, which usually impacts the next step again. Generally, the faster a change can be implemented, tested and deployed the faster the loop can be closed and the faster value is generated - This includes also the waiting time between the steps. Nothing costs more than a finished change that is lying around for weeks or months before it is deployed and validated.

## Controlling the fixed cost of change

One of the most frequent shortcomings regarding high cost of change that I see is not investing the fixed cost of change frequently. *Keeping your software reasonably up to date and doing so in frequent, but small increments is one of the major investments into keeping the cost of change small*. A frequent mistake of software teams is not keeping the software stack current and up to date, especially once the speed of feature development slows down and once the software is considered mature. The effect is then that even if a small change is needed, the cost of change is high, because the first thing a developer has to do is to update the software stack to a version that is still supported and maintained. While this is not only a time consuming factor, it is often a high risk to introduce hidden regression bugs into the software, leading to a much higher validation and testing cost than what would be needed just to test the new feature.

> Keeping your software stack up to date is not glamorous work, but it is one of the most important investments into keeping the cost of change low.

When it comes to the controllable cost of change, there are a number of strategies that can be applied to reduce the cost of change in your code. Of the steps identifying the requirements, looking for the parts of the code that need to be changed, changing the code, testing the changes, validating the changes and deploying the changes all have potential for optimization. Here are some strategies that can be applied to reduce the cost of change in your code:

### Identify requirements - Say "No" to a change

Let's start at the very beginning at *identifying requirements*. The biggest cost saver here is saying "No" to a change. One of the twelve principles of the agile manifesto is **"Simplicity--the art of maximizing the amount of work not done--is essential."** The equation is simple, the less features and code there is in a product, the less there is to maintain. To do so a clear discussion about the value of the change is necessary,  Ask "do we (or one of our stakeholders) benefit if we do this?" if the answer is not a clear "yes", then don't do it. To help with this decision, [rigorous slicing of stories into small, incrementally applicable changes](the-art-of-slicing/) is a must. This is done to reduce development effort while maximizing the value of the change.
A frequent mistake here is that teams at this point are not talking about the value, but about the predicted cost only. A typical pattern I observe is that developers are asked to estimate the change and if they give a low enough number, the change is applied.

> A common mistake when deciding whether to fix a defect or add a feature is to talk about cost only instead of value first.

Another frequent omission at that stage is to not talk about what to remove from the product and talk about deprecation. If a product is running over decades, it is natural that some features at one point will become obsolete or too cumbersome to use and maintain. Having a clear strategy on how to remove or replace features from a product is as important as adding new ones. That usually involves a clear communication strategy to the users and stakeholders, a clear way to mark features as being phased out and a clear plan on how to remove the feature from the codebase. Handling deprecation well can save a lot of cost in the long run. Removing bad or dead code reduces the noise developers have to dig through when looking for the parts of the code that need to be changed.

### Finding the parts of the code that need to be changed

Once the decision is made to implement a change, the next step is to find the parts of the code that need to be changed. This is where good software design and architecture comes into play. The more modularized and decoupled your code is, the easier it is to find the parts of the code that need to be changed. There is a high chance that after a few years of development, the people maintaining the code are no longer the same people who wrote the code. And even if they are, there is a high chance that a lot of detail just got forgotten. If the code is well structured and modularized, it is much easier for new developers to find their way around the codebase and to understand what needs to be changed. Build your software around a consistent architecture and design patterns, so it is easier to find the parts of the code that need to be changed. 
This can start a he smallest level for instance on how you use functions, are you using non-const output-parameters in functions or are you strictly using structs as return values? Do you use exceptions or error codes to signal errors? You may like or not like some of these patterns, *whatever you choose, be consistent*.  

> Consistency in software design and architecture is more important than the actual choice of the pattern, to make locating the parts of the code that need to be changed easier.

Consistency extends all the way up to the architecture patterns like MVC, MVVM, Clean Architecture or Hexagonal Architecture and whatever els is out there. Again consistency is more important than the actual choice of the pattern, although choosing the completely wrong architecture can be a major cost driver. Whatever architecture you pick, favor strong modularisation, low coupling and high internal cohesion for your modules to reduce the cost of change.

Stick to your chosen design within a module, but decouple modules as much as possible. If your code is tightly coupled, you will have to change many other parts of the code when you change one part. This is a major cost driver in software development. The more code changed, the more likely you are to introduce bugs and the higher the testing effort will be. This of course has a backwards effect on the decision whether to implement the changed requirement or not. If you are sure that the change will be localized and not affect other parts of the code, it's way easier to say "yes" to a change.
Once you found the code, the fun part starts - changing the code and implementing the change.

### Implementing the change

When implementing a change having invested in good software practices up front pays off a lot. But even if that was not done in the past, then start applying good practices with the change on hand. It might as well be that when the original code was written there were no proper unit tests around, TDD was not practiced and no code reviews were done. So what? Start doing that now! One of the most important things you can do at that stage is to further reduce the cost of change. I tend to say that every implementation should start with a refactoring first. Maybe the existing code is not following the current coding standards, has the wrong level of abstraction or is not using any of the patterns you have chosen for that particular module. Don't build on broken stilts, refactor the code first, so it is easier to understand and change.

> Every implementation should strive to further reduce the cost of change (or at least not increase it significantly).

There is of course a trade-off on how much can be done, at one point we might have to accept that some parts of the code are just too costly to repair and that we hit a flat spot on how much we can reduce the cost of change. The trade off here is usually whether to sacrifice internal coherence of a module but improving decoupling and isolation of "bad code" more. On a whim I usually try to isolate first rather than to keep coherence, but that is a personal preference and depends on a lot of factors.

{% include figure.html url="images/cost-of-change/tdd-cycle.png" description="The TDD cycle of create a failing test, make the test pass, refactor, start again."%}

A very good practice to make sure the cost of change stays manageable when implementing new features is to use a TDD approach and relentlessly apply the full cycle, which includes refactoring of the original code. To skip the last step in the TDD cycle is a direct invitation to increase the cost of change. The other benefit of a TDD approach is that test coverage of new code stays high. Which helps with verifying that the change is correct and that no regression bugs are introduced.

### Testing and validating the changes

When thinking about the cost of a new feature, the testing and validation cost is often forgotten or underestimated. This often goes back to the segmentation of the system and how localized the change is. The splash radius of a change is often a very good indicator on how high the testing and validation cost will be. If the change is localized, the testing effort is usually low, the wider the effects the more expensive testing goes. For instance optimizing the performance of a single algorithm is usually a very localized change and testing through an benchmark of before/after can be sufficient. Optimizing or changing a full workflow in the business logic could have a much wider effect and require a lot more testing, often involving manual testing - which is expensive.

While the verification of a feature - aka it works as defined - can often be automated, the validation - aka it works as expected - is often a manual process. The more manual the validation process is usually the higher contribution to the cost of change. It often pays off to think of what kind of validation is needed for a feature before actually implementing it. Sometimes validation of a change can only be done by the end user, so an easy way for (selectively) deploying changes to a subset of users can be a good strategy to reduce the cost of change.

### Deploying the changes

So the change is now implemented and tested! Very good, now let's ask the developers to roll it out to the production environment. This is where the cost of change can skyrocket. If the deployment process is manual, error prone and time consuming, the cost of change is high even for the tiniest change. This can go up to the point, where developers avoid even the tiniest fixes, for fear of the cost of deployment. 

> invest in an easy-to-operate and automated deployment process to reduce the cost of change and deploy changes one by one instead of bundled together into large releases.

The deployment process is often a neglected part of the software development process, but it is a very important part of the cost of change. If deployment to production is hard and involves jumping through seven hoops to get it done, a common pattern is that multiple changes are bundled together to reduce the cost of deployment. The problem here arises that at one point the feedback loop gets a lot longer and that big releases have a much higher chance to introduce hidden regression. Another pattern frequently observed is that if deployment is expensive, only big and heavy changes are even passing the decision threshold at the beginning of the cost-of-change cycle. Because, why spend days deploying a small change that might not even be needed? The result is software that might just do what it is supposed to do, but the many small kinks and annoyances that are never fixed make it a pain to use.

As long as a feature is not deployed it only generates cost, but no value, so early deployment of any change will bring more value over time. This leads to one of the most destructive and behavioral patterns in software engineering. Only discussing software development from the cost perspective when evaluating whether to apply a change or not. While it might be true, that software development is not cheap, holding back the work done and not letting if generate value is even more expensive. This closes the cycle of the cost of change, because if features are never deployed, the cost of change for the next feature might be even higher. 

## Optimizing for reduced cost of change is a systemic problem

Being aware of the cycle that drives the cost of change is the first step to reduce it. The cost of change in software engineering is not just a technical problem, but a systemic problem that involves the whole team or even larger parts of an organization. 

{% include figure.html url="images/cost-of-change/cost-of-change-cycle.png" description="The circle of managing cost of change in software."%}

Optimizing the cycle can be a challenging task, however if the cycle is observed then one can usually spot the major bottlenecks quickly. Start where it hurts the most and where work piles up, because it's waiting for action.
Whether it is improving the deployment infrastructure and processes, investing in test automation, improving the architecture or design of the software or just training to say "No" to a change, there are many ways to reduce the cost of change in software.