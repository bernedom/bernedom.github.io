---
layout: post
title: Agile development in a regulatory environment
thumbnail: images/cmake-logo.png
description: how to benefit from apply agile software development in a regulatory environment such as ISO 13485 or IEC 62304
---

**Agile software development for medical devices is not possible, because of the regulatory requirements.** This response is common when asking people from med-tech or similar regulated industries. But going agile is possible, even when doing regulated software, and the benefits are the same. And the results are often better products than with traditional approaches. Going agile will not lessen the additional overhead required to pass an audit, but it will focus on creating those artifacts which bring value to the products first. 

## Regulatory requirements in a nutshell 

On a very high level, most regulatory standards (such as [IEC62304](https://en.wikipedia.org/wiki/IEC_62304) which regulates software for medical devices) require the development process a) require documentation of the development, testing and release processes involved as well as structured documentation for technical and architectural designs and a deeper risk assessment. In addition to the documentation most regulatory standards require some forms of testing to be done which is linked to the documented requirement and tracked over time if the requirements change. 
Once a device or piece of software has been released, there has to be a documented and followed process of tracking its evolution due changing requirements, hardware or even defects found during its operation.
Then there are of course additional regulatory and domain-specific standards for specific parts or usages of a device, such as the [ISO 14708 standard for active implantable devices](https://www.iso.org/obp/ui/#iso:std:67700:en) when creating a pace-maker. These often bring additional documentary and design-relevant requirements with them - and of course they need to be documented and the software needs to be tested against them. And once the software is done and the device assembled a whole lot of system testing starts. From measuring electromagnetic interference to performance in massive below-zero temperatures, during an earthquake, during a power-outage or just being operated by clueless people. Phew. quite a lot. 

Sounds complicated and like a lot of hassle? Well, it certainly is far away from a "just code that stuff" approach to software development. But while it is additional effort, if done correctly it is not such a pain. On the upside it ensures that devices and software which operates in areas where failure means bodily harm to people is as safe as possible. 

Note that I wrote "safe" not "good". All that regulatory stuff does in no way ensure that using such a device is acutally convenient or that the use case is solving a real problem. It merely states that it is known what this device does, how it does what it does and that it adheres to internationally defined standards. 

## Going agile in regulatory environments

Traditionally following regulatory guidelines meant a lot of design up front and linear development afterward. If you're lucky you might end up with a [V-Model approach](https://de.wikipedia.org/wiki/V-Modell) which measures it's cycle time in months rather than years. But modern software development happens faster. Software is wonderfully volatile, changes are much easier to bring in than for instance into a piece of hardware machinery. And agile development takes advantage of that to produce better products.

### How do you work?

Regulatory bodies often require that the process how software is created is described and that all involved are trained in how to work. Typically the way software is developed consists of a *quality manual* which describes the metrics used for assuring quality, *standard operating procedures* (SOP) describing how software is created and *quality assurance procedures* describing how adhering to the defined quality metrics is done. Sounds quite simple, but this being regulatory relevant documents the process creating and signing them off might be a bit of a tedious nightmare. Make sure that whoever is able to describe your development process (*cough* scrum master) is in the loop there. Pointing to the scrum guide might be already enough to satisfy a SOP.

The sole goal of documenting the processes is to ensure that you're able to track changing requirements and defects and are able to produce software with a defined quality standard.

### Use your CI to create regulatory documents all the time

There is no denying that writing regulatory software comes with a documentation overhead compared to doing "normal" software development. One of the core artifacts of agile development is to be able to deliver software often to the client. So this means pulling the documentation along as you go. Documentation as code is a very good way to do that. Put that documentation right along the code, so developers can easily update it when they are changing code. Checking if any of the requirements or test cases associated with them was affected should be part of the review process in your team. 

The best is writing the documentation in a text-based form such as (Asciidoc)[https://asciidoc.org/] as it can be easily versioned by git and is not that hard to learn, Then have your CI pipeline convert that into PDF or whatever format is needed and push it to the storage that archives the regulatory documentation if you're releasing. But it does not stop there, by having the documentation accessible like code allows for automatically checking it for formal correctness, such as "does every requirement have the necessary test cases associated?" or are there orphaned tests which are not linked to a requirement? Even more in-depth checking can be realized with a bit of effort such as, are all necessary parts of a document filled out and is the correct template used?

It is also very likely that part of your quality assurance is done automatically such as having unit-tests verifying some regulations. By having the documentation at the same place as the automated tests again allows for cross-checking or even generating the tables showing the passing tests automatically.

The effort is not more than if the documentation is written at the end all-at-once and an approach of "writing as you develop" greatly increases the correctness of the documentation. 

### Decouple product validation from regulatory releases

Regulatory releases are often accompanied with a heavy, time-consuming and expensive series of tests. While a lot of tests can be automated and even be covered with a decent CI/CD infrastructure there is often a part such as endurance or stress tests which needs to be done the old-fashioned way. This can even reach almost absurd proportions such as submerging devices into freezing salt water, operation during temperatures close to the boiling point of water and so on and so forth. So it just is not practicable to do this every few weeks. But this does not mean to delay all testing until one decides to release a piece of software to the public. On the contrary finding a non-critical bug only during final testing is a huge waste, as fixing it would often mean that all those expensive tests have to be redone. 

Regulations do not prevent a lot of value-producing tests even while a device is not yet declared fit for the public by the FDA and similar authorities. Testing an UI against usability with a representative set of users can be done regardless of the state of validation. Presenting a click-dummy to a possible operator early on creates value even if the design did not yet pass regulations. After all regulatory requirements often only ensure that one does the "thing right" not "the right thing". 

True to the agile spirit we want to create "possible shippable products" frequently to pit against the relevant stakeholders and gather feedback. 

### Know your Q&A experts

Typically regulatory quality assurance is done by a different set of people than those who develop and build a product. This is a good idea to ensure that the QA is done with some objectivity. However the point "People and interactions above processes and tools" still stands here. Knowing the faces responsible for the QA of a product tremendously increases the quality of the feedback loop. 
The better you as a developer know how QA works and what their daily struggles are the better you are at catering to their need. In the end QA is just another stakeholder like any customer or end user which needs to be satisfied. Being close to QA early in the development helps finding blind spots in your documentation and process early on and gives the possibility to correct the course early on. Ideally knowing does not just end at being aware of what QA needs, but by doing cheap dry-runs of the testing early on. Hand over early drafts of your work to QA and get feedback on if what you're producing is usable. On the other hand talking to QA early about what is needed for testing can help them to build the needed testing infrastructure or correct your test cases so they fit better to what is already there. 

## So all is fine? 

Developing in a regulatory environment will never be as carefree and lightweight as developing in a non-critical area. But [nevertheless the twelve principles for agile development](https://agilemanifesto.org/principles.html) work just the same the context is just a bit more rigid. The regulatory requirements will make a release to the customer (much) more expensive and thus put economic pressure on the frequency with which releases are possible, but going agile will still help us to provide more value and if done correctly can ease the pain of late testing significantly. And in the end better products that reach the customer earlier will be the benefit of it. 
So do not fall in the trap of believing that just because regulations and the regulatory bodies such as the FDA encompass such slow and cumbersome processes that you need to do the same. 