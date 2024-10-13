---
layout: post
title:  "No more big bang releases - overcome your release fear"
description: "Despite agile software development becoming a quasi-standard in the industry, many teams still struggle with releasing software iteratively and still release with large, big bang releases. This post explores the reasons behind this and how to overcome the fear of releasing software."
thumbnail: images/cmake-conan-logo.png
---

**We can't release every two weeks, we're not a web company.** Despite agile software development being around for over 20 years and companies small and large adopting it with varying degrees of proficiency, one thing I still see happening frequently is the big bang release. Maybe this is a particularity to the close-to-hardware projects and the industries I worked in for the last ten years, but I doubt it. Interesting enough the reasons for not releasing more frequently are often not technical ones but rather organizational or psychological. 

While it is true, that having software that runs on a particular hardware or system that have a hardware component in them have different constraints than pure software projects, the principles of lean and agile software development can still be applied to a large degree. In most of the companies that I worked with there was a distinct fear of releasing software too frequently. From a technical standpoint the reasons for this fear were often rooted in complicating update procedures that were exposed to the end user, a fact that often could be solved relatively easily by utilizing proper tools for packaging and deployment. 

However there was often a much deeper fear in these organizations that was rooted in organizational structures. One of the most prominent reasons was that deployment and releasing and launching new features were not separated. Each release was a big event that was planned weeks or months in advance and that required a lot of coordination between different departments. This made it hard to release more frequently as it would require a lot of overhead to coordinate all these different departments. The effect was that each release was expensive, so a failed release was a big deal and a waste of money. 

It is only natural that companies want to advertise their new and exciting features and products and once in a while having a big bang release can be a good thing from a marketing perspective. From a technical perspective, pushing new updates to the user should be a non-event. While it might be hard to make the update non-noticeable to the user, especially if devices are not always connected to the internet, it should be possible to make the update process as smooth as possible. 


* Need to coordinate with marketing etc - want to advertise
* Feature flags, make it visible later
* updating and rolling out are a non-event for users
* seperate deployment from release - deployment is a technical task, release is a business task
