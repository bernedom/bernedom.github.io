---
layout: post
title: Better estimates by using applied linguistics

---

**Planning poker, magic estimation, T-shirt-size estimation and even the famed \#NoEstiamtes too inaccurate** - But using language itself we can estimate  to up to 50% more accurately. Notice how developers use the same qualifiers for estimating workload over and over again? "It is just a minor bugfix", "This is a huge, complex task", "There is absolutely no way I can put an estimate on this one". Heard this sentences or variations of it in the past? Your best estimations are lying in front of you in plain sight.

The process is simple by applying the formula below. The bonus of it is that in a pinch not all facotrs have to be calculated in to save time

Final Estimate = (Savg + Savg / 4) * Distrust Factor * ((Linguistic multiplier + Facial expression bonus )* Seniority Bonus) 

Savg is your average story size. Normally this is one week or five to seven working days, depending on the unpaid overtime your developers should be doing. Since the tendency in estimation is to downsize, adding 25% in size for the formula provides a better average than just the numerical average. Multiply this by the *distrust factor*. The distrust factor can is easily obtained by counting how many backlog items where completed on time in the past. For each item completed in less than Savg - ususally these are zero - subtract 10% the current distrust factor. For each story that took longer add 20% up to a maximum of a distrust-factor of 4 which is the maximum for any functioning team. Should your distrust-factor be bigger than 4 you should immediately hire an external coach to fix your team and/or software. 

**TODO graph distrust factor**

# Applied lingusitics

Once you have determined the starting point - or starting bias as I like to call it - have your developers discuss the backlog item for 3 minutes. A predetermined person should be the moderator which counts any trigger words described in the table below and takes notes on any body language modification. Be sure to keep track on who said what, as this is important to apply the juniority bonus. To calculate the juniority bonus order your developers by seniority. The most senior developer gets a Seniority Bonus of 4 the most junior member gets a 0.2, interpolate between them to get the number of the other developers. 

|Trigger Word|multiplier|Special Rules|
|---|---|---|---|
|one-liner|0.0001|
|tiny|0.0001|
|just| 0.5| *just* often stacks with other words like "minor", "small"|
|minor|0.5||
|small|0.5||
|basically...|0.75|This items description is too verbose and could be simpler so it is smaller than originally thought
|large|2||
|complicated|2|The description of the item uses too long words. Use shorter sentences and words next time
|complex|2| Remind everyone not to over-engineer things
|multiple modules|2|
|big|3|
|Architecture|3|
|huge|5||
|-ish|-0.2| As in  A largeish feature. This is a modifier for other words, subtract 0.2 from the original value|
|rather| special | This is a modifier for trigger words. If the trigger word associated with it has a value > 1 double it, if the value is smaller than 1 half the time
|bugfix| 1 | this reclassifies an item to a bugfix. Do not change the multiplier, but remind everyone about your zero-bug-policy|
|refactoring| 0 | This reclassifies an item from a story or feature to a refactoring. Developers should do this when they have free time. No estimate needed. Best is to discard the item completely
|I don't get it | *| Bonus! This developer seems to lack understanding of the project vision. Stop the meeting and explain it again|
|I don't know|* | Bonus! This developer seems not to be as competent as needed. Mark this for the annual employee talk
|*silence*| * | Bonus! The developers seem unable to comprehend the backlog item. Pick any estimation you like

# Facial expression and body language

Language is not just conveyed using words. Use the facial-expression lookup-table below to add an appropriate modifier to the linguistic factor calculated above

**TODO Facial expression image**

#Conclusion