---
layout: post
title: "Artifact based CI"
description: ""
image: /images/cmake-logo.png
---

**Nowadays, CI/CD pipelines are a standard part of many software development workflows.** However, many teams still struggle with long build times, flaky tests and inefficient workflows. Apart from driving the cost of CI up, these issues can lead to frustration and reduced productivity up to quality issues as developers may not run the full test suites before deploying their changes. One approach to address these challenges is to use artifact based CI, which can significantly improve the efficiency and reliability of your CI/CD pipelines.

## What is Artifact Based CI?

Let's look at a typical CI/CD pipeline: When a developer pushes code changes, the CI system triggers a build process that compiles the code, runs tests, and produces artifacts (e.g., binaries, libraries, documentation). In a traditional setup, every time a change is pushed, the entire build process is executed from scratch, which can be time-consuming and resource-intensive.

{%include figure.html url="images/artifact-based-ci/example_cicd_pipeline.png" description="A typical high level view of a development pipeline" %}

Artifact based CI is a practice where the output of your build process (the artifacts) are stored and reused in subsequent builds. This means that instead of rebuilding everything from scratch every time, you can leverage previously built artifacts, which can save a lot of time and resources. This approach is particularly useful in large projects with many dependencies or when multiple teams are working on the same product.

If done right, artifact based CI can not just speed up your builds and increase the reliability of your CI/CD pipelines, but they are also a great way to test deployment processes on the go. By deploying the same artifacts that will be used in production, you can catch deployment issues early in the development process.




