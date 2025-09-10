---
layout: post
title: The art of slicing stories
image: /images/slicing/thumbnail.png
hero_image: /images/slicing/thumbnail.png
hero_darken: true
tags: agile, software-delivery
---

**Breaking down stories in small, manageable chunks is an essential skill when maintaining a good backlog.** Sounds good, but how does one actually do the slicing? Splitting backlog items is not magic, but a skill that can be learned. All it needs is a bit of thinking and a few techniques to get going. 

## Good user stories

A *good* backlog defines what a product will be and enables continuous tracking of progress and making forecasts. To gather the needed information often and be able to react to change, short cycle times of the backlog items are essential. 
While short a short average cycle time does not increase capacity, it means that ideas go faster into production. And being quickly in production generates feedback often as it reduces the risk of doing the wrong thing and gives frequent opportunities to adjust the direction development takes.[^1]

The form of [user-stories](https://www.mountaingoatsoftware.com/agile/user-stories) is widely used to describe the content of product backlog items (PBI) and "PBI" and "story" are often used interchangeably. 
The goal is that all PBIs produce value for any of the beneficiaries of a product while being as small as possible. A tough combination, which is why slicing stories is such an essential and valuable skill to have as a team. 

![Slice backlog items to valuable but easy to digest bits]({{site.baseurl}}/images/slicing/slicing-apples.png)

The original definition of a "user story" suggests to write them in the **As an X I want to Y in order to Z** format. In this sentence several things are encoded:

* Who is the main beneficiary?
* What do they want to achieve?
* Why do they want to achieve that?

Having that information present and easily accessible in a PBI helps a lot, even if the sentence itself is not used. To do this, people working on this backlog need **to know their stakeholders** and have a good grasp on the **business- or use-case of a product.** Once this information is there, the slicing can begin. 

## Trivial slicing by language

A very crude but surprisingly effective way to slice stories is by simple language, especially when using the story format. Just slice on every "and", "or" and comma. This by itself will not necessarily yield very good stories, but it is very fast and can be done without much discussion. This gets the iterative process of writing stories started really quick. There might be a few unusable "dead-end-stories" in the process, but merging them again is often easier.

## Slicing along technical boundaries - bad idea

A common mistake when slicing PBIs is splitting along technical layers, often referred to as vertical slicing. As an example, a story is sliced in the database, backend and frontend part. Splitting like this often looks appealing and often natural to software engineers, as it gives a strong hint of the implementation order. The problem here is that, to bring value to the customer all backlog items have to be completed, so this is often only *pretending* to reduce the size of a PBI. The order of execution of such items is often no longer arbitrary, which is again a strong indicator that the PBIs are not properly separated and do not bring value on their own. 

## Slicing along stakeholders - better

Ensuring that each story is tailored to exactly one stakeholder group is a much better alternative. Often the use-cases of the different stakeholder groups do not match exactly, if one looks close enough. Maybe the look and feel of the end product might be the same for all, but often different groups to the same thing but want to achieve different results. 
A reasonably detailed analysis of the stakeholders is a must to be able to do this and *stakeholder maps* or *user-personas* are good tools for such an analysis.
Using the word "user" in stories to describe an actor should ring an alarm bell, that the team does not have a clear picture of who the beneficiary of a story is. 

## Splitting by what - tedious and rewarding

Slicing along the "What do the stakeholders want to achieve" is often more tedious than difficult. Describing in detail, what the actors problem is and how he/she goes forward to solve it helps with splitting. It is however a fine line between what the stakeholders want to achieve and prematurely sketching out a solution, which is often a bit dangerous. 
Language can help us again, consciously chaining the sentences with "and then" quickly sounds monotonous which indicates when we're summarizing too much and indicates splitting points. 
The more we hide system complexity from the user - often a good thing - splitting the "what" becomes much harder. Amazons one-click-buy is such a small interaction, splitting it down is almost impossible. If you end up at that point early in development this might be a hint that one tries to optimize a feature prematurely and wants to skip iterations.

## Fragmenting by why - the power move

Trimming down by the "Why do the stakeholders want to achieve that" is often yielding strong results, but is often difficult. Most of the time this means digging down and redefining what the stakeholder actually wants to do. I find the [5 Whys](https://en.wikipedia.org/wiki/Five_whys) a very simple method to refine the "why".

Especially for functionality that is common in many apps I noticed a tendency to make the action too big. Fragmenting the action described into smaller and smaller steps is will often dramatically reduce the size of a PBI. As a side not it often helps fostering discussion about the actual problem the stakeholders are trying to solve with the product. 


## Slicing robustness and sophistication - being clumsy on purpose

Proper handling of exceptions and misbehavior is necessary, but handling every edge case individually often blows up stories beyond proportion. Splitting stories explicitly into how gracefully they handle failures can help reducing the implementation complexity and thus make it smaller. 
First implementing the success case and creating individual stories for handling the failures gives movement in how many of the rare edge cases actually need proper handling. Good monitoring to track those failures in production further helps with prioritizing. This of course does not mean to let the system crash, but often having the user interact more than necessary with the system to fix an error. 

## Training, training, training - while doing it

Luckily slicing stories is a skill that can quite easily be acquired while doing it. Make "how could we have sliced this better" a standing question, whenever a backlog item is completed and try to find patterns. 
How much slicing is enough? Smaller is better and most teams usually find a comfortable story size soon. Most successful teams I know have mean cycle times for "in progress" between one and three days for a PBI. With a tendency of going smaller if they can. 
Of course there are some PBIs which take much longer and some that take a lot less time to complete and that is OK as long as the vast majority falls into the comfortable rang. 
Slicing relentlessly smaller and tracking afterward is often better than setting time as a goal for slicing. The question is "how do we decompose the value delivered more", not "~~how do we get faster~~". 
If estimating is still done for such stories it is advisable to slice first and give the estimate later to avoid stopping when a magical number is reached. I observed that when teams get good at slicing they often find it easier to ditch the estimation effort completely and go #NoEstimates. 
For teams suffering long cycle times, radical slicing is one of the first things to optimize before anything else. 

---

[^1]: ["small is beautiful" good article explaining the importance of small batch sizes](https://medium.com/faun/small-is-beautiful-the-importance-of-batch-size-ea968ed8d477)