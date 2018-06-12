---
layout: post
title: How to iterate fast when developing close to the hardware
thumbnail: images/fast-iterations/iterating-with-hardware.jpg
---

**Iterate fast and often to make better products.** A sentence that rings true not just when developing software but also when working close or together with hardware development. With the advento if the IoT and fully automated Industry 4.0 integrated development between hardware and software becomes more prominent again. But reality is often that software development and hardware development fail to work effectively together and because of this struggle with creating good products. 

There are a lot of machines and products out there that started with good intentions and even sport brilliant design and technical excellence in some parts but as a whole just do not feel well thought through. The amounts of hacks that software-developers have to do to work around a shortcoming of the hardwaee supported is sometimes amazing. Or on the other hand hardware that is engineered so well that the software fails to use its power is also something I encounter frequently. The reason is that often hardware and software development fail to iterate over the whole product together, and are held apart while developing the product.  This is bad, because every iteration on the full product will increase the quality and purposefulness of a product. Every time the whole product is assembled together a huge oportunity to learn its shortcomings and where a solution excels in quality. 

This kind of full-depth iterations can be achieved by a combintation of setting up teams the right way, prototyping fast and often and by directly involving the customer and/or end-user of your system. 

## Team setup

I often encounter companies where there is one hardware team working with one software team working with one electronics team and so on... While this appears to bundle the most skill in one place a much better alternative is to organize teams so that they contain all skills necessary for developing the project. And by team I mean people working together daily on the same product. collocated if possible, at least in close contact by skype, slack or whatever communication app you prefer. All those engineers should work and communicate together and share each others problems and successes. This has the benefit that people learn the "language" of each others special field and see how and why things are different in each others domain. This creates an alignment between the different disciplines but also let people help each other out. Of course it is important that communication inside the team is frequent and honest. Aliging everybody to the common goal of the product is a key element to succesful teamwork. 


![Changing your teams from skill oriented to be crossfunctional]({{ site.baseurl }}/images/fast-iterations/Team-setup.png) 

 
If the project is too big to pack everybody into one team make multiple teams with clearly defined areas of work. How these areas are defined is not so much important as that they are defined with a commopn understanding across teams. Having multiple vertical teams work on the same product also requires that you actively facilitate the exchange of information across the teams. I had very good experience with building co called communities of practice that where required to regularly exchange the state of work and any brilliant ideas or difficulties they came across. This exchange can be in face to face meetins avery few weeks or by using slack or a similar chat app. Use whatever form of communication works but make sure that this excahgne of information happens frequently. 

## Prototype fast and often

Once the teams are set up to tackle the full product this opens the way to do valuable prototypes and experiments that help you gain knowledge, test any assumptions and last but not least also give you quick feedback wheter any idea works or not. Prototypes can be as simple as a duct-tape and plywood construction or a simple arduino board that mocks the sensor input of a big machine. The magic is to find a good balance of doing just enough that you gain information but not too much so not to wast time. Also prototypes should be readily discarded if they no longer help to gain any useful information. In general it is better to re do the work done for a prorotype for the real product than to adapt any hack from a prototype to fit into the final product. 

With todays new technology such as 3D-printing, cheap-to-order PCP boards, Arduinos, Rasperry pies, readily accessible cloud services and so on the possibility to quickly create something that works just good enough are amazing. But of course there are many traditional "technologies" available, such as glue, cardboard and duct-tape. By using these things one can quickly verify a lot of questions in a real-life manner instead of doing endless "what-if" meetings and design seessions. 

![Think outside the box to get some useful protoyping material]({{ site.baseurl }}/images/fast-iterations/prototyping-material.jpg) 

Not to forget that this kind of hacking can be tremendous fun for a team. One word of warning here is that all this hacking can be so much fun that one can easily miss the focus of actually building the project, so it helps if there is someone to keep an eye on it. Prototyping takes a bit of practice but once a team has mastered this skill it becomes very powerful.

## Customer involvement

Having a crossfunctional team that can deliver something tangible fast is great, but there is one piece of the puzzle missing and that is customer involvement. Getting close to the customer is a great way to verify new ideas and make sure that the development still goes into the right direction. Here the prototypes that the team built can help a lot. Despite what is often claimed, most customers can handle trying out a prototype. There is this balance of making a prototype polished enough so the customer will accept it and focus on the questions that needed answering and giving the impression that development "is almost finished". Finding this balance needs a bit of training, but usually this balance is easier to strike than one might think. 

But it's not just the product that can be demonstrated to the customer, equally important is that the whole team is present when the customer can get his or her hands on a prototype. Having the whole team there establishes a personal connection between the stakeholders and the team which helps you gain trust because it's no longer an anonymous company working on a product but real people. Also having all experts on site is very handy in case something goes wrong during a demo or the customer asks pointed questions in a specific area. Being able to quickly fix anything and being ready to spend some thoughts and answers on his questions right away really display commitment from the team.

![Meeting the customer and talking about your product is great]({{ site.baseurl }}/images/fast-iterations/customer-contact.jpg) 

## And now? 

Of course the recipe of creating a good crossffunctional team, prototyping easy and often and getting toe to toe with the customer is easier said than done. Gettgin any of these three parts to be carried out in the daily life of a company can be a huge task that takes years to be instilled in all minds connected with a project. But as often in the world of agile getting under way into this direction is a gain in itself and helps breaking down old and too rigid processes and structures. 
While I preferr to tackle changing this working mode in the order I descirbed, team first, prototype second and close customer collaboration 3rd, they are more or less independent and can be tackled in whatever order seems fit. 