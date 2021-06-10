---
layout: post
title: Kickstarting an agile project
description: Agile software development is the way to go when developing a project. But how does one get started with a project or a product? What is needed to get an initial backlog up and running and how much information should one collect to enable all people involved to act empowered? 
thumbnail: images/software-is-different/thumbnail.jpg
---

**Agile is all fun and games when the team is up and running, but how does one start an agile software product development.** The term "agile software development" is around for 15+ years by now and there is lots of information about how to run a team and iterate over the backlog. Be it with scrum, kanban or any other flavor of an agile process. But how does one begin with an agile project even when the teams and the organization is already geared towards agile and knows how to do "agile", what first steps to take to deliver a running start? Over the years I found that spending a few days figuring out the basic premises, constraints and the ultimate goal of a product are time well spent and are a great enabler for a team to create an awesome product. 

!!! TODO GRAFIK DISCOVERY PHASE !!!

The whole goal of these first days is to create an understanding about the context and goal of the product in order to give the implementing people enough information to foster autonomy and alignment about what we are to do. The context consists of the product vision, an overview over the affected stakeholder groups and a prioritization of the desired quality goals. 

From this information it is often comparatively easy to create a first story map and then distill a very minimal walking skeleton from it, which is all we need to start coding. Usually I get all this information from spending one or two days with the project sponsors. 

## Project vision - why is this worth developing

The first thing to understand when starting a new software project or taking over an existing one is the vision behind it. This includes not just where do we intend to go, but more importantly, WHY do we want to go there? Finding out what the driving force behind a product in development is helps a lot later when the backlog needs prioritization. At this point I usually just let my customer talk and then drill down a bit using the [five why](https://en.wikipedia.org/wiki/Five_whys) technique while taking a copious amount of notes. A big part of that is also to switch the view from the product provider to the product user and as "why would I want to use that product." Most of the time I leave it at that, but if the answers are not conscise enough investing the time to create a [value proposition canvas](https://vimeo.com/201197034) is usually well invested time. 

## Stakeholder map - Who is involved

Ok, so we have a rough idea where we want to go with the product, but let's have a look at who benefits from the project. Very often I see the stakeholders just grouped together als "our users" or "our customers" and it is rarely that easy. Looking closely the stakeholders are often a far more heterogenous group than initially assumed. Listing all the stakeholders is one part but the far more intersting part is to classify them by how immediate they are affect or interact with the product and grouping by the different organizations or groups they belong to. 
My tool of choice is to create a stakeholder map where the core users are at the center and the farther out the less direct the interaction and interest in the product is. 
By identifying the impact the product has on which stakeholder group and where their "allegiance" lies is a first step to ensure that the product will be able to satisfy the various expectations. It also helps later to prioritize what to do first. A good rule of thumb is to do anything that concerns the directly involved parties first and then work outwards in the circle. 

[IMAGE stakeholder map]

## Quality metrics - What does good mean

Once we know for who we create the product, let's figure out what makes the product good. For this I like to collect the quality attributes that the product should satisfy and prioritize them against each other. Coming from the med-tech industry I often start out from the [iso25000 quality attributes](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010) but depending on the situation I do not limit myself to these attributes i.e by adding scalability or patient/operator saftety to it. 
If there are already requirements formulated I then pitch the requirements against the quality attributes to figure out If the assumption about the importance of the quality attributes matches the formulated requirements. While I consider a full blown [QFD analysis](https://de.wikipedia.org/wiki/Quality_Function_Deployment) an overkill at that stage, creating a QFD-like matrix of pitching the requirements against the prioritized quality attributes often yields vital information on which features should be done first. Having the quality metrics prioritized against each other comes in very handy again later when the software architecture is designed. 

## Story mapping - building a narrative 

Finally we're talking stories. My method of choice to create a backlog and to define an MVP/Walking skeleton is [story mapping](https://medium.com/@priyank.it/user-story-mapping-product-backlog-creation-7ea9a54f7f0e). Usually the all core stakeholders from our stakeholder map should be reprerented in the story. The goal of the story map is to be able to bring the desired features of a product into a narrative and into context with each other. Story mapping is also done not just once but many, many times during the product lifecycle. My first goal here is to be able to tell the high-level narrative and only then start formulating stories. While formulating a first prioritization already takes place. Anything not strictly necessary, including convenience features, to make the product function either gets chucked out or deferred to later. Since we're at the beginning of development the user stories are still very coarse and lack acceptance criteria etc. and that is ok for now. Creating the [lean backlog](https://dominikberner.ch/lean-backlog-handling/) will come later. Right now the goal is to define the **minimal** set of features needed to determine if the base use case is viable or not. Anything that either concerns stakeholders not in the core circle or that concerns special cases gets deferred to later  for now.



1. Project vision - Why does our client (or we) want to create that product?  What is the deeper motivation? what is the business case? How does it fit with the strategy of the organization? 5 Whys, "Just let them talk"
2. Stakeholders who is involved - Stakeholder map, get finer than "user", "customer" etc. identify core processes
3. Quality attributes - How do we define "quality"? Which attributes are the most important for product success? On which can we not clamp down without compromising the project. Where do we spend extra effort? 
4. Story mapping over the whole base use case up until decommissionig
5. Walking skeleton, what do we need to validate that this is basically working
6. GO!
