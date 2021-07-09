---
layout: post
title: Kickstarting an agile project
description: Agile software development is the way to go when developing a project. But how does one get started with a project or a product? What is needed to get an initial backlog up and running and how much information should one collect to enable all people involved to act empowered? 
thumbnail: images/software-is-different/thumbnail.jpg
---

**Agile is all fun and games once you're up and running, but how does one start an agile software product development.** There is a lot of information out there about how to run an agile team - Be it with scrum, kanban or any other flavor of a variety of agile processes. But how does one begin with an agile project? Common advice is to "just get started" and it is good advice, but how does this "just get started" look like? Especially if the software is not developed for ourself but for a customer? 
Start with sitting down and finding out the basic premises, constraints and the ultimate goal of a product with the customer, before you start hacking away. That does not mean gather more or finer requirements, but getting an understanding of "what the product will be about"

![Iterations and discovrey phase]({{site.baseurl}}/images/kickstart-agile-project/discovery.png)

I like spend the first few days in a project to create an understanding about the context and goal of the product in order to give the implementing people enough information to foster autonomy and alignment about what we are to do. The context consists of the *[product vision](https://dominikberner.ch/a-good-product-vision/)*, an overview over the *affected stakeholders* and a prioritization of the desired *quality goals*. 

With this understanding creating a first story map and then distill a very minimal walking skeleton from it often is quite straigth forward. And that is all we need to start coding. 

## Project vision - why is this worth developing

The first thing to do when starting a new software project is to understand the vision behind it. This includes not just where do we intend to go, but more importantly, WHY do we want to go there? Finding out what the driving force behind a product in development is helps a lot later when the backlog needs prioritization. At this point I usually just let my customer talk and then drill down a bit using the [five whys](https://en.wikipedia.org/wiki/Five_whys) technique while taking a copious amount of notes. A big part of that is also to switch the view from the product provider to the product user and as "why would I want to use that product." Most of the time I leave it at that, but if the answers are not conscise enough investing the time to create a [value proposition canvas](https://vimeo.com/201197034) is usually well invested time. 

## Stakeholder map - Who is involved

Once we have a rough idea where we want to go with the product let's have a look at who benefits from it. A frequent mistake is to group all stakeholders  "our users" or "our customers". On a closer look the stakeholders of a product are often a far more heterogenous group than initially assumed. 
My tool of choice is to create a stakeholder map where the core users are at the center and the farther out the less direct the interaction and interest in the product is. Splitting them up along the organisational boundaries additionally helps to identify where their "allegiances" regarding the product lies. 

![Example stakeholder map]({{site.baseurl}}/images/kickstart-agile-project/Stakeholdermap.jpg)

By identifying the impact the product has on which stakeholder group is a first step to ensure that the product will be able to satisfy the various expectations. This separation of concerns helps to prioritze the stories, where a good rule of thumb is to do anything first that concerns the stakeholdes at the center of the map. 

## Quality metrics - What does good meangra

By now we know what we want to do and for who we do it, so the next step is to figure out what makes the product *good*. For this I like to collect the quality attributes that the product should satisfy and prioritize them against each other. Coming from the med-tech industry I often start out from the [iso25000 quality attributes](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010) and then add a few further attributes like scalability or patient saftety to it. 

While I consider a full blown [QFD analysis](https://de.wikipedia.org/wiki/Quality_Function_Deployment) an overkill at that stage, creating a QFD-like matrix of pitching the requirements against the prioritized quality attributes often yields vital information on which features should be done first. As a bonus, having ranked quality attributes is also a great enabler for early and fast decisions regarding the software architecture. 

## Story mapping - building a narrative 

Finally we're talking stories. My method of choice to create a backlog and to define an MVP/Walking skeleton is [story mapping](https://medium.com/@priyank.it/user-story-mapping-product-backlog-creation-7ea9a54f7f0e). Usually the all core stakeholders from our stakeholder map should be reprerented in the story. The goal of the story map is to be able to bring the desired features of a product into a narrative and into context with each other. My first goal here is to be able to tell the high-level narrative, and only then start detailing stories. Be rigorous with prioritizing here, anything not strictly necessary gets chucked out or deferred to later. Since we're at the beginning of development the user stories are still very coarse and might lack acceptance criteria etc. and that is ok for now. Creating the full [lean backlog](https://dominikberner.ch/lean-backlog-handling/) will come later. 

![Example story map and walking skeleton definition]({{site.baseurl}}/images/kickstart-agile-project/story-map.jpg)

## Defining a walking skeleton - One vertical spike

Almost there! Once the narrative for the product is set, let's go lean! Lean and agile development means getting early and frequent feedback. So the goal at the start is to define the **minimal** set of features needed to determine if the base use case of the product is viable or not. As a rule of thumb, anything that either concerns stakeholders not in the core circle or that concerns special cases gets deferred to later for now. Ask for any story: "can we start with a workaround at the beginning?" Instead of automatically processing the billing for an e-shop as "can we handle it manually over email for the first 100 customers?"
It pays out to be radical here and trim the walking skeleton down to the absolute minimum. No fancy extra work, no edge cases unless they are legally required. For most products that I worked on the walking skeleton could be defined in less than ten stories. Of course they will get split later, but if the core use case cannot be explained in ten sentences or less, chances are that the walking skeleton is still too complicated. 

## ... And off we go

At the very end of trimming down to the walking skeleton put the stories into a prioritized order and off you go with developing. Start with refining and splitting the first story a bit and start coding, building the architecture and CI/CD environment if not already done. All of the above typically takes a few days at most and the first story or spike should be ready within days or at most a few weeks to get early feedback. Bear in mind that the story map is a living document and will change frequently and that is ok. Frequently compare the past narrative with what you know now. Although the stakeholder map and the quality criteria tend to have a longer live-span take them up frequently at least every time when you talk about a longer time strech such as an [agile roadmap](https://dominikberner.ch/Agile-Roadmapping/). 

All you need to get an agile product development going is a product vision, an overview over your stakeholders and a story map including the needed quality criteria you're aiming for. 