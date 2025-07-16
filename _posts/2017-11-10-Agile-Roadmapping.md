---
layout: post
title: Planning ahead the agile way 
image: /images/agile-roadmapping/thumbnail.jpg
---

**Agile is shortsighted! In scrum you are only interested in what's going on in the next sprint! Kanban focusses only on what's next! Long term planning is not agile!** Sounds familiar? The gap between short term (sprint-)planning and long term roadmaps is an often discussed focus point in the world of agile and an often cited reason why *"our company cannot do agile"*. 
And it is true. A lot of litarature advertises mainly the fast reaction time and short iteration cycles that agile methods give us, especially if applied to software development. But it is also true, that a lot of businesses are operating on longer cycles than single sprints. Yearly budget allocations, fixed cost projects and hard deadlines are real and existing challenges in the industry. Leaving aside if this is how it should be or not, those practices are still alive and kicking in a lot of industrial sectors such as the medical or machine industry. 

So how do we as software deliverers go about catering to these long, slow cycles? We are frequently asked about roadmaps, deadlines, milestones and so on and often enough we are tempted to say, *"we don't want to know, we're doing agile"*. Often we really don't know in the sense of *"we are not sure if it is going to work out in the way we think right now"*, but often enough we have tons of ideas and visions where a project could go. Sometimes we can even predict things down to single features. After all this is part of our professional experience and training. But instead of making that information transparent and visible to the customer and ourself, we hide it behind * "agile doesn't do long-term planning"*. 

And that is wrong. Agile should do and advertise long term planning, it just should do it in the - surprise! - agile way. Long term plans should be living documents that get adapted as we learn more about the project. They should also be coarser than our daily work. I usually pick a frequency for doing the roadmapping-sessions with the team that is at least twice the frequency of the time horizon of the roadmap. The goal of such roadmapping-sessions is not primarily to generate content - that should happen all the time -, but to provide a well defined snapshot of what at the time is seen as the most likely direction a piece of software could take. Word of warning here, if done for the first time this can be time consuming, but it gets better with each roadmap iteration. 

![Timetable illustrating the size of roadmap and roadmapping sessions]({{ site.baseurl }}/images/agile-roadmapping/roadmapping_session_timetable.jpg)

# Building content for a roadmap 

My preferred approach to building up or refining a roadmap is to first focus on gathering content in a top down manner and do any estimation and sequenstial ordering later. A very important and often forgotten step is the throwing away of old and unimportant ideas and roadmap items.  
If there is an existing roadmap to refine, I start with the team and the PO by throwing out everything which we no longer see as important or as unfeasible at the moment. Really throw it away, make it invisible on the roadmap. Just moving it to a "to be done later" section will clutter up things very fast. If things are really important they will pop up again. By completely throwing away unripe ideas we reward just-in-time planning, because the less you invested in one of these items the easier it is to throw away. A sure sign of a mature team and a realistic roadmap is that there is no fuss about cutting away anything that is no longer worth the effort. 
After pruning I have the team selecting a few overarching themes or visions on which they want to focus in the future. Experience shows that it is better here to focus on a broad understanding first than to work down individual topics. Once these topcis are selected and grouped have your team work downwards by splitting the issues into smaller and smaller packages until the team thinks that the majority of them fit inside the selected period. As this can become time consuming I encourage the teams to do early pruning again. My tool of choice is to do this with sticky notes on a whiteboard or paper and digitalize once the snapshot is done. 

![Roadmapping tree without any estimation]({{ site.baseurl }}/images/agile-roadmapping/tree_without_estimation.jpg) 

The next step is to assign priorities to the leaves of the tree. As opposed to the backlog these should not be unique priorites but simplified ones like (high, medium, low) alternatively ask the PO or any stakeholders to help assigning a value or impact to the items. Then have the developers do an relative t-shirt size estimation (S, M, L) of the leaves. This usually results in a list of small, high-priorty issues to put on a roadmap. Then the team and the PO together pick few of the issues to put on a roadmap. It may take a few iterations over the roadmap until a team has found a good granularity for them. 
Now is also a good time to get the team to agree on how to proceeed once all the small, urgent issues are done. Pick the small, medium ones next or even break down the urgent, medium-sized ones into new smaller chunks?

![Roadmapping tree incldung size and priorty estimation]({{ site.baseurl }}/images/agile-roadmapping/tree_including_estimation.jpg)

# From roadmap to backlog 

Once the team is happy with the content of the tree, take leaf-issues and put them in a proposed order of execution. It may help to keep some levels of hierarchy visible on the roadmap to show how big the context swtiches between individual items are. This is often a visualisation to be shown outside the team and to do more strategic planning on.

![Roadmap ordered by order of execution]({{ site.baseurl }}/images/agile-roadmapping/Flow_visualisation_of_roadmap.jpg)

What remains is to break the roadmap items down into workable and ready stories. Simply take them as they are and put them at the bottom of the backlog to incorporate the items into the regular backlog refinement process. When breaking down the issues it helps to retain the traceability to the roadmap items, so the progress or deviation from the roadmap can be traced. This helps as well with pruning items that do not make the cut. As a rule of thumb I try not to keep any issue that has not made it into the roadmap for longer than one roadmap cycle. If the topics are really urgent they make it to the roadmap or else they are not that important. 

![The product backlog containig the roadmap items]({{ site.baseurl }}/images/agile-roadmapping/backlog-including-roadmap-items.jpg)

# Using the roadmap in the daily work 

All that thinking work should of course not just go to a drawer but be used in the daily work. I like to print out the roadmap and put it up next to the agile wall, so the team can refer to it easily during the daily stand ups. Some teams I know even pin done stories to the respective roadmap item to sew how closely we follow our plan and to facilitate discussions about deviations. Deviations are of course not bad at all, but it helps to visualize them and conscious of when, why and how they happen. The information gained like this then can also be taken to the sprint planning and after a few iterations serves as a good indicator for the next roadmapping period. 