---
author: Dominik
layout: post
title: "Cyber Resilience Act - Get Started"
description: ""
image: /images/cpp_logo.png
hero_image: /images/cpp_logo.png
hero_darken: true
tags: cpp 
---

Note: This is an informational overview, not legal advice. Consult counsel for scoped interpretations and timelines.

What it is (in brief)
- The EU Cyber Resilience Act (CRA) sets baseline cybersecurity requirements for “products with digital elements” placed on the EU market, covering both software and connected hardware.
- It introduces security-by-design obligations across the product lifecycle, post-market vulnerability handling, security updates, incident reporting, and documentation for conformity (CE marking).
- Duties fall primarily on manufacturers, with obligations also for importers and distributors. Some categories require involvement of a notified body (risk-based classification).
- There are transition periods before full enforcement; however, starting early is essential because many obligations affect how you build and ship software.

What companies need to establish
- Governance: name accountable roles (product owner and PSIRT lead), define a vulnerability disclosure policy, and train teams on secure development.
- Risk management: threat modeling and documented risk mitigation for each product and version.
- Secure development lifecycle: requirements, secure coding, reviews, testing, fuzzing, hardening, and release controls.
- Supply chain security: SBOMs, third-party component vetting, license compliance, and update mechanisms.
- Vulnerability handling: intake (including security.txt), triage, remediation SLAs, advisories, and coordinated disclosure.
- Post‑market surveillance: monitor exploits, track incidents, and deploy timely security updates for the product’s expected lifetime.
- Conformity evidence: technical documentation, test reports, security posture, and EU Declaration of Conformity to support CE marking.

Hands-on checklist (engineering-focused)
- Inventory and SBOM
    - Maintain a product/component inventory with version lineage.
    - Generate SBOMs in SPDX or CycloneDX for every build; store alongside artifacts; sign and ship with releases.
    - Prefer reproducible builds to correlate binaries with SBOMs.
- Secure build and release
    - Enforce branch protection, mandatory reviews, and signed commits/tags (e.g., Sigstore/cosign or GPG).
    - Harden binaries: position-independent executables, RELRO/now, stack canaries, FORTIFY, control-flow integrity where available.
    - Enable compiler/linker warnings-as-errors in CI; block release on security test failures.
- Vulnerability management
    - Scan source, containers, and SBOMs against public advisories (OSV/CVE); track risk and remediation.
    - Adopt VEX to communicate non-exploitable findings to customers.
    - Keep a living risk register mapped to mitigations and evidence.
- Update and rollback strategy
    - Provide authenticated, integrity-protected updates (consider TUF/Uptane patterns).
    - Implement safe rollback and partial failure handling; document update cadence and support window.
- Incident and disclosure process
    - Publish a clear policy and intake channel (security.txt; monitored mailbox).
    - Define triage steps, timelines, and customer advisory templates; practice table‑top exercises.
- Documentation and testing evidence
    - Threat models (STRIDE or equivalent), secure design decisions, pen/fuzz test outcomes, code review stats, and coverage for security tests.
    - User/admin guidance on secure setup, hardening options, and update procedures.

90‑day starter plan
- Days 0–30
    - Appoint a PSIRT lead; define scope (products, versions, roles as manufacturer/importer).
    - Run a CRA gap assessment; start product inventory; decide SBOM format; add a minimal VDP and security.txt.
    - Turn on compiler hardening, basic SAST, and dependency scanning in CI.
- Days 31–60
    - Automate SBOM generation in CI/CD; sign release artifacts and SBOMs.
    - Establish risk assessment and threat model templates; run them on top products.
    - Choose update mechanism and sign/verify flows; pilot on a canary channel.
- Days 61–90
    - Formalize vulnerability handling (intake→triage→fix→advisory); define SLAs by severity.
    - Draft technical documentation structure (indices, evidence collection).
    - Conduct a dry‑run of conformity documentation for one product; remediate gaps found.

Artifacts to prepare for conformity and CE marking
- Product definition and scope, intended use, assets, and assumptions.
- Risk assessment and threat model, with traceability to mitigations.
- Secure development process description and training records.
- SBOMs (per release), supplier evaluations, license due diligence.
- Security test evidence: SAST/DAST, dependency scans, fuzzing, pen test reports, code review records.
- Update architecture: signing, distribution, rollback, key management.
- Vulnerability handling and post‑market surveillance procedures; incident logs.
- User/admin security guidance and configuration hardening notes.
- EU Declaration of Conformity draft and references to harmonized standards (when applicable).

C++‑specific, practical hardening tips
- Compiler/linker flags (adjust for toolchain and platform): 
    - Enable stack protection and FORTIFY: use strong stack protector and define FORTIFY_SOURCE where supported.
    - Prefer PIE/ASLR and full RELRO; strip unused symbols in release; enable LTO carefully.
    - Turn on sanitizers (ASan/UBSan/MSan) and run in CI on nightly builds; run fuzzers on parsers and protocol handlers.
- Tooling
    - Static analysis: clang-tidy, cppcheck; integrate as a blocking CI job on changed code.
    - Fuzzing: libFuzzer/AFL on critical inputs; track coverage and crash triage.
    - Supply chain: lock and verify third‑party packages (e.g., Conan/vcpkg lockfiles), pin versions, and verify checksums/signatures.
- Secure defaults
    - Minimize exposed attack surface; disable unused features; validate all inputs; adopt constant‑time primitives for crypto-adjacent code; zeroize secrets.

Common pitfalls
- Treating SBOM as a document, not a continuously updated artifact.
- Shipping updates without strong verification or rollback protection.
- Missing traceability from threats to mitigations to tests.
- Incomplete vulnerability intake (no monitored channel or unclear policy).
- Collecting evidence too late; start capturing during development.

Where to read more
- Official CRA text and status on EUR‑Lex (search: “Cyber Resilience Act EUR‑Lex”).
- ENISA guidance on product security, coordinated vulnerability disclosure, and SBOM best practices.
- Relevant harmonized standards when published; in the interim, align with well-known baselines (e.g., IEC 62443 series, ISO/IEC 27001/27002 controls for process maturity).

Pragmatic outcome
- Create a lightweight “CRA kit” repo per product: templates (risk, threat model, tests), CI configs (SBOM, scans, signatures), update wiring, and evidence checklist. Make it part of the definition of done so compliance grows with the product—not as a scramble before release.