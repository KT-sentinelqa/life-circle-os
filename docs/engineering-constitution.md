# LifeCircle OS — Engineering Constitution

> **Status:** Locked (v1.0)  
> **Author:** Gemini (Implementation Engineer)  
> **Reviewed & Approved By:** Krishna & ChatGPT Architecture Board  
> **Date:** June 26, 2026  

---

## 1. Core Philosophy & Purpose

LifeCircle OS is not a disposable start-up project designed to be rewritten every few years. It is built as a multi-decade digital family institution. The code we write today must remain clear, readable, and functional in the year **2076**. 

Our engineering decisions are guided by a simple mandate: **build code that behaves like a physical house—sturdy, secure, and easily maintainable across generations.**

```
┌────────────────────────────────────────────────────────┐
│             LIFECIRCLE OS SYSTEM LAYERING              │
├────────────────────────────────────────────────────────┤
│   Presentation (FastAPI HTTP Routers, Flutter Widgets) │
│                        │                               │
│                        ▼                               │
│   Application Services (Use Cases, Coordination APIs) │
│                        │                               │
│                        ▼                               │
│   Domain Model Core (Pure Entities, Rules, Events)     │
│                        │                               │
│                        ▼                               │
│   Infrastructure (PostgreSQL DB, Redis Cache, API Client)│
└────────────────────────────────────────────────────────┘
```

---

## 2. Architecture Decision Hierarchy

Priority order for resolving conflicts, designs, and implementations:
1. **Vision.md**
2. **PRD.md**
3. **Engineering Constitution**
4. **ADRs (Architecture Decision Records)**
5. **RFCs (Request for Comments)**
6. **Implementation Code**

*If conflicts arise, higher-order documents always prevail. Code must never override architecture.*

---

## 3. Technology Stack, Toolchain & Directory Structure

To maintain consistency and durability, the technical stack and toolchains are strictly locked:

### Approved Toolchain
* **Python Platform:** `ruff` (formatting and linting), `mypy` (static typing), `pytest` (unit and integration tests), `coverage` (test coverage), `bandit` (static security scans).
* **Flutter Mobile Platform:** `dart analyze` (static analysis), `flutter test` (unit and widget tests), Golden Tests (UI regression checks), and integration tests.

### Standard Project Layout
```
lifecircle-os/
├── .agents/                    # Workspace agent guidelines (AGENTS.md)
├── docs/                       # Locked design and governance documents
├── backend/                    # FastAPI Backend Platform
│   ├── src/
│   │   ├── domain/             # Pure Business Logic (No DB/HTTP leakage)
│   │   ├── application/        # Use Cases & Application Services
│   │   ├── infrastructure/     # Database adapters, cloud caches, SMTP, etc.
│   │   └── presentation/       # API routers, request/response models, middleware
│   └── tests/                  # Unit, Integration, & Contract Tests
└── mobile/                     # Flutter Mobile Client
    ├── lib/
    │   ├── domain/             # Pure Entities and Logic
    │   ├── application/        # Riverpod Controllers & Business Use Cases
    │   └── presentation/       # Widgets, Screens, & Adaptive Layouts
    └── test/                   # Widget, Unit, and Golden Tests
```

---

## 4. Bounded Context & Layering Commandments

All development must strictly adhere to the following architectural rules:

### Domain-Driven Design (DDD)
* **Isolated Bounded Contexts:** The system is divided into clear contexts: `Medicines`, `Finance`, `Household`, and `Identity`. 
* **Data Ownership:** Bounded contexts own their data. No direct shared databases or tables are permitted.
* **Strict Integration Boundaries:** No cross-context writes. Integration between domains occurs through application services and domain events only.

### Dependency Inversion & Clean Architecture
* Core domain models must be pure. They shall not import databases, network libraries, or frameworks (e.g., no raw FastAPI imports or SQLModel imports inside `domain/`).
* Outer layers (Infrastructure and Presentation) depend on the Domain; the Domain must never depend on the outer layers.

### Naming Conventions
* Variable, function, and class names must be explicit and self-documenting. 
* Changing naming standards or adding global patterns requires an approved Architecture Decision Record (ADR).

---

## 5. Engineering Standards & Constitutions

### Mobile Engineering Standards
The mobile application shall guarantee:
* **60 FPS Minimum:** Smooth animations across all supported devices.
* **120 Hz Optimization:** Fluid rendering on flagship hardware.
* **Native Haptics:** Subtle sensory feedback for interactive events.
* **Reduced-Motion Support:** Adapting layouts to motion preferences.
* **Battery Consumption:** Below 3% active usage per hour.
* **Platform-Adaptive Navigation:** Seamless adaptation between iOS and Android.
* *Animation exists to communicate state, never to entertain.*

### Security Constitution
Mandatory security standards must be enforced:
* **Mobile Client:** Full compliance with OWASP MASVS and OWASP MASTG guidelines, and mitigation of OWASP Mobile Top 10 vulnerabilities.
* **Backend Platform:** Strict adherence to OWASP ASVS guidelines, mitigating OWASP API Security Top 10 and OWASP Top 10 vulnerabilities.
* **Infrastructure & Supply Chain:** CIS Benchmarks validation, Software Bill of Materials (SBOM) generation, signed build artifacts, and automated secrets detection scans.
* **Verification Pipelines:** Continuous SAST, DAST, SCA, IaC scanning, container vulnerability scanning, and secrets checking.

### Performance Constitution
We execute operations within strict performance budgets:
* **API P95 Latency:** < 300ms.
* **API P99 Latency:** < 700ms.
* **Database Queries:** < 100ms.
* **UI Screen Render:** Critical screens load within < 500ms.
* **Cold Start Time:** < 2 seconds on mobile.
* **Battery Budget:** < 3% active usage per hour.
* *No synchronous blocking calls are permitted on UI threads. Database queries must be indexed, and offline actions must complete instantly.*

### Accessibility Constitution
Accessibility regressions block releases. All interfaces must support:
* WCAG 2.2 AA standard.
* Text scaling (Dynamic Type up to 200%).
* VoiceOver (iOS) and TalkBack (Android) screen readers.
* Reduced Motion preference support.
* High Contrast themes.
* Full keyboard navigation compatibility.
* Zero hidden gestures (no swipes or double-taps required for core actions).
* Minimum 48dp touch targets.

### Observability Constitution
Every capability must emit structured telemetry:
* **Infrastructure Telemetry:** Structured logs, traces, Prometheus metrics, Grafana dashboards, Sentry error logs, Correlation IDs, and Audit IDs.
* **Approved Tooling:** OpenTelemetry, Prometheus, Grafana, and Sentry.
* **Business Metrics:** Aggregate, anonymous tracking of medicine adherence, EMI completion, household task completion, and premium subscription conversions.
* *Personal user content shall never be logged under any operational metrics.*

### Disaster Recovery Constitution
* **RTO (Recovery Time Objective):** 1 hour.
* **RPO (Recovery Point Objective):** 15 minutes.
* **Drills:** Quarterly restoration drills are mandatory.
* **Offline Continuity:** Offline continuity is mandatory. Cloud outages or platform database failures must not prevent critical household operations.

---

## 6. Coding & Comment Standards

* **Readable over Clever:** Prefer boring, explicit, and verbose code over clever, compressed, or high-magic code. Avoid heavy runtime reflection, dynamic typing hacks, or metaprogramming where simple functions suffice.
* **Zero Warnings Policy:** Build configurations must treat compiler warnings as failures (`dart analyze --fatal-warnings`, `mypy --strict`).
* **Comment Integrity:** Maintain all existing comments, docstrings, and headers. Every file must begin with a standardized header stating its domain, purpose, and ownership.

---

## 7. Quality Gates & Build Verification

Every change (Pull Request) must run through the quality gates pipeline:
```
Formatting & Linting (Ruff/Dart) → Static Analysis (MyPy/Dart) → Security Scan (SAST/SCA/Secrets) → Dependency Validation (Licensing) → Architectural Fitness Check → Unit & Integration Tests (90%+) → Accessibility & Performance Audit → Manual Review & Sign-Off
```

### Security Gates & Fitness Rules
The build **SHALL FAIL** if:
1. **Circular Dependencies:** Any circular references are detected between packages or contexts.
2. **Code Coverage Decreases:** Test coverage drops below the established target (90% minimum on all domain code).
3. **Duplication Exceeds 1%:** Any duplicate block of business logic exceeds 1% of the codebase volume.
4. **Outdated Documentation:** New features are added without accompanying ADRs, RFC updates, or updated API specs.
5. **Accessibility Regressions:** Automated checks detect WCAG AA layout failures.
6. **Vulnerabilities Present:** Critical or High security warnings are triggered.
7. **Secrets Detected:** Credentials or API keys are detected in code scans.
8. **License Validation Fails:** Any package is imported with unapproved licenses.
9. **SBOM Generation Fails:** The software inventory cannot be generated.

---

## 8. Institutional Engineering Principle

> **Core Philosophy:**  
> LifeCircle OS is an institution, not merely software. The business domains endure. Technologies evolve. Trust remains permanent. Engineers are custodians, not owners, of the system.

🙏 श्री गणेशाय नमः
