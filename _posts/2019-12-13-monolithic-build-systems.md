---
layout: post
title: Bane to the buildsystem monolith
thumbnail: images/monolith/thumbnail.jpg
---

**It's easy you just clone that repo and run this script and everything builds right of the box! - Except it doesn't.** Monolithic build-systems are evil. The pattern is similar, a company started doing software in earnest a few years (or decades) ago, starting out with a single pilot and over the years their portfolio grew to dozens of libraries and applications that somehow need to be managed. And with the portfolio the build-system grew as well. Now there is that custom script that runs an amalgamation of multiple technologies to build the full software stack at the click of a button. Except that this fails at least once a week and despite all the best efforts every software artifact contains some tweaks, cheats and customization to build.  

A pattern I encountered a few times in companies is that they try to make all their software build the same, possibly at the click of a single button. Maybe this is particular to C++ and companies working in the med-tech sector, but the fact that lot's of companies have full time positions for people responsible for the build-system suggests otherwise. 

I understand that one would not want to have a wild mix of build systems and technologies as well but baking all into a single monolith is at the opposite end of evil. 

By now I consider myself a fairly experienced developer but over the past I had a few times where I came up on software stack that I just could not build and had no clue where to start. Too much magic. 


---
Monolithic build system

Branch naming convention
Overwriting artefacts - dependency local, ci ...
Assumed file structures
Assumed file names and programming languages
Hidden functionality, over-abstraction

Modularize. Everything buildable by itself