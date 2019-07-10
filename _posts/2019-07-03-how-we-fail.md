---
layout: post
title: The joy of failure 
thumbnail: images/failure/thumbnail.png
---

**"We only learn through failure.** This quote attributed to the legendary alpinist [Reinhold Messner](https://en.wikipedia.org/wiki/Reinhold_Messner) holds a lot of truth in it. There is a lot of talk going on about a good failure culture, but is failure in every circumstance a good thing? Probably not. As a software engineer and climber I saw a few fails with sometimes quite drastic consequences. Failure is never the goal but sometimes unavoidable, how can we benefit from it?

Modern companies and organizations often have a culture where failure is not just accepted, but seen as strong opportunities for learning. Being able to fail without dire consequences, be it as an individual, as a team or the organization itself is a great enabler to foster creative, innovative work. Failures can be of a wide range of severity, ranging from "Ups, that could have gone better" to fatal and disastrous consequences. Over the years I found that the kind of failures roughly can be grouped into four categories, orderd by the possible severity.

![Danger meter, describing types of failure]({{ site.baseurl }}/images/failure/dangermeter.png)

## Failing at the sport

At the inconsequetial end is what I call "Failing at the sport". Failing here is usually this is related to **the way we would like to do things**. The intended goal is probably still reachable, but in the way intended. A summit of a mountain might still be reached, but the ascent might not have been "red point"[^1] or by using additional helping equipment. In software engineering we still deliver the feature, but failed to do so by applying TDD or using a certain technology. 

This kind of failure happens very very frequently, and while we still want to be aware of it and learn from it, this should not slow us down in our daily work. Acknowledge the failure, think what could have gone better and move on to the next software feature or the next big rock to climb. 

## Controlled abort

At the next level, "controlled abort", the goal is no longer achievabl and that fact is recognized early on. The keyword here is **controlled** the climber or software engineer is still in control of the situation and it is a conscious decision not to press on forward. The summit might be unattainable for the moment and rappelling down might be the only option left, or one recognizes that a software feature does not bring any value or faces such immense technical difficulties in implementing that it just is not worth pressing on. Here a conscious decision happens to stop, because else the consequences will be nasty. 

Failing this way is migth be frustrating, but it also avoids further damage or injury. It takes some experience to be able to make the decision to turn around and abandoning already done work and it never is easy. Usually this means calling quits, going back to the start and trying again later. 

## Getting away with it

There are circumstances when one finds in a situation that one can no longer control to the full extent. Succeeding to reach ones goals, from here is very unlikely and the severity of the failure is depending to a large extent on luck. These are he situations where one often asks afterwards, "how did we end up there?". In this zone one needs all his experience, skill and some luck to avoid severe damage, be it financial damage or suffering reputation or in the case of climbing severe injury. 

## Catastrophic failure

Catastrophic failure is what we read in the newspapers. These are climbers falling to their deaths or software projects that cost lives, ruin whole companies or fail so spectacularly that the damage is immense. Whatever the effect, once one has been here it is highly possible that one will no longer be able (or allowed) to pursue the same profession. 
Under no circumstances do we want to end up here. No matter what our failure culture is, these kind of failures are so damaging that they have to be avoided, almost at all costs. In this area it is much better to learn from other people - those who by some miracle or sheer will managed to survive such a failure. 
These are the software bugs that caused failures in pace makers, that faked the measured emission at Volkswagen or that caused the recent crashes of Boing 737s. It does not matter if one finds himself in this situation because of ones own fault or from external circumstances - the consequences are the same.   

## Getting control back

The boundaries between the types of failure are of course very fluid and depend on the skill, experience and personality of each individual. An experienced climber might be somewhere in the green zone while a total newbie may be deep in orange and not know forward or backwards.
An interesting part of life happens whenever we find ourselves in the orange segment "Getting away with it". We might suddenly realize that we lost control over our situation. A critical security bug just popped up in production and we do our best to revert that and only later realize that we were lucky that nobody exploited that bug. When this happen our goal dramatically shifts from what it was - reaching the summit, or delivering a feature - to containing or avoiding any further damage and getting back into the yellow zone of "controlled abort". 
Very often the first instinct when we realize that we are no longer in control is one of the three F responses - Fight, Flight or Freeze. Unfortunately these instincts to not help us that much in climbing or software engineering, which both require systematic actions to solve problems. The key to successfully navigate out of the orange zone is to overcome these initial reflexes and start thinking.

Once this initial reflexes are overcome - something I found easier and easier with experience and age - a wonderful thing happens. Because of the dire circumstances one starts to activate all the learned knowledge and skills to get out. Be it digging deep into the obscure knowledge of knots to perform a mountain rescue of a stuck climbing partner or summoning up some arcane technical knowledge to isolate an elusive software bug. Concentration and focus becomes heightened and everything except solving the next small problem to get back into a controlled situation becomes secondary. In these situations communication in (successful) teams becomes very open, brutally honest and to the point.  

In this state of flow the situation is resolved step by step until the situation is getting closer to normal or routine. 

## Getting down and reflecting

After getting down to solid earth from a near-death experience on a mountain is one of the best and horrible feelings ever. Glad to having survived one often only then realizes how close to severe injury or death one came. The same is in software engineering, once all the systems are running again as they should be one often realizes what else could have gone wrong. 

Realizing that and rebuilding the situational awareness on how one ended up in the sticky situation and how one got out of it is they key to the learning experience. How did we react, where were our weaknesses and lack of skills in solving the situation? Who acted in what manner when things spiraled out of control? Did we panic and make things worse or did we freeze in place for an overlong time? 

Reflecting over the experience is what makes us learn from it and avoid similar fate in the future. Having (blameless) postmortems after each emergency is one of the best ways of turning failure into learning. 

## The joy of failure 

And after some time has passed since the gut wrenching experience of utterly despairing in an emergency and then successively getting out of it again. We stand back at the foot of the very mountain that tried to kill you last time. Or you take again that feature from the scrum board that touches the tricky part of the code. Taking a deep breath the journey starts again. First slowly and with utmost care until one reaches the point where things went bad last time. 
Taking a deep breath and collecting ones thoughts one launches again into the crux, carefully avoiding the steps and holds that led us to being stuck. Or calling in the colleague to pair program and refactor through the security relevant spaghetti-code. And gradually one sees that this might just work out - it is still a nasty piece of work to overcome but confidence rises with each line of code and each move on the rock face. Until the whole weight of the situation falls away and the journey becomes smooth again and one reaches the summit - or merges that code into the master. 

This moment of standing at the top of a mountain or watching your feature performing nicely in the code is awesome. Full of pride one looks back at how one had to go through hell to get here. How horrible and how good the experience of overcoming a near-catastrophic failure was. And one knows that reaching this summit would not have been possible before. Knowing that experience these moments of dread and despair provided the necessary learning experience to finally reach the top is incredible. This feeling, this sense of personal masters is the **joy of failure.** 


-- 
This article was inspired by the article ["Staying alive" by John Dill of the Yosemite Search and Rescue ](http://www.bluebison.net/yosar/alive.htm)

[^1]: "red pointing" a climb means that the route was climbed without haning into the rope.
