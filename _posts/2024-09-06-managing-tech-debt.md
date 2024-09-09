---
layout: post
title:  "A little bit of tech debt has hurt nobody"
description: "Tech debt is a common problem in software development. It can slow down development, increase the risk of bugs, and make the codebase harder to maintain. In this post, we'll explore what tech debt is, why it's important to manage it, and how to prevent it from becoming a problem in the first place."
thumbnail: images/cmake-conan-logo.png
---

**It's OK to have tech debt in your software product.** This statement might sound wrong, but there is some truth to it. While the unchecked build up of tech debt is a common problem for many software teams, if managed properly, having some tech debt in itself is not necessarily a bad thing. 

## What is tech debt?

The term tech debt is one of those fuzzy buzzwords that we software engineers like to throw aorund whenever a feature takes particularly long to develop or when we are not agreeing with the decisions of our product owners or project managers. But what does it actually mean? Tech debt is the accumulation of shortcuts, workarounds and suboptimal or short-sighted design decisions that are made during the development of a software product. These shortcuts are usually taken because of a constraint like time pressure, lack of knowledge an unknown context or somtimes simply because we were too lazy to do it properly and wanted to get over with that #%$%^ feature.

Like financial debt tech debt has to be paid back at some point. The longer you wait the more interest you have to pay. In the case of tech debt, the interest is the time and effort it takes to maintain and extend the software product. The more tech debt you have the more time you have to spend on fixing bugs, refactoring code, and implementing new features.

---- TODO GRAPH debt ---

Since a lot of software engineering is about finding the right compromise to solve a problem, we most likely will always have some tech debt in our codebase. The goal is to keep it at a manageable level and to pay it back in a controlled manner.

## Tech debt in itself is not bad

We engineers hate tech debt. In my careers I have spent countless hours arguing with my collegues about writing clean code, avoiding tech debt and doing things properly. I got mad at product managers that pushed for feature delivery over code quality and I have been working on code bases where the development of new features has ground to a halt because of the amount of tech debt in the codebase. 

Yet over the years I have come to realize that accepting some tech debt is a viable strategy to deliver products faster and to get feedback from users earlier. The key is to manage tech debt properly and to pay it back in a controlled manner. The realisation came to me when talking to people from the finance sector, that dealt with the risks of handing out credits to people. A key factor there is that **it's not the amount of debt that is the problem but the ability of the debtor to pay it back**. And even more, that taking up some debt is a viable strategy to grow for some companies. The same is true for tech debt when developing software products. 

There is the well known iron triangle of software development that states that you can have two of the following three: fast, good, cheap. If you want to deliver a product fast and cheap, you will have to make some compromises on the quality of the code. And typically business tends to have strong bias over fast and cheap over good, while engineers tend to have a strong bias over good over fast and cheap. As the agile manifesto states, delivering working software is the primary measure of progress and the best way to get feedback - and money - from customers is to deliver software to them. That doesn't mean push out crap on an astonishing pace, but it means that you should release on a "good enough" level and iterate on it. 

## Don't let the thugs break you legs

As stated above taking up debt is a viable business strategy to grow - provided the interest can be paid. If paying the interest becomse a financial burden, the debtor will have to pay back the debt or go bankrupt. Sometimes this is done by taking up more debt at a preferential rate, sometimes by selling assets or by restructuring the debt. The same mechanism is true for tech debt. 
The most common interest paid on tech debt is time and effort spent by developers, but it can also be higher cost of infrastructure, slower performance, higher risk of bugs, or even the inability to deliver new features. From all of these the most dangerous is falling into the trap of not being able to deliver new features. This is the point where the product is dead in regard to any improvement. Depending on where in the lifecycle of the product you are, this again can be a viable strategy. 

The key of managing tech debt is to make it visible and that happens best by being transparent about the interest that is paid. Some good metrics here are measuring the number of defects reported and triaged, the bounce rate of new features that come back as "not working" from the customer, and overall the cycle time of new features delivered. Additionally there are of course more technical metrics like cyclomatic complexity, code coverage, the number of open pull requests or the cost of infrastructure for operating the product. 


-- avoid breaking the legs
-- paying the interest (monitor speed and performance of the product)
-- SW dev is a complex undertaking with many known and unknown contstraints
-- reserve time and skills to pay back the debt
-- make it visible
-- Concious tackling of tech debt is a sign of a mature engineering team
-- needs trust that we can go back and fix it if needed

