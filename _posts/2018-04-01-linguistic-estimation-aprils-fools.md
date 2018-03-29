---
layout: post
title: Better estimates by using applied linguistics
thumbnail: images/aprils-fool/aprils-fool.jpg
---

**Planning poker, magic estimation, T-shirt-size estimation and even the famed \#NoEstiamtes are too inaccurate** - But there is a way to estimate to up to 50% more accurately by using a simple formula  based on empirical measures and applied linguistics. Notice how developers use the same qualifiers for estimating workload over and over again? "It is just a minor bugfix", "This is a huge, complex task", "There is absolutely no way I can put an estimate on this one". Heard this sentences or variations of it in the past? Your best estimations are lying in front of you in plain sight. 

## The Power-Formula for fast and exact estimation
**By applying the formula below estimating is made simple again.** 

<a href="https://www.codecogs.com/eqnedit.php?latex=\bg_white&space;E&space;=&space;(S_{avg}&space;*&space;1.25)&space;*&space;F_{Distrust}&space;*&space;\sum_{i=0}^{S_{Team}}(M_{Linguistic_{i}}&space;*&space;B_{Seniority_{i}})&space;/&space;\sum_{i=0}^{S_{Team}}(B_{Seniority_{i}})&space;\\&space;\\&space;E:=&space;Final\:&space;Estimate\\&space;S_{avg}:=&space;Average\:&space;Story\:&space;Size&space;\\&space;F_{Distrust}:=&space;Distrust\:&space;Factor\\&space;S_{Team}:=&space;Team\:&space;Size\\&space;M_{Linguistic}:=Lingustic\:&space;Modifier\\&space;B_{Seniority}:=Senioriy\:&space;Bonus" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\bg_white&space;E&space;=&space;(S_{avg}&space;*&space;1.25)&space;*&space;F_{Distrust}&space;*&space;\sum_{i=0}^{S_{Team}}(M_{Linguistic_{i}}&space;*&space;B_{Seniority_{i}})&space;/&space;\sum_{i=0}^{S_{Team}}(B_{Seniority_{i}})&space;\\&space;\\&space;E:=&space;Final\:&space;Estimate\\&space;S_{avg}:=&space;Average\:&space;Story\:&space;Size&space;\\&space;F_{Distrust}:=&space;Distrust\:&space;Factor\\&space;S_{Team}:=&space;Team\:&space;Size\\&space;M_{Linguistic}:=Lingustic\:&space;Modifier\\&space;B_{Seniority}:=Senioriy\:&space;Bonus" title="E = (S_{avg} * 1.25) * F_{Distrust} * \sum_{i=0}^{S_{Team}}(M_{Linguistic_{i}} * B_{Seniority_{i}}) / \sum_{i=0}^{S_{Team}}(B_{Seniority_{i}}) \\ \\ E:= Final\: Estimate\\ S_{avg}:= Average\: Story\: Size \\ F_{Distrust}:= Distrust\: Factor\\ S_{Team}:= Team\: Size\\ M_{Linguistic}:=Lingustic\: Modifier\\ B_{Seniority}:=Senioriy\: Bonus" /></a>

The first factor to consider is the ```Average Story Size```, This number can be obtained by either calculating from the past data or if this is not leading to the desired result by just using one week as ```Average Story Size```. A week being five to seven working days, depending on the unpaid overtime your developers should be doing. If estimating is not done in time but in story points this works as well, but the starting number is more 8 to 13. Since the tendency in estimation is to downsize, adding 25% in size for the formula provides a better average than just the numerical average.  

The ```Distrust Factor``` is the next critical component and reflects how diligently the teams did estimation in the past. It can is easily obtained by counting how many backlog items where completed on time in the past. Since usually there are zero  - For each story that took longer add 20% up to a maximum of a distrust-factor of 20 which is the maximum for any functioning team. The plot below visualizes the increment to be used. For each story that took less effort than estimated one could subtract 10% from the ```Distrust Factor```. Since usually no story or task is done before its time, this can also be ignored. Should the resulting ```Distrust Factor``` be bigger than 8 you should immediately hire an external coach to fix your team and/or software. 

![Distrust factor over time]({{ site.baseurl }}/images/aprils-fool/distrust-factor.jpg) 

To calculate the ```Seniority Bonus``` order your developers by seniority. The most senior developer gets a Seniority Bonus of 4 the most junior member gets a 0.2, interpolate between them to get the number of the other developers. To get the ```Total Seniority Bonus``` just add all the Seniority Boni for all developers together.

## Trigger words and the Distrust Factor

Once you have determined the starting bias by using the ```Average Story Size``` and the ```Distrust Factor``` have your developers discuss the backlog item for **3 minutes**. It is of utmost importance that this time-box is observed to get correct results. A predetermined person should be the moderator which counts any trigger words described in the table below and keeps track on who said what, as this is important to apply the ```Seniority Bonus```.

|Trigger Word|multiplier|Special Rules|
|---|---|---|---|
|one-liner|0.0001|
|tiny|0.0001|
|simple|0.2||
|just| 0.5| *just* often stacks with other words like "minor", "small"|
|minor|0.5||
|small|0.5||
|basically...| 0.75|This items description is too verbose and could be simpler so it is smaller than originally thought
|large|2||
|complicated|2|The description of the item uses too long words. Use shorter sentences and words next time
|complex|2| Remind everyone not to over-engineer things
|multiple modules|2|
|big|3|
|Architecture|3|
|huge|5||
|impossible|7|| 
|-ish|-0.2| As in  A largeish feature. This is a modifier for other words, subtract 0.2 from the original value|
|rather| special | This is a modifier for trigger words. If the trigger word associated with it has a value > 1 double it, if the value is smaller than 1 half the time
|bugfix| 1 | this reclassifies an item to a bugfix. Do not change the multiplier, but remind everyone about your zero-bug-policy|
|refactoring| 0 | This reclassifies an item from a story or feature to a refactoring. Developers should do this when they have free time. No estimate needed. Best is to discard the item completely
|I don't get it | *| Bonus! This developer seems to lack understanding of the project vision. Stop the meeting and explain it again|
|I don't know|* | Bonus! This developer seems not to be as competent as needed. Mark this for the annual employee talk
|*silence*| * | Bonus! The developer seem unable to comprehend the backlog item. Pick any estimation you like

## An example

Your team consists of four developers, Jack, Amy, Fred and Bob with the following seniority boni:

<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\bg_white&space;\begin{align*}&space;B_{Seniority_{Jack}}&space;=&space;4\\&space;B_{Seniority_{Amy}}&space;=&space;2\\&space;B_{Seniority_{Fred}}&space;=&space;1\\&space;B_{Seniority_{Bob}}&space;=&space;0.2\\&space;\end{align*}&space;\\&space;\\&space;\sum_{i=0}^{S_{Team}}(B_{Seniority_{i}})&space;=&space;7.2" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\bg_white&space;\begin{align*}&space;B_{Seniority_{Jack}}&space;=&space;4\\&space;B_{Seniority_{Amy}}&space;=&space;2\\&space;B_{Seniority_{Fred}}&space;=&space;1\\&space;B_{Seniority_{Bob}}&space;=&space;0.2\\&space;\end{align*}&space;\\&space;\\&space;\sum_{i=0}^{S_{Team}}(B_{Seniority_{i}})&space;=&space;7.2" title="\begin{align*} B_{Seniority_{Jack}} = 4\\ B_{Seniority_{Amy}} = 2\\ B_{Seniority_{Fred}} = 1\\ B_{Seniority_{Bob}} = 0.2\\ \end{align*} \\ \\ \sum_{i=0}^{S_{Team}}(B_{Seniority_{i}}) = 7.2" /></a>

* Jacks statement: "This is a simple (0.2) but huge (5) task."
* Amys statement: "For this we need to touch multiple modules (2) so it will be a big (3) change."
* Fred's statement: "this is a rather (*2) complex (2) task."
* Bob: "So basically (0.75) we just (0.5) need to implemnt this minor (0.5) change over all the modules (2)"

<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\bg_white&space;\begin{align*}&space;0.2&space;*&space;5&space;*&space;B_{S_{Jack}}&space;=&space;4\\&space;2&space;*&space;3&space;*&space;B_{S_{Amy}}&space;=&space;12\\&space;2&space;*&space;2&space;*&space;B_{S_{Fred}}&space;=&space;4&space;\\&space;0.75&space;*&space;0.5&space;*&space;0.5&space;*&space;2&space;*&space;B_{S_{Bob}}&space;=&space;0.375\\&space;\\&space;\sum_{i=0}^{S_{Team}}(M_{Linguistic_{i}}&space;*&space;B_{Seniority})&space;=&space;11.375&space;\end{align*}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\bg_white&space;\begin{align*}&space;0.2&space;*&space;5&space;*&space;B_{S_{Jack}}&space;=&space;4\\&space;2&space;*&space;3&space;*&space;B_{S_{Amy}}&space;=&space;12\\&space;2&space;*&space;2&space;*&space;B_{S_{Fred}}&space;=&space;4&space;\\&space;0.75&space;*&space;0.5&space;*&space;0.5&space;*&space;2&space;*&space;B_{S_{Bob}}&space;=&space;0.375\\&space;\\&space;\sum_{i=0}^{S_{Team}}(M_{Linguistic_{i}}&space;*&space;B_{Seniority})&space;=&space;11.375&space;\end{align*}" title="\begin{align*} 0.2 * 5 * B_{S_{Jack}} = 4\\ 2 * 3 * B_{S_{Amy}} = 12\\ 2 * 2 * B_{S_{Fred}} = 4 \\ 0.75 * 0.5 * 0.5 * 2 * B_{S_{Bob}} = 0.375\\ \\ \sum_{i=0}^{S_{Team}}(M_{Linguistic_{i}} * B_{Seniority}) = 11.375 \end{align*}" /></a>

So Assuming that the team has a Distrust factor of 2.14 and a Standard story size of 5 days we end up with an estimate of 21.1 days for such a story. 

<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\bg_white&space;5&space;*&space;1.25&space;*&space;2.14&space;*&space;(11.375&space;/&space;7.2)&space;=&space;21" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;\bg_white&space;5&space;*&space;1.25&space;*&space;2.14&space;*&space;(11.375&space;/&space;7.2)&space;=&space;21" title="5 * 1.25 * 2.14 * (11.375 / 7.2) = 21" /></a>


## Conclusion

Why bother with lengthy and inaccurate estimation procedures if you can just use this formula. But if this is still not accurate enough, be sure to check out [this video on using facial expression as an even more accurate estimation method](https://www.youtube.com/watch?v=dQw4w9WgXcQ). Also check the date of publishing of this article if you really think of applying this method in your team ;)




