---
layout: post
title: Better estimates by using applied linguistics

---

**Planning poker, magic estimation, T-shirt-size estimation and even the famed \#NoEstiamtes too inaccurate** - But using language itself we can estimate  to up to 50% more accurately. Notice how developers use the same qualifiers for estimating workload over and over again? "It is just a minor bugfix", "This is a huge, complex task", "There is absolutely no way I can put an estimate on this one". Heard this sentences or variations of it in the past? Your best estimations are lying in front of you in plain sight.

The process es simplem by applying the formula below. The bonus of it is that in a pinch not all facotrs have to be calculated in to save time

Final Estimate = (Savg + Savg / 4) * Distrust Factor * (Linguistic multiplier * Seniority Bonus) 

Savg is your average story size. Since the tendency in estimation is to downsize, adding 25% in size for the formula provides a better average than just 
the numerical average. Multiply this by the *distrust factor*. The distrust factor can is easily obtained by counting how many backlog items where completed on time in the past. For each item completed in less than the time estimated - ususally these are zero - subtract 10% the current distrust factor. For each story that took longer add 20% up to a maximum of a distrust-factor of 4 which is the maximum for any functioning team. Should your distrust-factor be bigger than 4 you should immediately hire an external coach to fix your team and/or software. 

**TODO graph distrust factor**

# Applied lingusitics

Once you have determined the starting point - or starting bias as I like to call it - have your developers discuss the backlog item for 3 minutes. A predetermined person should be the moderator which counts any trigger words described in the table below and takes notes on any body language modificators. Be sure to keep track on who said what, as this is important to apply the juniority bonus. To calculate the juniority bonus order your developers by seniority. The most senior developer gets a Seniority Bonus of 4 the most junior member gets a 0.2, interpolate between them to get the number of the other developers. 

|Trigger Word|multiplier|Example|Comments|
|---|---|---|---|
|minor|0.5|This is a minor bugfix ||
|small|0.5|A small improvement||
|large|2| this is large|2|
|-ish|-0.2| A largeish feature| This is a modifier for other words, subract 0.2 from the orgiginal value|
|huge|5| A huge refactoring is need for that| 

|just| 0.5|This is *just* minor a bug. | *just* often stacks with other words like "minor", "small"|
