---
author: Dominik
layout: post
title: "Cyber Resilience Act - Get Started"
description: ""
image: /images/cyber-resilience-act/thumbnail.jpg
hero_image: /images/cyber-resilience-act/thumbnail.jpg
hero_darken: true
tags: cyber-resilience-act
---

**The EU Cyber Resilience Act (CRA) is set to become a landmark regulation for software and connected device security in Europe.** With its planned enforcement starting in September 2026, companies developing software or devices using software must prepare to meet its requirements or fear of losing access to the EU market. While this sounds daunting at first, it might not be as overwhelming as it seems. This post provides a practical overview of what the CRA entails, what companies need to establish, and how to get started to meet the requirements in a structured way.

## The Cyber Resilience Act at a glance

At the very highest level, the Cyber Resilience Act - often abbreviated as CRA - is a regulation by the European Union that aims to enhance the cybersecurity of products with digital elements, including software and connected hardware devices. The CRA establishes baseline security requirements for these products throughout their lifecycle, from design and development to deployment and maintenance. The term **"products with digital elements"** is defined broadly and includes any product that relies on software to function, such as IoT devices, medical devices, industrial control systems, and general-purpose software applications.

At the core, the CRA focuses on three main areas:

* Security-by-design: Integrate security measures into the product design and development process from the outset.
* Vulnerability management and incident response: Establish processes for identifying, reporting, and remediating vulnerabilities throughout the product lifecycle. Develop and maintain an incident response plan to address security incidents effectively
* Compliance documentation: Maintain comprehensive documentation to demonstrate compliance with CRA requirements.


{%include figure.html url="images/cyber-resilience-act/cra_pillars.jpg" description="Three main components for compliance with the Cyber Resilience Act: Security-by-design, Vulnerability management, Compliance documentation" %}


Let's look at some of the key requirements of the CRA in more detail. 

### Security-by-design

Security by design is a fundamental principle of the CRA and is often considered the most technical part. This means that security considerations must be part of the design and development process of software products. So companies need to implement secure coding practices, conduct regular security testing (e.g., static and dynamic analysis, fuzzing, penetration testing), and ensure that products are resilient against common cyber threats. Additionally, products must be designed to minimize attack surfaces and protect sensitive data. But what about existing products? Do they need to be redesigned from scratch? Not necessarily. The CRA recognizes that many products are already in the market and allows for a risk-based approach to security improvements.

> The CRA recognizes that many products are already in the market and allows for a risk-based approach to security improvements.

This means companies need to assess the security, do a threat analysis of their existing products first. After this assessment, they can prioritize security enhancements based on the identified risks and start implementing necessary measures to improve security over time. An important part here is, that a lot of the security issues might be mitigated by other means than code changes e.g. by limiting exposure to threat vectors or improving user guidance.

### Vulnerability management and incident response

The authors of the CRA understand that no software is perfect and vulnerabilities will inevitably be discovered over time. Therefore, the CRA mandates that companies establish *vulnerability management* and *incident response processes*. At the core vulnerability management means setting up a way to report and triage vulnerabilities, a way to inform customers about the existence of a vulnerability and ensuring timely remediation of identified vulnerabilities. Again, this sounds like a lot of work, but in many cases existing processes for receiving user feedback or bug reports can be extended to cover security vulnerabilities. 

While proactively addressing vulnerabilities is important, companies must also be prepared to respond effectively when security incidents occur. This is closely tied to the vulnerability management and may even use some of the same facilities.

> The most important part of incident response is to have a clear plan in place that outlines roles, responsibilities, and communication channels during a security incident.

The most important part of incident response is to have a clear plan in place that outlines roles, responsibilities, and communication channels during a security incident. So make it explicit, who is taking over the lead, who needs to sit in the crisis room and what are the response times expected. Who can make decisions to enable containing the incident, mitigating its impact, and recovering normal operations. The third part to be ready for the CRA is to have comprehensive compliance documentation.

### Compliance documentation

Chances are that if you are affected by the CRA, you already have some level of compliance documentation in place, because many other regulations (e.g., GDPR, industry-specific regulations) also require documentation of security practices. If so good news, you can build upon your existing documentation efforts. Don't panic, creating the necessary documentation is not an unmanageable task. So what kind of documentation is required? First of all, the efforts described in the previous sections need to be documented. This includes documenting the security-by-design practices, vulnerability management processes, and incident response plans discussed earlier.

>  Don't panic, creating the necessary documentation is not an unmanageable task.

Additionally, companies must maintain records of security testing results, risk assessments, and any security-related decisions made during the product lifecycle. In practice this means nothing else as keep the CI/CD and testing results of your releases ready and create a comprehensive changelog. Additionally the CRA requires companies to also keep track of third-party components used in their products, including open-source libraries. This means maintaining a Software Bill of Materials (SBOM) that lists all components, their versions, and any known vulnerabilities associated with them. This can be automated to a large extent using existing tools that generate SBOMs as part of the build process. 

The compliance documentation is the final piece of the puzzle to be ready for the CRA. While security-by-design and vulnerability management focus are the more practical parts, compliance documentation ensures that companies can demonstrate their adherence to CRA requirements. So where to start?    

## Get started with the Cyber Resilience Act

Preparing for the CRA may seem overwhelming at first, but breaking it down into manageable steps can make the process more approachable. An incremental approach is often the best way to build up the neccessary capabilities to pass an audit and get your products certified. 

Start with a high level gap assessment to identify where your current practices stand in relation to the CRA requirements. Then implement a "CRA-Light" process that covers the most critical aspects of the CRA without overwhelming your teams. Start with the "who" regarding vulnerability management and incident response. Do a high level STRIDE threat model for your main products to identify the biggest risks. Automate SBOM generation in your build process and start collecting compliance documentation as you go along. 

While this might not cover all aspects of the CRA right away, it establishes a foundation that can be built upon over time. Building up CRA compliance incrementally allows teams to adapt and improve their processes without feeling overwhelmed by the full scope of the regulation from the start. And remember passing audits on the first try is nice, but often not the case - so build a process that allows you to continuously improve and get better over time.

After all, the CRA is not just about compliance; it's about enhancing the overall security posture of products and protecting users from cyber threats. By taking proactive steps to meet CRA requirements, companies can not only ensure market access in the EU but also contribute to a safer digital ecosystem.

