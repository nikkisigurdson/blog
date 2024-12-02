---
title: "New Research Directions"
layout: post
date: 2024-12-01 18:00
image: /assets/images/markdown.jpg
headerImage: false
tag:
    - Cryptography
    - MEV
    - Blockchains
category: blog
author: Nikki Sigurdson
description: New Directions in Cryptography Research for MEV & Blockchain Applications
---

(This post is currently a draft-in-progress.)

## Introduction

How does new cryptography research typically get performed?

## Framing New Directions

New cryptography typically emerges via the definition and analysis of new hardness assumptions, idealized models, and cryptographic scenarios (or in other words, use-cases). In cryptography, we use _hardness assumptions_ as the basis for cryptographic security. These are difficult problems, like the discrete-log challenge, that we believe real-world adversaries can only break by using brute-force attacks. Since such attacks require exponential-time to carry out, we consider them _computationally infeasible_ to real-world adversaries. In order to define hardness assumptions in the first place, we need some kind of mathematical, idealized model of _the world._ For example, to define the discrete-log challenge, we use an idealized model called the [generic group model](https://en.wikipedia.org/wiki/Generic_group_model). (For more resources, the original security proof of the discrete-log challenge in the generic group model is available [here](https://www.shoup.net/papers/dlbounds1.pdf).) Other common idealized models in cryptography include the Random Oracle Model (ROM), Common Reference String (CRS) Model, and Ideal Cipher Model. New idealized models often arise from studying new cryptographic scenarios.

## Ideas for Directions

Todo.

## Learning from the Past

In general, a major concern with investigating cryptography based on new proposed models, especially mathematically-sophisticated ones, is that the scope of attack-vectors can become difficult to analyze. An recent, example from the real-world is the torsion point attack discovered for the SIKE protocol. Before this attack was discovered, this protocol been in consideration for the 4th round of the NIST Post-Quantum Cryptography standardization process! (For more, see https://sike.org/, and https://www.wired.com/story/new-attack-sike-post-quantum-computing-encryption-algorithm/.) Research and development on brand-new cryptosystem tech must be done carefully and over long research timelines to ensure trustworthy security and privacy of the systems.
