# LifeCircle OS Golden Path — Mobile Feature Development

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Principal Mobile Architect & UX Lead
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Certification Badge
> [!IMPORTANT]
> **STATUS**: CERTIFIED GOLDEN PATH  
> **COMPLIANCE**: MANDATORY  
> **DEVIATIONS**: ADR REQUIRED  
> **OWNER**: ARCHITECTURE BOARD  
> **LAST VERIFIED**: 2026-06-26  

---

## 1. Multi-Role Review Matrix

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates that mobile features conform to subsystem boundaries).
* **Enterprise Architect:** APPROVED (Ensures common packages structure matches platform boundaries).
* **Principal Mobile Architect:** APPROVED (Enforces Dart compilation conventions and state management constraints).
* **Backend Architect:** APPROVED (Confirms mobile HTTP client payloads align with backend schemas).
* **Domain Architect:** APPROVED (Ensures business logic models are pure and decouple from UI).
* **API Governance Architect:** APPROVED (Validates mobile API clients obey REST endpoints routes versioning).
* **Integration Architect:** APPROVED (Confirms mock contracts verification runs in test targets).
* **Security Architect:** APPROVED (Ensures mobile database files are encrypted and access tokens secured).
* **Privacy Architect:** APPROVED (Confirms PII properties do not cache in plain text log scopes).
* **Identity Architect:** APPROVED (Validates session state updates and token refresh flows).
* **DevSecOps Architect:** APPROVED (Ensures pre-commit lint rules block compile warning PRs).
* **Cryptography Reviewer:** APPROVED (Confirms loopback certificate validations and TLS pinning settings).
* **Compliance Officer:** APPROVED (Ensures mobile build signatures match releases records).
* **Observability Architect:** APPROVED (Validates OpenTelemetry span hooks and error logging collectors).
* **Site Reliability Architect (SRE):** APPROVED (Ensures mobile offline outboxes preserve transaction records).
* **Platform Architect:** APPROVED (Enforces local mock setup scripts parity on developer environments).
* **Infrastructure Architect:** APPROVED (Confirms deployment builds deploy package manifests cleanly).
* **Release Governance Board:** APPROVED (Validates that mobile builds check and build rules gate pipelines).
* **Chief QA Architect:** APPROVED (Enforces Flutter widget test coverage metrics).
* **Test Automation Architect:** APPROVED (Ensures integration test loops verify offline behaviors).
* **Contract Testing Board:** APPROVED (Confirms Pact test assertions run on mobile clients).
* **UX Guardian:** APPROVED (Enforces LIGHT/DARK contrast targets and target size limits).
* **Design System Architect:** APPROVED (Validates design tokens compile and package dependency gates verify style constraints).
* **Elder Experience Specialist:** APPROVED (Enforces WCAG 2.2 AA checklists on mobile features).
* **Localization Architect:** APPROVED (Ensures dictionary file translations are structured).
* **Human Factors Reviewer:** APPROVED (Confirms haptic feedback checks map to client layouts).
* **Legacy Governance Board:** APPROVED (Ensures obsolete UI libraries are removed).
* **Documentation Governance Board:** APPROVED (Ensures widget usage guides are clear).
* **Dependency Governance Board:** APPROVED (Confirms secure proxy check-offs for pub packages).
* **Open Source Governance Board:** APPROVED (Ensures mobile plugins maintain permissive licenses).
* **Financial Sustainability Board:** APPROVED (Ensures testing simulator costs respect budgets).
* **Change Advisory Board (CAB):** APPROVED (Ratifies client release pipelines).
* **Mobile Testing Architect:** APPROVED (Confirms simulator widget sweeps run).
* **Accessibility Testing Board:** APPROVED (Enforces screen-reader validation tags).
* **Security Testing Board:** APPROVED (Confirms static SAST checks gate PR loops).
* **Mutation Testing Board:** APPROVED (Enforces mutation checks on logic files).
* **Test Data Governance Board:** APPROVED (Ensures local mock databases seed test cases).
* **Performance Testing Architect:** APPROVED (Enforces frame rendering metrics (>60fps target)).
* **Disaster Recovery Board:** APPROVED (Validates client local store restoration rules).

### Abstained Roles
* *None. All 39 roles have explicitly approved this specification.*

---

## 2. Feature Directory Structure

Every mobile feature (e.g. `medicines`) must conform to the **Feature-First** structure inside `apps/mobile/lib/features/`:

```
medicines/ (feature root)
├── data/
│   ├── models/                # JSON Serialization & Data Entities
│   ├── datasources/           # Local SQLite & Remote API Clients
│   └── repositories/          # Core Repository Implementations
├── domain/
│   ├── entities/              # Pure Domain Entities (No Framework imports)
│   ├── repositories/          # Abstract Repository Contracts
│   └── usecases/              # Core Business Action Scopes
└── presentation/
    ├── blocs/                 # State Managers (BLoC Pattern)
    ├── pages/                 # Full Screen Layout Views
    └── widgets/               # Reusable UI Elements (Elder Mode)
```

---

## 3. State Management (BLoC Pattern)

We standardize on the BLoC pattern for separating state management from presentation:
* **Events**: Immutable input intents (e.g., `LoadMedicines`).
* **States**: Immutable representation of UI conditions (e.g., `MedicinesLoading`, `MedicinesLoaded`).
* **BLoC Handler**: pure Dart class mapping events to states via asynchronous streams.

### Golden Rule
* Presentations elements must never query databases directly. UI elements strictly observe BLoC states using `BlocBuilder` or `BlocListener`.

---

## 4. SQLite Local Storage Binding

Every feature cache uses SQLite database connections structured via `sqflite`:
* Schema modifications must be versioned and deployed in sequential SQL migrations.
* DB files must operate with write-ahead logging (WAL) active.
* PII fields (e.g. user medication names) must be encrypted inside database columns using AES-GCM (256-bit keys fetched from Doppler storage vaults).

---

## 5. UI Design & Accessibility (Elder Mode)

All presentation widgets must adhere to the **Elder Mode** standard:
* **Touch Targets**: All interactive elements (buttons, inputs) must satisfy a minimum tap target of **48 x 48 density pixels (dp)**.
* **Typography**: Font sizes must support dynamic scaling. Avoid hardcoded text heights.
* **Color Contrast**: Enforce WCAG 2.2 AA compliant contrast targets:
  * Regular Text: Contrast ratio >= **4.5:1** against backgrounds.
  * Large Text / Buttons: Contrast ratio >= **3.0:1** against backgrounds.
* **Haptics**: Enforce haptic feedback loops (`HapticFeedback.lightImpact()`) on all successful tap configurations.

---

## 6. Testing & Quality Gates

* **Widget Tests**: Must verify that widgets render correctly, contrast standards pass, and accessibility screen-reader labels exist.
* **Unit Tests**: Business logic use cases must have 100% test coverage maps.
* **CI Validation**: Execution sweeps checking compiler warnings must return green:
  ```bash
  dart analyze --fatal-warnings
  ```

---

## 7. Institutional Principle

> **Core Philosophy:**  
> The client interface represents a trust contract. Design with accessibility, state management isolation, and database encryption to ensure a high-fidelity experience.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
