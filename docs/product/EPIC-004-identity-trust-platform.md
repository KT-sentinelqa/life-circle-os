# EPIC-004: Identity & Trust Platform

**Status:** Approved | **Phase:** 6A

## Objective
Establish the foundational Identity and Trust architecture for LifeCircle OS. The goal is to move beyond simple "login" screens and build a Zero-Trust, cryptographically backed identity model that scales to families while maintaining strict privacy boundaries.

## Scope
1. **Authentication:** The primary mechanism by which a user proves their identity to LifeCircle OS (Passkeys/WebAuthn prioritized over passwords).
2. **Device Registration & Trust:** Every device running LifeCircle OS must be explicitly registered and bound to a cryptographic keypair (Device PKI).
3. **Session Lifecycle:** Explicit policies around how long a session lasts, how it is refreshed, and how it is absolutely terminated (logout).
4. **Family Invitation:** Securely adding new members to a household without leaking household structure prior to acceptance.

## Product Principles Alignment
* **Trust Through Transparency:** The user always knows which devices have access to their family data.
* **Calm Interface:** Authentication should be invisible when secure (biometrics), and explicit only when necessary (re-authentication for destructive actions).
* **Privacy by Default:** Invitations do not leak PII. Sessions expire predictably. 

## Key Deliverables
* Fully functional Auth / Device / Invite modules in Riverpod/Isar architecture.
* Supporting ADRs (034, 035, 036) for engineering execution.
* Supporting Security Policies (SEC-026) for SRE enforcement.
