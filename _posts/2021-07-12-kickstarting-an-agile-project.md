---
layout: post
title: Kickstarting an agile project
description: Agile software development is the way to go when developing a project. But how does one get started with a project or a product? What is needed to get an initial backlog up and running and how much information should one collect to enable all people involved to act empowered? 
thumbnail: images/kickstart-agile-project/thumbnail.jpg
---

**Agile is all fun and games once you're up and running, but how does one start an agile software product development.** There is a lot of information out there about how to run an agile team - Be it with scrum, kanban or any other flavor of a variety of agile processes. But when it comes to how to actually get started most advice is to "just get started". So how does this "just get started" look like? 

While it is tempting to just start hacking away and building prototypes it helps to understand the the basic premises, constraints and the ultimate goal of a product. This is especially important if the software to be developed is not an internal product but is developed for someone else, because we might not yet be intimately familiar with the business domain of a customer. 

I like spend the first few days in a project to create an understanding about the context and goal of the product in order to give the implementing people enough information to foster autonomy and alignment about what we are to do. This does not mean to just gather more or finer requirements, but getting an understanding of "what the product will be about". The context consists of the *[product vision](https://dominikberner.ch/a-good-product-vision/)*, an overview over the *affected stakeholders* and a prioritization of the desired *quality goals*. 

{%include figure.html url="images/kickstart-agile-project/discovery.png" description="A brief time spent discovering what the product will be about followed by agile iterations and frequent deliveries" %}

With this understanding creating a first story map and then distill a very minimal walking skeleton from it often is quite straigth forward. And that is all we need to start coding. I like to stress that this "discovery phase" should be kept short, be confident to leave out a few gaps to be filled later - The sooner we start building the product the sooner we will be able to get real-life feedback. 

## Project vision - why is this worth developing

Start building the context with understanding the vision behind it. This includes not just where do we intend to go, but more importantly, *why* do we want to go there. Finding out what the driving force behind a product is helps a lot later when the backlog needs prioritization. At this point I usually just let my customer talk and then drill down a bit using the [five whys](https://en.wikipedia.org/wiki/Five_whys) technique while taking a copious amount of notes. Switchin the view from the product provider to the product user and ask "why would I want to use that product?" instead of "Why are we building that product". 
Often I get the needed information that way, but if the vision turns out to be to fuzzy investing the time to create a [value proposition canvas](https://vimeo.com/201197034) is usually well invested time. And yes, it happened that to me that a project was already canceled at that point because we found out that nobody really knew why we wanted to build that particular piece of software.

## Stakeholder map - Who is involved

Once we have a rough idea where we want to go with the product let's have a look at who benefits from it. A frequent mistake is to group all stakeholders  "our users" or "our customers". The stakeholders of a product are often a far more heterogeneous and diverse group than initially assumed. 
My tool of choice is to create a stakeholder map where the core users are at the center and the farther out the less direct the interaction and interest in the product is. Splitting them up along the organizational boundaries helps me to identify where their "allegiances" regarding the product lies. 

{%include figure.html url="images/kickstart-agile-project/Stakeholdermap.jpg" description="An example of a stakeholder map" %}

Explicitely identifying the impact the product has on the different stakeholder groups is a first step to ensure we will be able to satisfy the various expectations later. A good rule of thumb is to prioritize anything first that concerns the stakeholders at the center of the map. 

## Quality metrics - What does good mean?

By now we know what we want to do and for who we do it, so the next step is to figure out what makes the product *good*. For this I like to collect the quality attributes that the product will satisfy and prioritize them against each other. Coming from the med-tech industry starting out from the [iso25000 quality attributes](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010) is kind of natural for me. 
Maybe add a few further attributes like scalability or patient safety to it, but keep the number of quality attributes to consider small.

While I consider a full blown [QFD analysis](https://de.wikipedia.org/wiki/Quality_Function_Deployment) an overkill at that stage, creating a QFD-like matrix of pitching the requirements against the prioritized quality attributes is a great enabler for early and fast decisions regarding the software architecture. And again having the quality attributes ranked might give a hint on what to do first in the walking skeleton. 

## Story mapping - building a narrative 

Finally we're talking stories and start building an lean backlog. My method of choice to create a backlog and to define an walking skeleton is [story mapping](https://medium.com/@priyank.it/user-story-mapping-product-backlog-creation-7ea9a54f7f0e).The goal of the story map is to be able to bring the desired features of a product into a narrative and into context with each other. My first goal here is to be able to tell the high-level narrative, and only then start detailing stories. Be rigorous with prioritizing here, anything not strictly necessary gets chucked out or deferred to later. Since we're at the beginning of development the user stories are still very coarse and might lack acceptance criteria. This is fully intentional, [slicing them down](https://dominikberner.ch/the-art-of-slicing/) and creating the full [lean backlog](https://dominikberner.ch/lean-backlog-handling/) will come later.  

{%include figure.html url="images/kickstart-agile-project/story-map.jpg" description="An example of a story map and walking skeleton definition" %}

Double check the stakeholder map against the story map frequently. If some of the core stakeholders are not found on the story map chances are that a vital part of the product is missing or that our stakeholder analysis is off. 

## Defining a walking skeleton - One vertical spike

Almost there! The narrative for the product is set, so let's go lean! Lean and agile development means getting early and frequent feedback. Our first goal is to define the **minimal** set of features needed to determine if the base use case of the product is viable or not. As a rule of thumb, anything that either concerns stakeholders not in the core circle or that concerns special cases gets deferred to later for now. Ask for any story: "can we start with a workaround at the beginning?" Instead of automatically processing the billing for an e-shop as "can we handle it manually over email for the first 100 customers?"

It pays out to be radical here and trim the walking skeleton down to the absolute minimum. No fancy extra work, no edge cases unless they are legally required. For most products that I worked on the walking skeleton could be defined in less than ten stories. Of course they will get split later, but if the core use case cannot be explained in ten sentences or less, chances are that the walking skeleton is still too complicated. 

## ... And off we go

At that point development can begin in earnest. Refine and slice the first story to a usable size and start coding, building the architecture and CI/CD environment. Setting the context from product vision to story map typically takes a few days at most and the first story or spike should be ready within days or at most a few weeks to get early feedback. Bear in mind that the story map is a living document and will change frequently. Compare the narrative with what you learned since the last iteration and adapt. 
The stakeholder map, vision and the quality criteria tend to have a longer live-span but nevertheless take them up frequently. Make these documents visibly in your dailies and do over them in detail every time when you talk the longer future like when building an [agile roadmap](https://dominikberner.ch/Agile-Roadmapping/). 