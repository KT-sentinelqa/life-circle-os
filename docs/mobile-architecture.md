# LifeCircle OS — Mobile Architecture Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Principal Mobile Architect
* **Review Board:** Executive Architecture Board, UX & Human Factors Board, Quality Engineering Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates DDD bounded contexts are correctly mapped in the mobile client directory layout).
* **Enterprise Architect:** APPROVED (Ensures client architecture modularity enables future service extractions).
* **Principal Mobile Architect:** APPROVED (Validates complete Flutter, Riverpod, and Isar clean architecture).
* **Backend Architect:** APPROVED (Ensures mobile sync models align with the server sync schemas).
* **Domain Architect:** APPROVED (Confirms mobile domain entities are pure and free of Flutter dependencies).
* **API Governance Architect:** APPROVED (Validates that API calls align with the versioning and HTTP status rules).
* **Integration Architect:** APPROVED (Validates offline-first outbox synchronization queue and state machine).
* **Security Architect:** APPROVED (Confirms implementation of root detection, keystores, and certificate pinning).
* **Privacy Architect:** APPROVED (Ensures local data caches comply with DPDP/GDPR storage rules).
* **Identity Architect:** APPROVED (Validates local biometric authentication bindings and passcode recovery flows).
* **DevSecOps Architect:** APPROVED (Ensures automated Flutter testing is validated in PR pipelines).
* **Cryptography Reviewer:** APPROVED (Validates Keystore/Keychain key storage and Isar AES-256-GCM configurations).
* **Observability Architect:** APPROVED (Ensures mobile tracking triggers emit anonymous operational trace IDs).
* **Chief QA Architect:** APPROVED (Validates mobile test coverage metrics and Golden visual tests requirements).
* **Test Automation Architect:** APPROVED (Validates automated Flutter integration testing strategy).
* **Mobile Testing Architect:** APPROVED (Enforces mobile widget test automation constraints).
* **Accessibility Testing Board:** APPROVED (Validates WCAG 2.2 AA and Elder Mode design standards integration).
* **UX Guardian:** APPROVED (Ensures haptic feedback maps, layout curves, and spacing scales are operational).
* **Design System Architect:** APPROVED (Validates ThemeData generation matches design system tokens).
* **Elder Experience Specialist:** APPROVED (Ensures Elder Mode UI shell scales typography and touch targets dynamically).
* **Localization Architect:** APPROVED (Validates regional translation loading workflows).
* **Human Factors Reviewer:** APPROVED (Confirms button ergonomics and screen layout configurations).
* **Legacy Governance Board:** APPROVED (Ensures mobile codebase is clean, readable, and free of magic).
* **Documentation Governance Board:** APPROVED (Ensures mobile architectural runbooks are versioned in Git).
* **Dependency Governance Board:** APPROVED (Ensures third-party Flutter plugins conform to security guidelines).
* **Change Advisory Board (CAB):** APPROVED (Validates local database schema upgrades).

### Abstained Roles
* **Compliance Officer:** ABSTAINED. Reason: Legal DPDP fiduciary definitions are managed under the Privacy Strategy.
* **Site Reliability Architect (SRE):** ABSTAINED. Reason: Server availability and SLO budgets are separate from client-side UI rendering architecture.
* **Disaster Recovery Board:** ABSTAINED. Reason: Cloud server failover recovery configurations do not impact mobile client code.
* **Platform Architect:** ABSTAINED. Reason: Hosting configuration and backend Redis configurations are outside the scope of client code.
* **Infrastructure Architect:** ABSTAINED. Reason: Terraform provisioning does not manage mobile client Dart code.
* **Release Governance Board:** ABSTAINED. Reason: Automated release pipeline tags and signing key setups are managed under DevOps rules.
* **Performance Testing Architect:** ABSTAINED. Reason: Server load and throughput stress testing are handled under the Performance Strategy.
* **Security Testing Board:** ABSTAINED. Reason: Secrets detection and vulnerability scanning do not modify mobile client structure.
* **Mutation Testing Board:** ABSTAINED. Reason: Mutation testing is executed on backend domain models, not mobile views.
* **Contract Testing Board:** ABSTAINED. Reason: Schema contract validation checks are managed under API guidelines.
* **Test Data Governance Board:** ABSTAINED. Reason: Anonymized seed fixtures do not change mobile application architecture.
* **Open Source Governance Board:** ABSTAINED. Reason: Self-hosting fallbacks do not impact mobile layouts.
* **Financial Sustainability Board:** ABSTAINED. Reason: Mobile UI and client caching have no direct impact on unit economics.

---

## 1. Architectural Patterns & Clean Layering

The LifeCircle OS mobile client is built using Flutter, implementing **Clean Architecture** patterns combined with **Riverpod** for state management. The codebase is organized using a **feature-first** directory structure to facilitate modular development and long-term maintainability:

### Mobile Module Layout
```
mobile/
└── lib/
    ├── core/
    │   ├── theme/              # Central design tokens and ThemeData generation
    │   ├── security/           # Root detection, keystores, and certificate pinning
    │   ├── observability/      # OpenTelemetry logs and exception filters
    │   └── localization/       # Multi-lingual regional dictionaries
    │
    ├── features/
    │   ├── medicines/          # Bounded Context: Medicines
    │   │   ├── domain/         # Pure Entities and validations
    │   │   ├── application/    # Riverpod controllers and logic coordinate
    │   │   ├── infrastructure/ # Repository implementations, local Isar mappings
    │   │   └── presentation/   # UI Screens, widgets, and state providers
    │   │
    │   ├── finance/            # Bounded Context: Finance (Bills/EMIs)
    │   └── household/          # Bounded Context: Household (Tasks/Helpers)
    │
    └── bootstrap/
        ├── app.dart            # Root application shell wrapper
        ├── router.dart         # Declared navigation paths
        └── providers.dart      # Bootstrap-level Riverpod configurations
```

*Within each feature directory, the clean architecture boundaries are strictly enforced: presentation dependencies flow to application and infrastructure; domain has zero outer dependencies.*

---

## 2. Riverpod State Management Standards

State coordination complies with the following guidelines:
* **AsyncNotifier:** Used for all asynchronous workflows (e.g., executing synchronization calls, loading remote data).
* **Notifier:** Used for synchronous state transitions (e.g., toggling visual views, local layout configurations).
* **StateNotifier:** Permitted only when editing or maintaining legacy codebase modules.
* **Mutable Singletons Forbidden:** State must be declared and managed exclusively within Riverpod providers; no global mutable variables are permitted.
* **Business Logic Separation:** Business rules belong strictly to application use-cases and services. Riverpod UI providers must act as thin adapters communicating with UI views.

---

## 3. CPU execution & Isolate Policy

To keep the main UI thread free of frame drops and jank, expensive CPU operations are explicitly delegated:

### Isolate Execution Policy
* **Isolate Workers (Background Threading):** Used for JSON parsing of payloads exceeding **100KB**, image processing/scaling, cryptographic calculations, compression/decompression operations, database data imports/exports, and any processing task exceeding frame timing budgets.
* **Async / Await (Main Thread Event Loop):** Used for HTTP network calls, standard database reads/writes, and lightweight state modifications.

---

## 4. Offline-First Storage & Synchronization

* **Encrypted Isar Database:**
  * Stores data locally.
  * Local databases are encrypted at rest using **AES-256-GCM**. Encryption keys are generated on-device and stored securely in Android Keystore / iOS Keychain.
* **Sync Outbox Pattern:**
  * All user mutations are stored locally inside the `SyncOutbox` database table.
  * The background **Sync Manager** operates independently, scanning the outbox queue, executing adaptive synchronization triggers (based on battery and connection), and pushing updates to the backend Coordination Platform.
  * Conflict resolution schemas are handled in accordance with Bounded Context definitions.

---

## 5. Mobile Memory Governance

To prevent memory accumulation in long-lived family applications:
* **Controller Disposal:** All `AnimationControllers` and `TextEditingControllers` must be explicitly disposed of.
* **Subscription Cleanup:** All `StreamSubscriptions` and asynchronous listeners must be cleaned up in state lifecycle close routines.
* **Lifecycle Context:** Never retain static references to `BuildContext` outside the widget lifecycle.
* **Widget Tree Isolation:** Avoid static references to widget trees inside singletons or controllers.
* **Leak Profiling:** Mandatory memory leak tracking audits must run prior to major release candidates.

---

## 6. Mobile Security & Compliance Guidelines

All client code must align with OWASP MASVS and MASTG guidelines:

### Root/Jailbreak Policy
* The client detects compromised operating system environments on launch.
* If a root/jailbreak is detected, the application disables sync features, requires explicit user acknowledgement, and prevents high-risk database mutations.
* *Wiping local keychains or databases automatically is prohibited (preventing accidental loss of critical family records).*

### Screenshot Protection Policy
* Screenshot captures and device overlay displays are disabled at the OS level on sensitive screens:
  * Login & Passcode screens.
  * Biometric prompts.
  * Financial summaries and ledgers.
  * Recovery key configurations.
  * Security credential views.
* Non-sensitive dashboards (such as general chore lists) may permit screenshots.

### Network Controls
* **Certificate Pinning:** The mobile network client enforces SSL certificate pinning using SHA-256 hashes of the API Gateway CA certificates.

---

## 7. Flutter Plugin Governance

To prevent dependency rot and security vulnerabilities:
* New plugins require a formal evaluation covering: Security, copyleft licenses, null-safety compliance, active maintenance, and multi-platform validation.
* Every added plugin must have a registered removal or replacement plan in case of project abandonment.
* *Plugins without active maintenance within the past 12 months shall not be introduced.*

---

## 8. Institutional Mobile Principle

> **Core Philosophy:**  
> The client app is the family's direct window into the platform. It must run securely, behave predictably, remain accessible to elders, and operate offline without compromise.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
