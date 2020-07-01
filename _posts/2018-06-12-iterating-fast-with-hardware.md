---
layout: post
title: How to iterate fast when developing software and hardware together
thumbnail: images/fast-iterations/iterating-with-hardware.jpg
---

**Iterate fast and often to make better products.** This rings true not just when creating software but also when developing it close to or together with hardware. IoT and fully automated Industry 4.0 are currently big topics in the industry, which promotes integrated development between hardware and software even more. Unfortunately, the reality is often that software- and hardware-engineers fail to work effectively together and because of this struggle with creating awesome products. 

There are a lot of machines and products out there that started with good intentions but ended up in quite a mess when delivered. Some devices sport brilliant design and technical excellence in some parts but as a whole just do not feel well thought through. Some devices look good at a first glance but on closer inspection there are things that make the user go "huh?".
The amounts of hacks that I saw software-developers do to work around a shortcoming of the hardware supported is amazing. On the other hand I have seen hardware that was engineered so well that the software failed to use its power to an optimal extent. This hurts me as an engineer, but it also has the potential to make devices more expensive than necessary.
One reason for these shortcomings is that often hardware and software development fail to iterate over the whole product together and are held apart.

The way out of this is to integrate hardware- and software development closely to create and iterate over the full product rather than over the single components. To achieve this kind of full-depth iterations **a combination of setting up teams the right way, fast prototyping and  direct involvement of the customer and/or end-user of a system** is needed. 

## Team setup

There are a lot of companies where there is one hardware team working with one software team working with one electronics team and so on... While this appears to bundle the most skill in one place, a much better alternative is to organize teams so that they contain all skills necessary for developing the project. By team I mean people working together daily on the same product. Collocated if possible, at least in close contact by skype, slack or whatever communication app you prefer. All those engineers work and communicate together and share each other's problems and successes. This has the benefit that people learn the "language" of each field of expertise and see how and why things are different in another domain. The result is a better alignment between the different disciplines and the possibility to help each other out across disciplines. When starting this will need a bit of coaching and team-building to achieve frequent and honest communication inside the team, but often results show up quite fast. 

![Changing your teams from skill oriented to be cross-functional]({{ site.baseurl }}/images/fast-iterations/Team-setup.png) 
 
This setup excels if each team can tackle a different product at the same time, but even if the project is too big to pack everybody into one team this can work. If this is the case multiple teams with clearly defined areas of work are created and extra effort is spent to integrate frequently across teams. How the teams are split is not so much of importance as that they are defined with a common understanding across teams. Having multiple vertical teams work on the same product also requires active facilitation of the the exchange of information across teams. Building communities of practice that regularly exchange the state of work and any brilliant ideas or difficulties they came across. This exchange can be in face-to-face meetings every few weeks or by using slack or a similar chat app. Use whatever form of communication works but make sure that this exchange of information happens frequently. 

## Prototype fast and often

Once the teams are set up to tackle the full depth of a product, The way is open to vertical prototypes and experiments that help to gain knowledge and test any assumptions. The main benefit is quick feedback if an idea works or not. Prototypes can be as simple as a duct-tape and plywood construction or a simple arduino board that mocks the sensors of a big machine. The magic is to find a good balance of doing just enough that valuable information is gained but not to fiddle around too much and waste time. Prototypes should be readily discarded if they no longer help to gain any useful information. In general it is hard to adapt a prototype to become a quality product so discarding them and doing the work properly is often better.

Hardware often has the problem of long lead or delivery times, especially if it is customized. But with today's new technology such as 3D-printing, cheap-to-order PCP boards, Arduinos, Raspberry pis, readily accessible cloud services, the possibility to quickly create something that works "just good enough" are amazing. Each of these technologies can help to quickly get feedback for a specific aspect of a product. 
The new, shiny possibilities are nice but don't forget the many traditional "technologies" available: Bread boards, plywood and duct-tape and the good old soldering iron. Their main benefit is  that they are easy to handle and  they can be used to create something usable in no time at all. Having something tangible helps tremendously in answering questions and verifying assumptions in a real-life manner instead of doing endless "what-if" meetings and design sessions. 

![Think outside the box to get some useful prototyping material]({{ site.baseurl }}/images/fast-iterations/prototyping-material.jpg) 

This kind of hacking can be tremendous fun for a team and it is a great way to build a team in the first place. However a word of warning here is that all this hacking can be so much fun that one can easily miss the focus of actually building the project. So be sure that someone keeps an eye on the focus of the team. Also do not expect the first prototype to answer all questions at once, better start small and build that skill up. Once the skill of prototyping as a team is mastered it becomes a very powerful tool.

## Toe to toe with the customer

Having a cross-functional team that can deliver something tangible fast is great, but there is one piece of the puzzle missing and that is *customer involvement*. The team might have great ideas and fancy visions about a product, but in the end, only the customer and/or end-user of a product can verify it's usefulness. That is where the prototypes that the team built come into play. Do not be afraid of showing a prototype to a customer. Most customers I met can handle trying out a prototype despite many voices saying the opposite. 
There is this balance of making a prototype polished enough so the customer will accept it and focus on the questions that needed answering and giving the impression that development "is almost finished" and with a bit of training and experimenting this balance is easier to strike than one might think. 

It is not just the product that can be demonstrated to the customer; Teams can be demoed to the customer as well. I consider it very important that each team member - or better the whole team - gets the chance to see customers get their hands on a prototype. This establishes a personal connection between the stakeholders and the team which helps you gain trust. Knowing that it is not an anonymous company but real people working on a product increases the confidence of customers.

And last but not least having all experts on site is very handy in case something goes wrong during a demo or the customer asks pointed questions in a specific area. Being able to quickly fix anything and being ready to spend some thoughts and answers on his questions on the spot displays commitment from the team.

![Meeting the customer and talking about your product is great]({{ site.baseurl }}/images/fast-iterations/customer-contact.jpg) 

## And now? 

Of course the recipe of creating a good cross-functional team, fast prototyping and getting toe to toe with the customer is easier said than done. Getting any of these three parts to be carried out in the daily life of a company can be quite a task and might take years to be instilled in all minds connected with a project.
But as often in the world of agile getting under way into this direction is a gain in itself and helps breaking down old and too rigid processes and structures. 