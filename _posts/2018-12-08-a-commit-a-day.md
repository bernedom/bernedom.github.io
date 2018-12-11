---
layout: post
title: A commit a day keeps the boredom away
thumbnail: images/Git-Logo-2Color-thumb.png
---

**Most hobby projects die at the idea stage.** A while ago I decided to revive an old idea of mine to implement the [International System of Units](https://en.wikipedia.org/wiki/International_System_of_Units) as a [strongly typed C++ library](https://github.com/bernedom/SI). In order to try to bring this project forward I tried an experiment: **I would make at least one commit each workday for a month**. So a month later I am somewhat proud to say, that I kept this promise to myself with only one "comittless" day. But how does my pet project look now?
s
# I'm I done yet?

On average I spent only around 30 minutes on my project, most days during lunch break, sometimes when commuting to or from work. So not surprising, when looking purely at the code my library made some progress, but is still very far from being useable in production. In fact a lot of the intendend functionality is still missing. On the other hand a lot of very cool functionality such as compile-time unit tests and some mathematical operators are already in place. And I learned a lot of things and experimented with some concepts of modern C++ in ther process. I'm particularly proud that I have a working CI system and that I was able to pull off a Test driven aproach when developing. 

But more interesting is that spending a small amount of time each day on my project put me into a state of **creative flow**. When I started my "month of commitment" the project was in the state of a pure experiment. A few badly formatted, hacked together files that already proved the concept of what I wanted to do, but the code was very far from a state that I wanted the world to see. Nevertheless I created a repo on github and started to get to work. Step by step the project grew in the familiar pattern of TDD: write a test, make test run through, refactor. 

When I started was very much worried, that my limited time each day would be a problem, but surprisingly that was not the case. By doing TDD I was able to formulate the project into a string of small problems to solve, each not taking more than half an hour by itself. It was usually the refactoring afterward that demanded bigger timeslots, but being aware of that allowed me to schedule my activity a bit. The interesting lesson here is that by being able to fracture the project into a string of small problems and having a high confidence of not breaking anything while refactoring I made a lot of progress with comparatively little time invested. 

# Getting into the flow

Even more interesting than actually being able to further the project in small steps was that it did not take long and I started to feel a flow of creativity. When I was working on one feature the next problem started to form itself in my brain and I could effortlessly create and maintain a small backlog for myself. The orignial idea of building a strongly typed library for physical units remained always in my mind. But soon I added the idea that it could be almost entirely compile-time validated under the right circumstances, which led me to rewrite the necessary tests also to work on compile time. Compile time verification is of course dependent on the compiler, so I needed a system for continous integration which let me allow multiple compilers - enter (Travis CI)[https://travis-ci.com]. Then came my internal dispute about using `static_asserts` or `std::enable_if` and SFINAE to ensure correct usage of the library, so it was refactoring time again. 

This train of though went on and on - in fact it is still going on. One thing led to another with minimal conscious effort on thinking what do do next. And if I a bit more time to think, then I would do some trivial task like documenting, fixing naming inconsitencies and so on. I came to recognize that having this state of flow and clear goal to pursue is very valuable and rewarding when one tries to get things done. On one hand it kept the project interesting to complete because I constantly had to think about new things ond the other hand I frequently got the satisfaction of getging something done by splitting it into smaller problems. 

Being able to push my pet project with so little effort made me realize what we throw away, when developers have no clear goal (or alignment towards it) and how much TDD helps not just with code quality but also can be a tool to split functionality into small, workable problems. There are also other things like the need to constant refactoring that we should not eschew but often do so at work because of various reasons. After all having a code-base that "feels good" to work with is a tremendous motivator. 



# And now? 

As stated at the beginning the project is stil not close to being done, or at least feature complete. And while I might get a bit more lax with the one commit a day rule, I fully intend to keep a steady cadence of commits up for the time being. Let's see how much in the flow I am in a month or two. 

