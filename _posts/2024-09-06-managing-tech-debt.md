---
layout: post
title:  "A little bit of tech debt has hurt nobody"
description: "Tech debt is a common problem in software development. It can slow down development, increase the risk of bugs, and make the codebase harder to maintain. In this post, we'll explore what tech debt is, why it's important to manage it, and how to prevent it from becoming a problem in the first place."
thumbnail: images/cmake-conan-logo.png
---

**It's OK to have tech debt in your software product.** This statement might sound wrong, but there is some truth to it. While the unchecked build up of tech debt is a common problem for many software teams, if managed properly, having some tech debt in itself is not necessarily a bad thing. 

## What is tech debt?

The term tech debt is one of those fuzzy buzzwords that we software engineers like to throw around whenever a feature takes particularly long to develop or when we are not agreeing with the decisions of our product owners or project managers. But what does it actually mean? Tech debt is the accumulation of shortcuts, workarounds and suboptimal or short-sighted design decisions that are made during the development of a software product. These shortcuts are usually taken because of a constraint like time pressure, lack of knowledge an unknown context or sometimes simply because we were too lazy to do it properly and wanted to get over with that #%$%^ feature.

Like financial debt tech debt has to be paid off at some point. In the meantime the interest of the debt has to be paid. In the case of tech debt, the interest is the time and effort it takes to maintain and extend the software product. The more tech debt you have the more time you have to spend on fixing bugs, refactoring code, and implementing new features. 

---- TODO GRAPH debt ---

However we should stop talking about tech debt being a homogeous thing, it is more like a set of micro-debts that are accumulated in the codebase. Some of these micro-debts are more harmful than others, some are more urgent to pay back than others. Some of the debts are like a credit card debt, that has a high interest rate and should be paid back as soon as possible, while others are more like a mortgage that can be paid back over a longer period of time. 

We most likely will always have some tech debt in our codebase. The job of us engineers is to identfy which debts are more like short-time, high-interest debts and which ones are the more long-term debts like mortgages which we might not even pay off fully during the lifetime of the product. Whatever debt we might have in our code base, The goal is to keep it at a manageable level and to pay it back in a controlled manner.

## Tech debt in itself is not bad

We engineers hate tech debt, while the product owners seem to love it. In my careers I have spent countless hours arguing with my colleagues about writing clean code, avoiding tech debt and doing things properly. I had the same discussion with product managers that pushed for feature delivery over code quality. I have worked on ugly code bases that ran products that performed very well in the field and I have been working on code bases where the development of new features has ground to a halt because of the amount of tech debt in the codebase. But most of the time I worked somewhere in between.

Over the years I have come to realize that accepting some tech debt is a viable strategy to get feedback from users earlier and in the end deliver more effectively. The key is to manage tech debt properly and to pay it back in a controlled manner. I had one of the big "AHA" moments, when talking to people from the finance sector, that dealt with the risks of handing out credits to people. A key factor there is that **it's not the amount of debt that is the problem but the ability of the debtor to pay it back in time**. And even more, taking up debt is a viable business strategy to grow for some companies. The same is true for tech debt when developing software products. 

There is the well known iron triangle of software development that states that you can have two of the following three: fast, good, cheap. If you want to deliver a product fast and cheap, you will have to make some compromises on the quality of the code. And typically business tends to have strong bias over fast and cheap over good, while engineers tend to have a strong bias over good over fast and cheap. As the agile manifesto states, delivering working software is the primary measure of progress and the best way to get feedback - and money - from customers is to deliver software to them. That doesn't mean push out crap on an astonishing pace, but it means that you should release on a "good enough" level and iterate on it. 

## Don't let the thugs break you legs

As stated above taking up debt is a viable business strategy to grow - provided the interest can be paid. If paying the interest becomes a financial burden, the debtor will have to pay back the debt or go bankrupt. Sometimes this is done by taking up more or a different debt at a preferential rate, sometimes by selling assets or by restructuring the debt. The same mechanism is true for tech debt. 
The most common interest paid on tech debt is time and effort spent by developers, but it can also be higher cost of infrastructure, slower performance, higher risk of bugs, or even the inability to deliver new features. From all of these the most dangerous is falling into the trap of not being able to deliver new features. This is the point where the product is dead in regard to any improvement. Depending on where in the lifecycle of the product you are, this again can be a viable strategy. 

The key of managing tech debt is to make it visible and that happens best by being transparent about the interest that is paid. Some good metrics here are measuring the number of defects reported and triaged, the bounce rate of new features that come back as "not working" from the customer, and overall the cycle time of new features delivered. Additionally there are of course more technical metrics like cyclomatic complexity, code coverage, the number of open pull requests or the cost of infrastructure for operating the product. These metrics can be useful indicators, but in the end they are not more than just indirect measures. 

## Pay back on a "on demand" basis

As illustrated it is not just unlikely that teams will get rid of all tech debt, it is also usually not on the interest of the business to do so. So the only way to get rid of the burden of tech debt is to make it a concern of the business. It might be tempting for teams to "just set aside 15% of our time to fix tech debt". This is in the essence not a bad thing, but in order to get the 15% (or whatever number a team picked) of time to fix tech debt, the engineers must tie it to a specific interest. This can be a specific feature that will take more time to implement because of tech debt or a specific kind of reoccurring bug that is caused by tech debt. 

One of the signs of the maturity of an engineering team is how successfully and consciously they tackle tech debt. Good teams have this mutual trust between engineers and product managers that they can go back and fix things when needed. They also have the trust from the product managers that if the engineers say "we need to fix this now" they will get the time to do so. However even those teams are often not operating on blind trust, they are usually able to have good, constructive arguments about why tech debt has to be fixed now or why it can wait until the interest becomes a bigger burden. 

So talk about tech debt, make it visible, and make it a concern of the business. But, stop talking about tech debt in engineering terms, when we borrowed the whole methaphor from the finance sector. Make it a topic for a business conversation, not just a technical one. Show up prepared with the interest rates and the risks of not paying back the debt. And most importantly, don't let the thugs break your legs. 
