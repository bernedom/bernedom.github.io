---
layout: post
title: The art of slicing stories
thumbnail: images/remote-teamwork/thumbnail.jpg
---

**Work serially and in small batch sizes.** is one of the cornerstones of working lean. Whatever agile framework you're using all of them make use of a backlog to define and prioritize work. In order to visibly track progress and make forecasts it helps when when the cycle time of backlog items is as short as possible. The concept of [user-stories](https://www.mountaingoatsoftware.com/agile/user-stories) as primary item is widely distributed. The primary goal of using user stories is that each backlog item should bring some kind of value to the customer. One of the tough problems encountered is often slicing stories in small but valuable and workable chunks. Slicing is a skill that needs to be trained and constantly honed, but when it comes to creating and maintaining a good backlog it is THE central skill. All other come later. So how does one get along with slicing?

Image *** Typical value chain: come up with an idea, refine and slice, work, review, done **

A good backlog item follows the (INVEST)[https://en.wikipedia.org/wiki/INVEST_(mnemonic)][^1]. Even if the backlog item is not written as a user story following the **As an X I want to Y in order to Z** format the information hidden in this sentence should still be present. 

* Who is the main beneficiary?
* What do they want to achieve?
* Why do they want to achieve that?

This information is often a very good indicator for slicing stories. As such it is important that the people working on this backlog **know their stakeholders** and have a good grasp on the **business- or use-case of a product.**

## Trivial slicing by language

A very crude but surprisingly effective way to slice stories is by simple language, especially when using the story format. Just slice on every "and", "or" and comma. This by itself will of course not yet yield very good stories, but it is fast and can be done without much discussion. And even if the odd case where this ends up in unusable stories happens, merging stories again is often easier than slicing. 

## Slicing along technical boundaries - bad idea

One of the most common mistakes when slicing stories is that they are sliced along technical layers, often referred as vertical slicing. For instance a story is sliced in the database, backend and frontend part. This kind of slicing often comes naturally to engineers and technical people and is often appealing as it gives a strong hint of the implementation order. The Downside is that no backlog item brings value if completed by themselves and that the order of execution is often no longer arbitrary, which makes this reduces the leanness of the backlog significantly by essentially not reducing  the size at all. 

## Slicing along stakeholders - better

The simplest way to slice stories is often by stakeholder group. While it is tempting to create stories that cater to many stakeholder groups in the hope of creating more value a very good practice is to ensure that each story is tailored to exactly one stakeholder group. Most of the time the use-cases of the stakeholder groups do not match exactly if one looks close enough. Maybe the look and feel of the end product might be the same but often different groups to the same thing but want to achieve different results. 
This of course needs a reasonably detailed analysis of the stakeholder i.e. by having a stakeholder map or personas. Using the word "user" in stories to describe an actor, is often a sign, that the team does not have a clear picture of who the beneficiary of a story is. 

## Fragmenting by achievement - the power move

Notoriously difficult but yielding strong results is trimming down the "What do the stakeholders want to achieve". This goes often together with redefining what the stakeholder wants to do. I find the [5 Whys](https://en.wikipedia.org/wiki/Five_whys) a very handy method to refine the "why" 

Especially for functionality that is common in many apps I noticed a tendency to make the action too big. Fragmenting the action described into smaller and smaller steps is will often dramatically reduce the size of a PBI. Finding the moment to stop needs a bit of training, but usually is learned pretty fast. 

## Splitting by what 

Let the user do baby steps as well. Describing in detail, almost down to the single key stroke, mouse movement or gesture, what the actor of the story does can help with splitting. By consciously chaining the sentences with "and then" and having someone count this, this often shows when we're trying to summarize too much. However the more we hide the system complexity from the user - a good thing - splitting the what sometimes is really not possible. i.e. Amazons one-click-buy is such a small interaction, splitting it down is almost impossible. 

## Slicing robustness and sophistication

Proper handling of exceptions and misbehavior is necessary, but handling every edge case individually often blows up stories beyond proportion. Splitting stories explicitly into how well they handle failures can help reducing the implementation complexity and thus make it smaller. First implementing the success case and creating individual stories for handling the failures gives movement in how many of the rare edge cases actually need proper handling. A good monitoring to track those failures in production further helps with prioritizing. 

## Training, training, training - while doing it

Slicing stories is a skill that needs training. But luckily when working in an agile way we can practice it often. Make "how could we have sliced this better" a standing question, whenever a story takes more than a few days to complete. 
How much slicing is enough? Each team I know have it's own "comfortable" story size, most measuring cycle times for in progress between one and three days. Of course there are some stories which take much longer and some that take a lot less time to complete, but the mean average should fall into that range. But generally I advise to slice as much as possible by content and track afterwards, not setting a time as goal for slicing. The question should be "how do we decompose the value delivered more", not "~~how do we get faster~~". If estimating is still done for such stories it is advisable to slice first and give the estimate later bias on when to stop and to avoid the overhead of re-estimation. In fact I if a team gets good at slicing they often find it easier to ditch the estimation effort completely and go #NoEstimates. 

If your stories have long cycle times or if you spend too much time estimating and tracking progress try out radical slicing before optimizing anything other. 


---

[^1]: The movement of #noEstimates the challenges the 'E' strongly