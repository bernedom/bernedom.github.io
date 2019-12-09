---
layout: post
title: The joy of failure 
thumbnail: images/failure/thumbnail.png
---

**"We only learn through failure.** This quote attributed to the legendary alpinist [Reinhold Messner](https://en.wikipedia.org/wiki/Reinhold_Messner) holds a lot of truth in it. There is a lot of talk going on about a good failure culture, but is failure in every circumstance a good thing? Probably not. As a software engineer and climber I saw a few fails with sometimes quite drastic consequences. Failure is never the goal but sometimes unavoidable, so how can individuals, teams and companies benefit from it? 

When climbing failure is usually very apparent and more immediate than when working as a software developer or other office job. If a summit is not reached or one falls a few times during sports climbing one feels the failure. In software engineering failure is usually more abstract but nevertheless very present. Mistakes can have dire consequences as well, just think of defective software for an airplane. 

But is every mistake important and a valuable lesson? Where can we embrace failure and where do we have zero tolerance? Years of climbing and software engineering made me categorize failures into four categories. 

![Danger meter, describing types of failure]({{ site.baseurl }}/images/failure/dangermeter.png)

## Failing at the sport

At the inconsequential end is what I call "Failing at the sport". Failing here is usually this is related to **the way we would like to do things**. The intended goal is probably still reachable, but not in the way intended. A summit of a mountain might still be reached, but the ascent might not have been "red point"[^1] or by using additional helping equipment. In software engineering we still deliver the feature, but failed to do so by applying TDD or using a certain technology. 

This kind of failure happens very very frequently, and while we still want to be aware of it and learn from it, this should not slow us down in our daily work. Acknowledge the failure, think what could have gone better and move on to the next software feature or the next big rock to climb. 

## Controlled abort

At the next level, "controlled abort", the goal is no longer achievable and that fact is recognized. The keyword here is **controlled** the climber or software engineer is still in control of the situation and it is a conscious decision not to press on forward. Maybe the climb is just too difficult and the summit is be unattainable, so rappelling down becomes the only option left. Or one recognizes that a software feature does not bring any value or faces such immense technical difficulties in implementing that it just is not worth pressing on. **Here a conscious decision happens to stop, because else the consequences will be nasty.**

Failing this way is often very frustrating, but it also avoids damage or injury. It takes some experience an will to make the decision to turn around and abandon the already done effort. That's never easy.

## Getting away with it

If one misses the exit point for a controlled abort the situation becomes dangerous. Suddenly there is a situation one the mountain where one is out of control and the possibility of broken bones or even death becomes very real. Or one realizes that a software-update with a critical security flaw has reached production. 

Succeeding to reach ones goals, from here is very unlikely and the severity of the failure is depending to a large extent on luck. These are he situations where one often asks afterwards, "how did we end up there?". In this zone one needs all his experience, skill and some luck to avoid severe damage, be it financial damage or suffering reputation or in the case of climbing severe injury. 

## Catastrophic failure

Catastrophic failure is what we read in the newspapers. The question here is no longer if someone gets hurt, but only how severe the damage is. If one ever was in such a situation might never climb again or think twice if one still wants to pursue a career in software engineering. Any further work on such a project will only lead to more costs or worse. 
Under no circumstances do we want to end up here. No matter what our failure culture is, these kind of failures are so damaging that they have to be avoided, almost at all costs. In this area it is much better to learn from other people - those who by some miracle or sheer will managed to survive such a failure. 

These are the software bugs that caused failures in pace makers, that faked the measured emission at Volkswagen or that caused the recent crashes of Boeing 737s. It does not matter if one finds himself in this situation because of ones own fault or from external circumstances - the consequences are the same.   

## Getting control back

The boundaries between the types of failure are of course very fluid and depend on the skill, experience and personality of each individual. An experienced climber might still be in the green zone while an absolute newbie is already overwhelmed in the climbing gym.
Especially the transition from "Controlled Abort" to "Getting away with it" is very hard to anticipate. Suddenly we find ourselves in a situation that we can no longer fully control. A critical security bug just showed up in production or the last bolt popped out of the rock. When this happen our goal dramatically shifts from "reaching the goal" to "containing the damage". 

What happens here is very interesting. After the initial reflex of the three Fs- Fight, Flight or Freeze - a moment of absolute concentration sets in. Software and mountain climbing both require systematic actions to solve problems not hectic actionism. All the knowledge and skill get activated to get the control back. The software is reverted to a stable version, a patch is provided or one inches back to a safer spot on an improvised pulley-system. In this state of flow the situation is resolved step by step until the situation is getting closer to normal or routine. 

Once one is back in the zone of "controlled abort", actually aborting and getting back to safety is highly advisably. Suppressing the impulse to still trying to reach the summit or push the feature through nevertheless will safe lives. 

Open, brutally honest communication in a team or rope party are indispensable in this situation. Not just in the situation of immediate danger, but until one is back on solid ground. Reflecting and learning from what one just experienced becomes key to further successes. 

## The joy of failure 

The crisis has been averted, the damage was acceptable in its extent and suddenly the situation is back. One wants to go back up that mountain or deliver that feature that caused so much headache. 

With a beating heart one stands back at the foot of the sheer wall, one takes the story from the scrum board. Taking a deep breath one ties in and looks for the line of code to fix. The journey starts slowly at first, and with utmost care until one reaches the point where things went bad last time. And there it is. That tight spot from the last attempt. One nods to the belayer, gets a buddy for pair-programming and off one goes. Line for line, move for move the problem is formulated and protected with nuts, cams and unit-tests. 

The climb goes higher and higher and one sends the feature into the CI-environment. All tests pass, a last heave and one stands on top. Enjoying the marvelous view and admiring the users using the delivered software is an amazing feeling. 

This moment of standing at the top of a mountain or watching your feature performing nicely in the code is awesome. Full of pride one looks back at how one had to go through hell to get here. How horrible and how good the experience of overcoming a near-catastrophic failure was. And one knows that reaching this summit would not have been possible before. Knowing that experience these moments of dread and despair provided the necessary learning experience to finally reach the top is incredible. This feeling of having pulled through and the sense of personal mastery is the **joy of failure.** 

---

This article was inspired by the article ["Staying alive" by John Dill of the Yosemite Search and Rescue ](http://www.bluebison.net/yosar/alive.htm)

[find the article in german on blog.bbv.ch](https://blog.bbv.ch/scheitern-softwareentwicklung/)

[^1]: "red pointing" a climb means that the route was climbed without haning into the rope.
