---
layout: post
title: "A Little Bit of Tech Debt Has Hurt Nobody"
description: "Tech debt is a common problem in software development. It can slow down development, increase the risk of bugs, and make the codebase harder to maintain. In this post, we'll explore what tech debt is, why it's important to manage, and how to prevent it from becoming a problem in the first place."
thumbnail: images/cmake-conan-logo.png
---

**It's OK to have tech debt in your software product.** This statement might sound counterintuitive, but there's some truth to it. While the unchecked buildup of tech debt is a common problem for many software teams, if managed properly, having some tech debt isn't necessarily a bad thing. 

## What Is Tech Debt?

The term *tech debt* is one of those fuzzy buzzwords we software engineers like to throw around whenever a feature takes longer than expected to develop or when we disagree with the decisions of our product owners or project managers. But what does it actually mean? Tech debt refers to the accumulation of shortcuts, workarounds, and suboptimal or short-sighted design decisions made during software development. These shortcuts are usually taken because of constraints like time pressure, lack of knowledge, an unknown context, or sometimes, simply because we were too lazy to do it properly and just wanted to be done with that #%$%^ feature.

Like financial debt, tech debt must be paid off at some point. Meanwhile, the interest must be paid. In the case of tech debt, the interest is the time and effort it takes to maintain and extend the software product. The more tech debt you accumulate, the more time you’ll need to spend fixing bugs, refactoring code, and implementing new features. 

--- **TODO GRAPH DEBT** ---

However, we should stop talking about tech debt as if it's a homogeneous concept. It's more like a set of micro-debts accumulated throughout the codebase. Some of these micro-debts are more harmful than others; some are more urgent to pay off, while others can be left for longer. Some debts are like high-interest credit card debts that should be paid off as soon as possible, while others are more like mortgages that can be paid back over a longer period.

We'll likely always have some level of tech debt in our codebase. The job of engineers is to identify which debts are short-term, high-interest debts and which ones are long-term debts, like mortgages, which might never be fully paid off during the product's lifetime. Whatever debt we carry, the goal is to keep it at a manageable level and pay it back in a controlled manner.

## Tech Debt Isn’t Inherently Bad

As engineers, we hate tech debt, while product owners seem to love it. Throughout my career, I’ve spent countless hours arguing with colleagues about writing clean code, avoiding tech debt, and doing things properly. I’ve had the same discussions with product managers who pushed for feature delivery over code quality. I’ve worked on ugly codebases that powered products performing excellently in the field, and I’ve worked on codebases where feature development ground to a halt because of overwhelming tech debt. Most of the time, though, I’ve worked somewhere in between.

Over the years, I’ve realized that accepting some tech debt is a viable strategy to get user feedback earlier and, ultimately, deliver more effectively. The key is managing tech debt properly and paying it back in a controlled way. One of my big "AHA" moments came when talking to people in the finance sector who deal with the risks of lending. A key factor is that **it's not the amount of debt that’s the problem, but the ability of the debtor to pay it back on time**. Taking on debt is even a viable business strategy for growth in some cases. The same applies to tech debt in software development.

There’s the well-known iron triangle of software development that states you can have two of the following three: fast, good, or cheap. If you want to deliver a product fast and cheap, you’ll have to compromise on the quality of the code. Business typically leans toward fast and cheap, while engineers lean toward good. As the Agile Manifesto states, delivering working software is the primary measure of progress, and the best way to get feedback—and money—from customers is by delivering software to them. This doesn’t mean pushing out poorly made code at breakneck speed, but rather releasing at a "good enough" level and iterating from there.

## Don't Let the Thugs Break Your Legs

As mentioned earlier, taking on debt is a viable business strategy—as long as you can pay the interest. When paying the interest becomes a burden, the debtor will need to pay off the debt or face bankruptcy. This can sometimes be done by taking on more or different debt at a better rate, selling assets, or restructuring the debt. The same principle applies to tech debt.

The most common interest paid on tech debt is the time and effort spent by developers, but it can also include higher infrastructure costs, slower performance, increased risk of bugs, or even the inability to deliver new features. Of these, the most dangerous is falling into the trap of being unable to deliver new features. At this point, the product is essentially dead in terms of improvements. Depending on where the product is in its lifecycle, this can be a viable strategy.

The key to managing tech debt is making it visible, which is best achieved by being transparent about the interest being paid. Useful metrics include tracking the number of defects reported and triaged, the bounce rate of new features coming back as "not working" from customers, and the cycle time for delivering new features. Additionally, technical metrics like cyclomatic complexity, code coverage, open pull requests, or infrastructure costs can be useful indicators. However, these are just indirect measures.

## Pay It Back on an "On-Demand" Basis

It’s not only unlikely that teams will eliminate all tech debt, but it’s also usually not in the business’s interest to do so. Therefore, the only way to reduce the burden of tech debt is to make it a business concern. Teams might be tempted to "set aside 15% of their time to fix tech debt," and while this is not a bad idea, it’s crucial that engineers tie this time to a specific interest. This could be a feature that will take longer to implement because of tech debt, or a recurring bug caused by tech debt.

A sign of a mature engineering team is how consciously they handle tech debt. Good teams have mutual trust between engineers and product managers, allowing them to go back and fix things when needed. Product managers trust that when engineers say, "we need to fix this now," they’ll get the time to do so. However, even in these teams, the decision is rarely based on blind trust. They usually have well-reasoned, constructive discussions about why tech debt must be addressed immediately or why it can wait until the interest becomes a bigger burden.

So, talk about tech debt, make it visible, and make it a business concern. Stop discussing tech debt in purely engineering terms—after all, we borrowed the metaphor from finance. Make it a topic for business conversations, not just technical ones. Be prepared with interest rates and the risks of not paying off the debt. And most importantly, don’t let the thugs break your legs.
