---
layout: post
title: Bringing software quality into roadmaps
description: How to asses software quality and how to bring software quality topics into a roadmap? 
thumbnail: images/writing-cmake-best-practices/thumbnail.jpg
---

"We really struggle to bring engineering topics into the roadmap! When do we finally get the time to improve our code quality?" Is a gripe that many software engineering teams have when doing roadmaps. Improving or working on software quality often comes second when software roadmaps are formulated. After all, it is often very hard to argue what the direct customer value for improved maintainability is. Nevertheless creating quality software is a necessity if products are expected to perform on the market and be developed for a long time. It is not that the business-facing people in software development such as POs, marketing, sales and so on are not interested in having a quality product at their hand. The reason is more often than we engineers are very badly prepared to hold a constructive dialog on software quality with people with a less technical focus. 

One of the underlying problems is that lot's of teams struggle to define software quality in the first place and just refer to any of the work on improving a codebase as "refactoring" or "working on tech debt". While both are very important things to do and engineers probably have quite a clear idea of what this entails, they do not serve well when talking with non-technical people or when creating a plan. 
Today's software engineering is often very value driven. If one cannot argue the value of an intended task it will be deprioritized. So if we want to bring software quality topics into the planning discussions, we have to change our approach. 

## Defining Quality

Luckily a very comprehensible definition of what software quality entails, is already available in the [ISO 25010 model for software product quality](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010). In essence the ISO standard lists eight characteristics of software quality. 

{%include figure.html url="images/software-quality/iso25010.png" description="The iso 25010 standard, listing the 8 characteristics for software quality" source="https://iso25000.com/index.php/en/iso-25000-standards/iso-25010" %}

The details can be read up on the [ISO 25010 homepage](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010), but in a nutshell the eight characterisitcs are:

* **Functional Suitability** - How well does the product meet the stated and implied needs? 
* **Performance efficiency** - How effectively does the product use the available resources?
* **Compatibility** - To what degree can the system interact or exchange information with other products and systems?
* **Usability** - How satisfactory and effective and efficient are the users when using the product?
* **Reliability** - How well does the system perform its function under specific conditions?
* **Security** - How well are the system and the data within the system protected against unauthorized access?
* **Maintainability** - How effective and efficient can the system be changed or developed further?
* **Portability** - How easy can the product be transferred to different hardware or run-time environment?

For most cases using these 8 characteristics is a very good starting point, but as this is an international standard which is applied to a very broad audience, these characteristics lack context. Depending on the industry, a few additional characteristics might be needed to describe software quality for the context. For example, companies in the Med-Tech industry often add **Patient safety** to the list and airspace might add a quality metric about how likely a fault in a piece of software might result in a crashing plane. However, I advise strongly to try to keep the characteristics to an absolute minimum. Defining and understanding the quality metrics and is a very first step towards getting an actionable plan on where and how to improve quality in a software system. Often the very first thing to put into action is to gather everyone involved with developing the software and gaining an alignment on the understanding on the various quality characteristics. 
## Assessing the current quality

Once the characteristics are known in an organization, creating a quality assessment and quality goals of the current software will help you to formulate a gap analysis. A very simple one is to have the developers draw a spider graph of where they think their software currently is and set a goal value of how important each quality metric is to the overall product. For a first iteration, this can be done on gut feeling if people know the code reasonably enough. Later you might want to find and agree on a more data-driven metric. Either way, one of the most important things to do is to set the scale of the spider graph and agree to what each number means. 

An example scale could look like this

| Scale | Overall Score                | Frequency of reported issues of medium or higher severity | number of known defects | impact of issues on users |
| :---- | :--------------------------- | :-------------------------------------------------------- | :---------------------- | :------------------------ |
| 1     | Bad, not satisfactory at all | Daily/Weekly                                              | large                   | Work cannot be performed  |
| 2     | Not satisfactory             | Weekly                                                    | few                     | Work is severly impeded   |
| 3     | OK                           | Monthly                                                   | almost none             | work is inconvient        |
| 4     | Good                         | Quarterly                                                 | none                    | temporary inconvenience   |
| 5     | Excellent                    | Half-Yearly                                               | none                    | Users might not notice    |

Once the scale is established drawing a spider graph of how the characteristics are rated as well with an expected goal value or relevance for the product helps to visualize the current state and gap for each characteristic. It is of course tempting to put all goal values to the highest value so a good approach is to weigh the goal values by relevance. An embedded system without any user interface might have a low relevance in the usability part, or software running in a very isolated environment might put the compatibility or portability part to a very high number. Another good way of getting more realistic values is to place the goal number at the value that we want to achieve with the next product increment. 

Assessing the gap in software quality from an engineering perspective is a good starting point to start the discussion on how to get actual work items regarding improving quality into a prioritized backlog. 

## Preference Matrix 

Quality assessments will often yield several areas where one could invest work to close the gap between the current state and the desired state, but on what should one focus first? A very useful tool I frequently use is a preference matrix of the quality characteristics, by having each characteristic compete against another. This of course has to be negotiated with the product owner or any other relevant stakeholders of the product. 

Go through the matrix from the top left to the bottom right always asking: "If you have to choose, would you rather invest into A or into B in the next product increment" and note down the more important quality characteristic. Afterward, you count the number of mentions and divide it by the total sum of all combinations to get a percentage value. The higher the percentage, the more important a quality characteristic is. By comparing the characteristics against each other you avoid having all characteristics with an equal right. I usually end up with one or two top contenders, so I prioritize any work that shifts the needle for those characteristics before any other. The ranking of the quality aspects can serve to show how relevant they are. 

The last and final step to getting work that benefits the product quality the most into the roadmap is mapping any planned backlog item to the preference matrix. 

## Mapping Quality Characteristics to Features and Epics

To find out which feature or story pays for which metric, I like doing a stripped-down version of the [Quality Function Deployment (QFD) method](https://www.sciencedirect.com/topics/engineering/quality-function-deployment). For this method, we try to assess the influence of each feature on each quality metric. Those features that influence the quality characteristics that got the highest scores in the preference matrix are prioritized first. 

And finally, we close the circle to the quality assessment we did at the beginning, by checking wheter the prioritized actions are closing the gaps we determined at first. If this is the case: good, go on with the backlog. If not, either rethink the assessment or find out where there is a conflict between the importance of the quality characteristic as determined in the preference matrix and the target goals set by the quality assessment. 

## Quality evolves

As any aspect of a product, the quality will change over time. Some aspects might degrade because of the complexity added but more often there is an inflation in the values added. As products evolve, users get used to a certain quality and expect higher standards, which means that what was perceived as sufficient or high quality might suddenly be perceived as shabby. Security is a prime example for this: A few years ago it was rare to have two factor authentication for an online service, while nowadays it is becoming more and more a standard up to the point where people will not use a service if there is no 2FA present. So it pays to adjust the quality asssessment and preference matrix every other planning cycle. 

Once the quality assessement and preference matrix are there, doing the mapping of the larger efforts in the backlog to the quality characteristics should become a standard practice when planning. As with a lot of things, doing it the first time will take some time, but if done repeatedly teams usually get very efficient at processing and using the information and will get a lot of value out of this additional aspect of planning. 


