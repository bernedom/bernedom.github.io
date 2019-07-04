---
layout: post
title: How we fail 
thumbnail: images/failure/thumbnail.png
---

**"We only learn through failure.** This quote attributed to the legendary alpinist [Reinhold Messner](https://en.wikipedia.org/wiki/Reinhold_Messner) holds a lot of truth in it. Modern companies and organisations often have a culture where failure is not just accepted, but seen as strong opportunities for learning. Being able to fail without dire consequences, be it for the individual, teams or the organisation itself is a great enabler to foster creative, innovative work. 

But is failure in every circumstance a good thing? Probably not. As a software engineer and climber I saw a few fails with sometimes quite drastic consequences. Which led me to analyze a bit closer on how and where we fail in what kind. Failures can be of a wide range of severity, ranging from "Oups, that could have gone better" to fatal and disastrous consequences. This severity can be split into four kinds of failure


![Danger meter, describing types of failure]({{ site.baseurl }}/images/failure/dangermeter.png)

## Failing at the sport

This is the most common and least severe kind of failure. Usually this is related to **the way we would like to do things**. We probably still reach our goal, but not in the way that we intended. In climbing this might be that we reached the summit, but we could not free climb it and had to "cheat" by hanging in the rope a few time. In software engineering we still deliver the feature, but failed to do so by applying TDD or using a certain technology. 

This kind of failure happens very very frequently, and while we still want to be aware of it and learn from it, this should not slow us down in our daily work. Acknowledge the failure, think what could have gone better and move on to the next software feature or the next big rock to climb. 

## Controlled abort

The next level of failure is what I call "controlled abort". This is the part where you recognize that a goal is not achievable from the current situation. The keyword here is **controlled** the climber or software engineer is still in control of the situation and it is a concious decision not to press on forward. The summit might be unnatainable for the moment and rappelling down might be the only option left, or one recognizes that a software feature does not bring any value or faces such immense technical difficulties in implementing that it just is not worth pressing on, because else the consequences will be nasty. 

Failing this way is mostly avoiding further damage or injury. 

## Getting away with it

There are circumstances when one finds in a situation that one can no longer control to the full extent. Succeeding to reach ones goals, from here is very unlikely and the severity of the failure is depending to a large extent on luck. These are he situations where one often asks afterwards, "how did we end up there?". In this zone one needs all his experience, skill and some luck to avoid severe damage, be it fincancial damage or suffering reputation or in the case of climbing severe injury. 

## Catastrophic failure

Catastrophic failure is what we read in the newspapers. These are climbers falling to their deaths or software projects that cost lives, ruin whole companies or fail so spectacularily that the damage is immense. Whatever the effect, once one has been here it is highly possible that one will no longer be able (or allowed) to pursue the same profession. 
Under no circumstances do we want to end up here. No matter what our failure culture is, these kind of failures are so damaging that they have to be avoided, almost at all costs. In this area it is much better to learn from other people - those who by some miracle or sheer will managed to survive such a failure. 
These are the software bugs that caused failures in pace makers, that faked the measured emission at Volkswagen or that caused the recent crashes of Boing 737s. It does not matter if one finds himself in this situation because of ones own fault or from external circumstances - the consequences are the same.   

## The joy of failure

The boundaries between the segments of the danger meter are of course very fluid and depend on the skill, experience and personality of each individual. An interesting part of life happens whenever we find ourseves in the orange segment "Getting away with it". We might suddenly realize that we lost - at least partially - control over our situation. A critical security bug just popped up in production and we do our best to revert that and only later realize that we were lucky that nobody exploited that bug. 
Very often the first instinct when we realize that we are no longer in control is one of the three F repsonses - Fight, Flight or Freeze.    

-- 
This article was inspired by the article ["Staying alive" by John Dill of the Yosemite Search and Resce ](http://www.bluebison.net/yosar/alive.htm)