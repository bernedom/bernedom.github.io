---
layout: post
title: The art of slicing stories
thumbnail: images/remote-teamwork/thumbnail.jpg
---

**Breaking down stories in small, manageable chunks is an essential skill to maintaining a good backlog.** Sounds good, but how does one actually do the slicing? Splitting is a skill that involves a lot of thinking, but it can also be learned and there are a few techniques to get going. 

## Having a "good" backlog

A good backlog defines what a product will be and allows to visibly track progress and make forecasts. As such short cycle time of backlog items essential to gather that information often. A lot of teams I know over time us some form of [user-stories](https://www.mountaingoatsoftware.com/agile/user-stories) as product backlog items (often abbeviates as PBI). 
The primary goal of using user stories is that each backlog item should bring some kind of value to the customer. One of the tough problems encountered is often slicing stories in small but valuable and workable chunks. 

Image *** Typical value chain: come up with an idea, refine and slice, work, review, done **

The original definition of a "user story" suggest to write in the **As an X I want to Y in order to Z** format. In this sentence several things are encoded:

* Who is the main beneficiary?
* What do they want to achieve?
* Why do they want to achieve that?

Even if a team does not follow that format, having that information present and easily accessible in a PBI helps. To do this people working on this backlog need **to know their stakeholders** and have a good grasp on the **business- or use-case of a product.**

## Trivial slicing by language

A very crude but surprisingly effective way to slice stories is by simple language, especially when using the story format. Just slice on every "and", "or" and comma. This by itself will of course not yet yield very good stories, but it is very fast and can be done without much discussion. There will be the odd case where this ends up in unusable stories happens, merging stories again is often easier than slicing. Formulating stories is an iterative process, so do not fear producing a few "dead-end-stories" in the process.

## Slicing along technical boundaries - bad idea

A common mistake when slicing PBIs is splitting along technical layers, often referred as vertical slicing. For instance a story is sliced in the database, backend and frontend part. Splitting like this often looks appealing and natural to software engineers, as it gives a strong hint of the implementation order. The problem here is that, to bring value to the customer all backlog items have to be completed, so this is often only pretending to reduce the size of a PBI. Often the order of execution of such items as also is often no longer arbitrary, which is again a strong indicator that the PBIs are not really separated. 

## Slicing along stakeholders - better

A very good and often quite easy practice is, to ensure that each story is tailored to exactly one stakeholder group. While it is tempting to create stories that cater to many stakeholder groups at once in the hope of creating more value t often bloats the PBI.
Most of the time the use-cases of the different stakeholder groups do not match exactly if one looks close enough. Maybe the look and feel of the end product might be the same for all, but often different groups to the same thing but want to achieve different results. This of course needs a reasonably detailed analysis of the stakeholders. Having a stakeholder map or personas are good tools for this.
Using the word "user" in stories to describe an actor should ring an alarm bell, that the team does not have a clear picture of who the beneficiary of a story is. 

## Splitting by what - tedious but rewarding

Slicing along the "What do the stakeholders want to achieve" is often more tedious than difficult. Describing in detail, almost down to the single key stroke, mouse movement or gesture, what the actor of the story does can help with splitting. This poses it's own dangers, as it is a fine line between to what the stakeholders want to achieve and prematurely sketching out a solution.
I like doing the "I was like" method: Consciously chaining the sentences with "and then" and having someone count this. Very often this quickly sounds monotonous which shows when we're summarizing too much. 
Unfortunately the more we hide system complexity from the user - a good thing - splitting the what becomes much harder. Amazons one-click-buy is such a small interaction, splitting it down is almost impossible. On the other hand if you end up at that point early in development this might be a hint that one tries to optimize a feature prematurely and wants to skip iterations. 

## Fragmenting by achievement - the power move

Trimming down by the "Why do the stakeholders want to achieve that" is often yielding strong results, but is often difficult. Most of the time this means digging down and redefining what the stakeholder actually wants to do. I find the [5 Whys](https://en.wikipedia.org/wiki/Five_whys) a very simple method to refine the "why".

Especially for functionality that is common in many apps I noticed a tendency to make the action too big. Fragmenting the action described into smaller and smaller steps is will often dramatically reduce the size of a PBI. As a side not it often helps fostering discussion about the actual problem the stakeholders are trying to solve with the product. 


## Slicing robustness and sophistication - being clumsy on purpose

Proper handling of exceptions and misbehavior is necessary, but handling every edge case individually often blows up stories beyond proportion. Splitting stories explicitly into how gracefully they handle failures can help reducing the implementation complexity and thus make it smaller. 
First implementing the success case and creating individual stories for handling the failures gives movement in how many of the rare edge cases actually need proper handling. A good monitoring to track those failures in production further helps with prioritizing. This of course does not mean to let the system crash, but often having the user interact more than necessary with the system to fix an error. 

## Training, training, training - while doing it

Slicing stories is a skill that needs training. But luckily when working in an agile way we can practice it often. Make "how could we have sliced this better" a standing question, whenever a story takes more than a few days to complete. 
How much slicing is enough? Each team I know have it's own "comfortable" story size, most measuring cycle times for in progress between one and three days. Of course there are some stories which take much longer and some that take a lot less time to complete, but the mean average should fall into that range. But generally I advise to slice as much as possible by content and track afterwards, not setting a time as goal for slicing. The question should be "how do we decompose the value delivered more", not "~~how do we get faster~~". If estimating is still done for such stories it is advisable to slice first and give the estimate later bias on when to stop and to avoid the overhead of re-estimation. In fact I if a team gets good at slicing they often find it easier to ditch the estimation effort completely and go #NoEstimates. 

If your stories have long cycle times or if you spend too much time estimating and tracking progress try out radical slicing before optimizing anything other. 


---
