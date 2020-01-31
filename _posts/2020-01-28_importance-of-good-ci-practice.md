---
layout: post
title: The importance of good CI practice**
thumbnail: images/golden-circle/golden_circle.png
---

**How good software craft helped me write code in a language I do not know.** So I have this pet project ['SI' A C++ library for type-safe physical units](https://github.com/bernedom/SI) and a while ago I thought it a good Idea to add micro-benchmarks to it. Adding the first few benchmarks was easy enoug>h and soon I started to think about integrating this into SI's continuous integration cycle. And hooray, there actually existed a quite nice [github action for continous benchmarking](https://github.com/rhysd/github-action-benchmark). - except that it did not support [Catch2](https://github.com/catchorg/Catch2/) my favorite testing/benchmarking framework. And that the action was written in typescript. I don't know any typescript, in fact I did not even have any experience with javascript at all at that point.

So here was I considering to build something in a language that I did not know (typescript/javascript) with a buildsystem I did not understand (npm) in a framework I did not really know (github actions) on a code base written by someone I did not know half a planet away. But hey we live to learn and how hard could it be to write a few regexes for output mangling in javascript?

So the first thing I did was looking at the documentation. Fortunately was very complete and even included a kind of a step-by-step guide on how to contribute new tools to the project. Even though I did not understand it at that point, this gave me confidence that I could do this. 

Then I had a look at it's testing- and CI-Infrastructure made with github actions. Nice! there was a CI action that did not just compile but also did unit testing, linting, code coverage and some other obscure things I did not get at that point. Again a big confidence boost, even if I did something bad testing looked good enough to catch some of the stuff I might break. And given that I was a complete newbie in almost anything relating the project I would probably break a lot. 

So I forked the repo and off I was coding. Just to be ground to a halt in minutes. "How the hell do I build this stuff locally?" was actually the first question this javascript-noob asked.  
Again having a CI that mimicked a local build came in very handy, instead of lengthy documentation I just could look the actual commands to build up and soon I was flying. Another bonus was that since there were already tests doing similar stuff that I wanted to to do I could do Test Driven Development right away. I did a lot of mistakes working in an unfamiliar programming language and I sometimes just did not get at all how my changes would be used in the final application, but that did not matter that much, because whenever I pushed I got fast feedback on whenever I was doing something stupid. 
And lo and behold a few days later the PR to the upstream repo was finally open. A few brief discussions and hints about improvement with the owner of it and the changes where merged without too much headache. 

## Nice tale, but what about it? 

This example illustrates perfectly the value of having a decent CI and testing that encourage good software craft practices such as TDD in your project. It is not just about having correct code, but also greatly increases maintainability of a code base. **Without these I would not just have delivered bad code, I would have delivered none at all.** 
Having a code-base that follows good practice of the software craft is what allows junior members of your team to deliver at all without constant hand-holding by their seniors. Having the safety-net of these practices in place also allows for individual learning without fear of breaking things at the preferred pace. 

The clean code with explicit and automatically checked standards on code style, coverage and testing will help inexperienced members to actually deliver code. The fact that I was able to deliver a feature into production in a language that I did not know in the space of a few days during my spare time still astonishes me. Yes, setting such things up takes time and skill, but the leverage is huge.