---
author: Dominik
layout: post
title: Agile software development in a regulatory environment
image: /images/regulatory_agile/thumbnail.jpg
hero_image: /images/regulatory_agile/thumbnail.jpg
hero_darken: true
description: how to benefit from apply agile software development in a regulatory environment such as ISO 13485 or IEC 62304
tags: regulatory, agile, software-development
---
author: Dominik

**I would like to do agile software development for my medical devices, but the #$%! regulations make it impossible!** This response is common when asking people from med-tech or similarly regulated industries about [agile software development](https://agilemanifesto.org/). Contrary to this popular belief, developing regulated software in an agile way is not as hard as one might think. Yes, going agile will not lessen the additional overhead required to pass a regulatory audit. But by focusing on creating artifacts and features which bring value to the products first, the result will be better products.

## Regulatory software development in a nutshell

Most regulatory standards[^1] require documentation of the processes for development, testing, and releasing, as well as structured documentation for technical and architectural designs together with a risk assessment of the possible hazards for the end-user.
Additionally, regulatory standards require that testing is done and linked to the documented requirements. Guidelines for how to conform to these standards are often collected in documents called ["good (automated) manufacturing practices"](https://en.wikipedia.org/wiki/Good_manufacturing_practice).

Once a device or piece of software has been released to the public for the first time, tracking its evolution, be it due to changing requirements, different hardware, or even defects found during its operation, has to be documented and done consistently.

Then there are the additional regulatory standards for specific parts or usages of a device to consider. These standards often bring additional requirements for documentation, design and quality assurance with them. One example is [ISO 14708 standard for active implantable devices](https://www.iso.org/obp/ui/#iso:std:67700:en) for pace-makers and similar devices - but there are of course many, many such standards out there.

When releasing a device and its software, there is a whole array of system-tests that it has to undergo before it is deemed fit for operation. From measuring electromagnetic interference to performance in massive below-zero temperatures, during an earthquake, during a power-outage or just being operated by clueless people, the list goes on and on. And no matter what, the device has to perform as specified, else the regulatory audit fails and it's back to development.

> Agile development helps to add "good" to "safe" by bringing early feedback into the development.

Sounds complicated and like a lot of hassle? There is no denying the additional effort involved, but if done correctly it is not such a pain. On the upside, regulations ensure that devices and software which operate in areas where failure means bodily harm to people are as safe as possible.

Note that I wrote "safe" not "good". All the regulatory stuff in no way ensures that such a device is convenient to use or that it is solving a real problem. It merely states that it is known what this device does, how it does what it does, and that it adheres to internationally defined standards. Luckily, agile development helps to add "good" to "safe" by bringing early feedback into the development.

## Going agile in regulatory environments

Traditionally, to follow regulatory guidelines meant a lot of design upfront and linear development afterward. If you are lucky you might end up with a [V-Model approach](https://de.wikipedia.org/wiki/V-Modell) which measures it's cycle time in months rather than years. But modern software development happens faster. Software is wonderfully volatile, changes are much easier to bring in than for instance into a piece of hardware machinery. By doing agile software development we use that to our advantage to produce better products. But can it work in regulatory environments? Yes, and here is how:

### Know how you work

> The sole goal of documenting the processes is to ensure that changing requirements and defects are tracked and that the software is written against a defined quality standard.

Most regulatory audits require that the process of developing software is described and that all people involved are trained follow the defined processes. Typically that description consists of a *quality manual* outlining the metrics used for assuring quality, several *standard operating procedures* (SOPs) describing the processes involved in developing and delivering the product, and *quality assurance procedures* (QAPs) defining how adhering to the quality metrics is done. The sole goal of documenting the processes is to ensure that changing requirements and defects are tracked and that the software is written against a defined quality standard.

Sounds simple, but this being regulatory relevant documents the process creating and signing them off might be a bit of a tedious nightmare. Make sure that whoever can describe your lean-agile development process (i.e. your scrum master or equivalent) is in the loop. Pointing to the scrum guide might be already good enough to satisfy a SOP.

### Continuous integration for your regulatory documents

Compared to "normal" software development, writing regulatory software comes with a documentation overhead. For regulated software documentation has to be considered as an integral part of the software, because without it it will never reach the market. So continously integrating into the product is the logic consequence of it if one want to release frequently.
I like the approach of *documentation as code* for achieving that. Put that documentation right next the code, so developers can easily update it when they are changing code. Checking if any of the requirements or test cases associated with them is affected thus becomes a part of the review process in your team.

> The effort of pulling the documentation along instead of all-at-once right before the release is probably comparable, but "writing as you develop" will greatly increase the correctness of the documentation.

Writing the documentation in a text-based form such as [Asciidoc](https://asciidoc.org/) helps to version it with git. Then have your CI pipeline convert that into PDF for each build and push it to the storage that archives the regulatory documentation when you are releasing.
But it does not stop at just building it. Having the documentation accessible like code makes automatically checking it for formal correctness, such as that every requirement has the necessary test cases associated, or that there are no orphaned tests, relatively easy. With a bit of effort even more in-depth testing can be done. Having a warning if there are vital parts of a document empty or if an outdated template is used can prevent a lot of wasted effort. And it does not stop at the documentation itself. Documentation as code makes linking software-tests that verify some requirements to the documentation very easy.

The effort of pulling the documentation along instead of all-at-once right before the release is probably comparable, but "writing as you develop" will greatly increase the correctness of the documentation.

### Decouple product validation from regulatory releases

Releasing a regulated product is often accompanied by a heavy, time-consuming, and expensive series of manual or semi-manual tests. A lot of tests can and should be automated, and then be covered with a decent CI/CD infrastructure. But there are often parts of the quality manual, such as endurance or stress tests, which need to be done the old-fashioned way. These tests can cover a wide range and often require a product to be "ready for sale". Be it tests in extreme climates over gross mistreatment to validation against clinical studies - the effort going into this final quality assurance is often considerably and it is just not practicable to do this every few weeks.

However, it is *because* these tests are so expensive, that delaying any non-critical testing until the last moment is a huge risk. Finding a non-critical bug  during final testing often means that fixing it would be too expensive, as a code change might mean that the tests have to be redone. The result is a product that is cumbersome to use or quirky in its behavior and requires the user to read hundreds of pages of manuals to memorize all that strange behavior.

Regulations do not prevent that tests are done even while a device is not yet declared fit for the public by the FDA and similar authorities. Testing an UI against usability with a representative set of users can be done regardless of the state of validation. Presenting a click-dummy to a possible operator early on creates value even if the design did not yet pass regulations. The same is for integration and endurance tests, while they might not be as rigorous as the final tests running them frequently and early creates value and helps to find defects before they go into production.

### Know your Q&A experts

Typically regulatory quality assurance is done by a different set of people than those who develop and build a product. The purpose is to ensure that the QA is done with some objectivity. However the point "People and interactions over processes and tools" is still valid.

> QA is just another stakeholder like any customer or end-user which needs to be satisfied.

The better you as a developer know how QA works and their daily struggles, the better you are at catering to their need. In the end QA is just another stakeholder like any customer or end-user which needs to be satisfied. So having a personal connection to the QA-people tremendously increases the quality of the feedback loop.

Being close to QA early in the development helps to find blind spots in your documentation and process early on and gives the possibility to correct the course early on. Doing relatively cheap dry-runs of the testing early on, even if the product is only half done brings a lot of things to light. Hand over early drafts of your work to QA and get feedback on if what you are producing is usable to them.
Talk to the QA people about what is needed for testing and help each other to build the needed testing infrastructure or at least use what is already there.

## Regulatory does not mean rigid

Developing in a regulatory environment will never be as carefree and lightweight as developing yet another casual game for mobile phones. However, [the twelve principles for agile development](https://agilemanifesto.org/principles.html) work just the same, the context is just a bit different. Taking an agile approach will ease the pain of late testing significantly and help to provide more value for the end-users. Despite the regulatory requirements that might make the act of releasing to the customer expensive, bringing agile development into play will help to create better products that reach the customer earlier.
Do not fall in the trap of believing that regulatory software development has to be slow and cumbersome, just because regulations and the regulatory bodies such as the FDA are known to be.

---
author: Dominik

[^1]: For instance [IEC 62304](https://en.wikipedia.org/wiki/IEC_62304) which regulates software for medical devices.
