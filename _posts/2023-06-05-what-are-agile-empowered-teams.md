---
layout: post
title: The four core powers of an empowered agile team
description: "The term empowered teams is often used in the context of agile software development. But what does it mean? There are many variations of this but there is a definitive set of 'minimum powers' that a team needs to be able to be agile."
thumbnail: images/testing-with-hardware/thumbnail.jpg
---

**Empowering Teams is a key aspect to create high-performing teams in an agile setting.** Ever since [Extreme Programming](http://www.extremeprogramming.org/) was introduced into the world of software development this statement or a variety of it has been carried over to almost all agile frameworks. And there is a multitude of articles about how to create them. But what does "empowered" exactly mean? What are the minimum powers that a team needs to be able to be agile?

As with a lot of things in agile, the bandwidth of how far one wants to go with empowering the team depends heavily on the context and the organization a team lives in. This can range from choosing their agile framework to budget allocations up to teams doing their hiring. However, if we focus on the process perspective of delivering quality software effectively, there are surprisingly few things that a team needs to be able to do to significantly change the game of agile software delivery.

## Minimum Empowerment and Performance

If we define *performance as "the ability of a team to constantly deliver value to the customer in a timely fashion"* then we can derive the minimum empowerment that a team needs to be able to do this. 

> Performance is "the ability of a team to constantly deliver value to the customer in a timely fashion"

From this definition, we can deduct the minimum of core powers that a team needs to be able to be performant:

* Being able to prioritize their backlog and have the final word on what is in it - this includes the ability to say no to backlog items and delete them
* Being able to allocate capacity and work 
* Setting the pace for releases and deciding when to release what
* Shaping their development and testing infrastructure to their needs without organizational hurdles

In short, this can be summarized as "The team can decide what to do, who does it when, and how". It is almost impossible for one empowerment to work out without the others being there, but if one has to start building up the empowerment starting with the ability to [prioritize and maintain their lean backlog](https://dominikberner.ch/lean-backlog-handling/) is often a good first power to gain. If it is clear to the team what to do next, then the team can decide "how much" of the backlog it can or wants to deliver in a given amount of time, which boils down to capacity allocation within the team.
The team usually has a good overview of what non-backlog-related tasks are on their plate - such as maintaining infrastructure, taking care of individual education, or fixing things discovered in a retro. All this has to be taken into account and who can do this better than the team itself? The power to allocate capacity for working on the backlog directly translates to the ability to set the pace for releases. I still stand on the point that releasing often and in small increments is superior to rare big-bang releases, quality assurance and releasing need to be highly automated tasks that need little to no human interaction. This directly leads to the team's need to be able to shape their infrastructure after their fashion. This includes the ability to decide what tools to use and how to use them. In reality, there are often some organizational constraints to this, but again the fewer the better. Let's look at each of these powers in more detail and how they work together.

### The power of prioritizing the backlog

The backlog is the central artifact in agile software development and as such it is a prioritized *list of problems to be solved*. Some of them might not yet be fully understood and for most of them, there might exist several solutions.  

> The backlog is a list of *problems to be solved* - not a list of task to be done

Software development is a flow-based activity, which needs focus to be done effectively and efficiently and as the team knows best how to get into the flow, they need the power to say what they want to work on next and to *assign a unique priority* to the backlog items. While the team should have the final say on what goes to the top of the backlog, they need to be acutely aware of their customer's needs, and the team must respect and manage stakeholder expectations about what is important for who. As such teams need to be keenly aware of the different stakeholder groups regarding their product and understand their needs and expectations and they need the clout so stakeholders accept it if the teams say "No - We're not doing this (yet)". 
Long term a team should strive to have some kind of fairness regarding the prioritization of the needs of each stakeholder group - including the team's own needs. By determining what part of the backlog the team should do next, they can align that with their capacity to do work. 

### The power of allocating capacity and work

Once the priority of problems to solve is established, the team should be able to determine how much of the backlog they want to tackle at the same time. This is independent of the agile framework chosen, be it kanban where the team sets their work-in-progress limits, or scrum where the single sprints give a limited timeframe to tackle problems. Part of being able to allocate work is [slicing backlog items](https://dominikberner.ch/the-art-of-slicing/) to a workable size and breaking down the problems into smaller chunks that can be solved iteratively and incrementally. This is a skill that can easily be learned on the job and most teams master it relatively quickly. The number of problems solved and time invested has a direct relation to when solutions can be released to the customer and since the teams decide what to do with which capacity they naturally are in charge of setting the pace for their releases. On the other hand teempowered teamsams often also have some tasks that are inward facing such as maintaining their infrastructure, fixing bugs, mentoring each other, or learning new things. These tasks also need to be taken into account when allocating capacity and the team is in the best position to do so.

### The power of setting the pace for releases

Grass doesn't grow faster if you pull on it - and software is not delivered faster by setting arbitrary deadlines. Sure, there might be outside constraints that determine good time windows for releasing to the public, but generally, these windows are not as business-critical as we are often made to believe. Overall it is a much better strategy for teams to set the pace for releasing. This works especially well if the team manages to release often and in small increments. Ideally, features are pushed to the customers whenever they are ready instead of artificially waiting for a specific date because this increases the speed of the feedback loop. As the team is responsible for allocating time and ensuring the quality of their work, naturally, the team should be in charge of saying when they see a product increment fit for release to the public.

> Grass doesn't grow faster if you pull on it - and software is not delivered faster by setting arbitrary deadlines.

To release frequently, releasing should be a painless process and ideally, there should be mechanisms in place to easily roll back released versions, such as staged releases or feature toggles or staged releases. While the team usually can tell if a feature is of a good enough technical quality, determining whether a feature is ready to be used often requires feedback from the stakeholders and oftentimes, the only way to get this is by releasing the feature to production. The other side of the coin of giving the power to release to the team is that the team has to ensure the [quality of the software](https://dominikberner.ch/software-quality-roadmap/) to be confident that a release will work as expected. This is where the power of shaping the development and testing infrastructure comes into play.

### The power of shaping the development and testing infrastructure

As the teams are expected to take over responsibility for the quality of their software and the release pipeline, they need the power to shape and extend their development and testing infrastructure to their means. This includes the ability to decide what tools to use. It is not uncommon that companies restrict the freedom of choice for tools and services, but it generally pays to have as few restrictions regarding what tool and technology to use as possible. With modern approaches like GitHub actions or Azure DevOps pipelines and similar spinning up a new build and test environment is a matter of minutes and the team should be able to do this on their own, without jumping through bureaucratic hoops to get their work done.
The other side of this empowerment means that the teams have to have the skill for building and maintaining their build and test environments. Granted this can take quite some time and effort to master, but once a team has mastered this skill, adding new quality tools or upgrading existing ones to fit a new need is a matter of hours and not days or weeks, and this is often a huge performance boost. 
It is also crucial that are not just focussing on the continuous integration (CI) aspect of their build and testing infrastructure, but that they also invest in the continuous deployment (CD) part, which creates and delivers the software to the customer. As the empowered team has the power to decide when to release what, they also have to be able to do it "on a whim". By deciding what to release when and having the skill to do so an agile team can greatly reduce the feedback loop and thus increase the speed of delivery, making them truly agile. 

## Conclusion

The main goal of giving the team the power to prioritize the backlog, allocate capacity and work, set the pace for releases, and shape the development and testing infrastructure is to enable the team to make them fast at generating and reacting to customer feedback. If a team can do these four things more autonomously they gain a lot of flexibility in how they work and how they deliver value to the customer, which is a basis for high-performing teams that want to do agile software development. 
There are more aspects of empowering teams to reach peak performance, like being involved in the hiring, shaping overall team composition, and managing the personal growth of their members, but if one wants to start somewhere starting with backlog prioritization, capacity allocation, release planning and shaping the development and testing infrastructure are a good choice to have first. 