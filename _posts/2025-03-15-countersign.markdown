---
title: Notes on Countersign
layout: post
date: 2025-03-15 10:00
image: /assets/images/markdown.jpg
headerImage: false
tag:
    - cryptography
    - research
star: true
category: blog
author: Nikki Sigurdson
description:
---

## About the Protocol.

User authentication protocols are crucial for establishing secure connections on peer-to-peer (P2P) networks like Bitcoin. They ensure that users can trust the data they receive from other nodes without the risk of interception by malicious actors.

Countersign is a new authentication protocol designed specifically for the security and privacy needs of P2P networks. It offers better privacy guarantees and is faster than existing solutions, and achieves a wide range of desirable properties including security against impersonation, forward privacy for both parties, and security against malicious interception. Forward privacy means that even if an adversary obtains past session transcripts, they cannot learn additional information about the parties involved. Existing solutions often reveal considerable amounts of identifying information about the parties involved, and privacy-preserving authentication has been a mostly overlooked area of research until recently.

Countersign is a zero knowledge (Zk) proof of knowledge (PoK) system with a limited predicate scope. The verifier (called the challenger party in the paper) only gets one bit of information about the prover (called the responder party): the yes/no answer to whether or not the prover knows the secret key associated with the verifier’s given public key. Since Countersign is being developed for a specific application in network privacy, the current Countersign paper focuses on this application for the time being. However, in future work, I plan to investigate a generalization of Countersign to a more robust ZkPoK system. Another line of potential future work is to generalize Countersign in the direction of improving efficiency and privacy for Credible PSI[^credPSI].

## High-level Details about the Security Proof and its Design Challenges.

It was difficult to find a proof technique that was amenable to Countersign, because it was designed from the ground-up, so it’s a completely new protocol that wasn’t created by modifying or building upon existing ones. I spent considerable time doing literature searches and investigating different proof techniques to find a solution. Although the protocol of Roy et al.[^roy] is overall similar to Countersign, directly applying their technique to Countersign fails because they abstract away the private set intersection (PSI) step of the protocol in the UC proof and thus can prove their security by using UC composition. This doesn’t work for Countersign; Countersign also has a PSI-like structure in its first two messages, but the PSI-like part is “baked in” for efficiency, and cannot be abstracted away to do a similarly modular UC proof.

The proof technique used is UC-AGM (where AGM is the Algebraic Group Model), which was presented by Abdalla et al.[^abdal] The security proof was partly inspired by the technique used in the aforementioned paper in their analyses of the SPAKE2 and Chou-Orlandi protocols, and partly inspired from Jarecki and Liu’s work on secure PSI. Without the addition of the AGM assumption, I ran into an issue with proving Countersign’s security in the UC framework: when considering a malicious responder party, there was not enough structure to the message sent for us to create a security argument. The AGM assumption allowed us to, for proof purposes, also receive a “proof of construction” of all group elements used in the malicious responder message, which resolved the problem.

The security definition of Network Authentication Protocols (NAPs) is a novel contribution of this paper. Recently published related works such as Roy et al.’s work, a privacy update for SSH authentication, and a new authentication scheme for Apple Airdrop[^airdrop] each use a different and relatively informal security definitions, which makes comparing and contrasting the details of the protocols difficult. The Network Scenario definition is adapted from the paper “Generalized Proofs of Knowledge with Fully Dynamic Setup” by Badertscher et al. With the NAP definition presented in this paper, future works on network authentication will be able to more easily compare and contrast security properties of such protocols.

## References:

[^credPSI]: Garg, S. et al. "Credibility in Private Set Membership." Public-Key Cryptography 2023. [link](https://link.springer.com/chapter/10.1007/978-3-031-31371-4_6)
[^roy]: Roy, L. et al. "Practical Privacy-Preserving Authentication for SSH." USENIX 2022. [link](https://eprint.iacr.org/2022/740)
[^abdal]: Abdalla M. et al. "Algebraic Adversaries in the Universal Composability Framework." ASIACRYPT 2021. [link](https://eprint.iacr.org/2021/1218.pdf)
[^airdrop]: Heinrich, A. et al. “PrivateDrop: Practical Privacy-Preserving Authentication for Apple AirDrop.” IACR Cryptology ePrint Archive (2021). [link](https://www.usenix.org/conference/usenixsecurity21/presentation/heinrich)
