---
layout: post
title: Bringing software quality into roadmaps
description: How to bring software quality topics into a roadmap? 
thumbnail: images/writing-cmake-best-practices/thumbnail.jpg
---

"We really struggle to bring engineering topics into the roadmap! When do we finally get the time to improve our code quality?" Is a gripe that many software engineering teams have when doing roadmaps. Improving or working on software quality often comes second when software roadmaps are formulated. After all, it is often very hard to argue what the direct customer value for improved maintainability is. Nevertheless creating quality software is a necessity if products are expected to perform on the market and be developed for a long time. It is not that the business-facing people in software development such as POs, marketing, sales and so on are not interested in having a quality product at their hand. The reason is more often than we engineers are very badly prepared to hold a constructive dialog on software quality with people with a less technical focus. 

One of the underlying problems is that lot's of teams struggle to define software quality in the first place and just refer to any of the work on improving a codebase as "refactoring" or "working on tech debt". While both are very important things to do and engineers probably have quite a clear idea of what this entails, they do not serve well when talking with non-technical people or when creating a plan. 
Today's software engineering is often very value driven. If one cannot argue the value of an intended task it will be deprioritized. So if we want to bring software quality topics into the planning discussions, we have to change our approach. 

# Defining Quality

Luckily a very comprehensible definition of what software quality entails, is already available in the [ISO 25010 model for software product quality](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010). In essence the ISO standard lists eight characteristics of software quality. 

{%include figure.html url="images/software-quality/iso25010.png" description="The iso 25010 standard, listing the 8 characteristics for software quality" source="https://iso25000.com/index.php/en/iso-25000-standards/iso-25010" %}

The details can be read up on the [ISO 25010 homepage](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010), but in a nutshell the eight characterisitcs are:

* **Functional Suitability** - How well does the product meet the stated and implied needs? 
* **Performance efficiency** - How effectively does the product use the available resources?
* **Compatibilty** - To what degree can the system interact or exchange information with other products and systems?
* **Usability** - How satisfactory and effective and efficient are the users when using the product?
* **Reliability** - How well does the system perform its function under specific conditions?
* **Security** - How well is the system and the data within the system protected against unauthorized access?
* **Maintainability** - How effective and efficient can the system be changed or developed further?
* **Portability** - How easy can the product be transferred to a different hardware or run-time environment?

Since this is an international standard these characteristics lack context and depending on the industry a few additional characteristics might be needed to describe software quality. The Med-Tech industry notably often adds **Patient safety** to the list, but for most use cases using just the 8 characteristics of the iso standard are usually a very good starting point. 



# Assessing the current state & Tying KPIS


# Preference Matrix & QFD 


@todo edit description - Roadmapping or planning in general?

