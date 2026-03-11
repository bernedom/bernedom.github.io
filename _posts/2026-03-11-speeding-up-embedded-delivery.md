--- 
layout: post
title: "Making Releases a Non-Issue: Speeding Up Delivery for Embedded Devices"
description: ""
image: /images/encryption-at-rest/encryption_at_rest_thumb.jpg
hero_image: /images/encryption-at-rest/encryption_at_rest.jpg
hero_darken: true
tags: secure-boot yocto embedded-linux
lang: en
author: Dominik Berner
---

**Shipping software for embedded devices has traditionally meant long release cycles, risky upgrades and "Big Bang" releases.** But it doesn't have to be that way. Being able to ship updates to your devices faster and more reliably can be a game-changer for your business. It means being able to ship earlier, respond to customer feedback more quickly, and fix bugs on the fly. When shipping software becomes a routine and safe, teams can focus on delivering value instead of managing risky releases. Moving from a few releases every odd year to a few releases every month will be a game-changer and it is not as hard as you might think. 

== Why ship faster? ==

In many embedded software projects, releases are rare and stressful events. They often involve a lot of manual work, coordination between teams, and a high risk of things going wrong. The alternative is to make releases small, frequent and boring. Instead of bundling months of development into a single firmware version, deliver incremental improvements continuously. Each change should be small enough that its impact is well understood and reversible.

When releases are small and routine, the feedback loop with customers becomes much shorter and product development becomes more agile. While embedded software probably never will be able to ship as fast as pure software products, there are still many ways to speed up the delivery process and make it more reliable. However, moving from multiple months between releases to a few weeks or even days can have a huge impact on your product and your customers. It allows you to respond to customer feedback more quickly, fix bugs faster, and deliver new features sooner. 

{% include services-ad.html %}

== How to ship faster? ==

To enable faster releases for embedded devices some groundwork is required. Some are technical, some are organizational and some are cultural, but most of them can be implemented with relative ease. Here are some of the key steps to get started:

1. **Treat releases as a routine**: Developers should go through the release process frequently and it should be a well-known and well-documented process. 
1. **Over-The-Air (OTA) updates**: This is the technical foundation for being able to ship updates to your devices. It's important to choose one that fits your needs and requirements.
1. **Automated Testing through a powerful CI/CD pipeline**: Derisk your releases by rigorously testing your software before it goes out to customers. 
1. **Shift Product Management towards delivering features**: Instead of focussing on large, groundbreaking releases and major versions, focus on delivering small, incremental improvements that add value to your customers.


