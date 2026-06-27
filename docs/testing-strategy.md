# LifeCircle OS — Testing Strategy & Quality Assurance Framework

> **Status:** Locked (v1.0)  
> **Author:** Gemini (Implementation Engineer)  
> **Reviewed & Approved By:** Krishna & ChatGPT Architecture Board  
> **Date:** June 26, 2026  

---

## 1. Quality & Testing Philosophy

To construct a digital family institution that runs reliably for decades, LifeCircle OS rejects the "move fast and break things" startup ethos. We design code carefully, verify operations continuously, and enforce strict quality boundaries. 

Our testing philosophy is guided by three principles:
* **Test-Driven Domain Design:** Business logic is written in decoupled, pure domains, making it naturally testable.
* **Continuous Quality Gates:** Testing is embedded into every commit and pull request. Code changes cannot bypass verification.
* **Diverse Signal Validation:** Uptime and correctness are verified across multiple testing vectors—including unit, integration, contract, security, performance, and accessibility tests.

---

## 2. Testing Pyramid Policy

We distribute our automated test suites to optimize for rapid feedback, maintainability, and resource efficiency:
* **70% Unit Tests:** Verifying core domain models, use cases, rules, and local controllers.
* **20% Integration Tests:** Verifying local/cloud database operations, transactions, and RabbitMQ events.
* **8% Contract Tests:** Verifying API requests and responses.
* **2% End-to-End (E2E) Tests:** Verifying top-level execution paths and high-risk workflows.
* *UI automation must remain small. Fast feedback loops are prioritized.*

```
┌────────────────────────────────────────────────────────┐
│               TESTING PYRAMID STRUCTURE                │
├────────────────────────────────────────────────────────┤
│   2% E2E / UI Automation Tests                         │
│     │                                                  │
│     ├─► 8% Contract (Pact-style schema)                │
│     └─► 20% Integration (DB transactions, RabbitMQ)    │
│                                                        │
│   70% Unit Tests (90%+ Domain Coverage)                │
│     ├─► FastAPI Business Use Cases                     │
│     └─► Flutter Riverpod View Controllers              │
└────────────────────────────────────────────────────────┘
```

---

## 3. Test Classification & Frameworks

We categorize our test suites into distinct layers, using locked tools and frameworks:

### Unit Tests
* **Backend Platform (Python):** `pytest` + `pytest-cov`.
* **Mobile Client (Flutter/Dart):** `flutter test`.
* **Coverage Target:** Minimum **90% test coverage** on all core domain logic is mandatory.

### Integration Tests
* **Backend Platform:** Verifies DB transactions and event routing through RabbitMQ queue infrastructure. Runs against fresh Docker containers (PostgreSql and Redis).
* **Mobile Client:** Widget testing and Golden tests to verify layout fidelity.

### Property-Based Testing
To strengthen correctness guarantees beyond example-based testing, property-based tests are mandatory for financial calculations, date logic, synchronization rules, and conflict resolution engines:
* **Python Tool:** `Hypothesis`.
* **Dart Tool:** `property_test`.

### Mutation Testing Policy
To verify test quality beyond simple code coverage metrics:
* **Critical Domains:** `Medicines`, `Finance`, `Synchronization`, and `Security` controls.
* **Score Target:** Minimum **85% mutation score** required.
* **Run Schedule:** Mutation test suites execute nightly, on release candidates, and during high-risk schema/domain edits.

---

## 4. Contract, Security & Performance Testing

### Consumer-Driven Contract Testing
* Contracts are owned strictly by consumers (the mobile app).
* Providers (the backend) must verify contracts using Pact-style verification principles before release.
* Continuous deployment pipelines must enforce `can-i-deploy` checks to prevent breaking schema changes.

### Security Testing Types
Continuous automated security validation must run:
* **Static Testing:** SAST (Static Application Security Testing) and IaC configuration checks.
* **Composition Audit:** SCA (Software Composition Analysis) dependency license and vulnerability scanning.
* **Secrets Scan:** Continuous scanning of codebase logs to prevent credential leakage.
* **Dynamic Testing:** Automated DAST (Dynamic Application Security Testing) scanning.
* **Penetration Validation:** Mandatory mobile and API penetration testing protocols.

### Performance Testing Strategy
Performance validation must verify:
* **Traffic Scenarios:** Load testing, stress testing, spike testing, and capacity testing.
* **Resilience:** Endurance testing under continuous transaction flows.
* **Mobile Auditing:** Frame rendering profiling (60 FPS baseline, native 120Hz support, zero dropped frames, battery efficiency) and active battery consumption audits (< 3% usage per hour).

---

## 5. Accessibility Testing

All critical journeys must support accessibility standards. Accessibility defects carry the same priority severity as functional defects and block releases:
* Automated and manual validation using VoiceOver (iOS) and TalkBack (Android).
* Layout verification under 200% Dynamic Type text scaling.
* Visual verification with reduced motion settings enabled.
* Verification of minimum 48dp touch targets, high contrast themes, keyboard navigation, and zero hidden gestures.

---

## 6. Developer Verification & Test Data Policies

### Developer Verification Policy
Every engineer must execute the following checks locally before pushing code to the Git repository. CI is used for official verification, not discovery of simple errors:
* Code formatting checks.
* Static lint analysis.
* Unit and property-based tests.
* Consumer contract tests.
* Security secrets scans.

### Test Data Policy
Production database information shall never be used for testing. Access is restricted to:
* Synthetic datasets generated via schema factories.
* Anonymized fixtures modeling family profiles.
* Deterministic seeds to guarantee reproducibility.
* Version-controlled, checked-in test datasets.

---

## 7. CI/CD Quality Gates

Every pull request must pass the automated GitHub Actions pipeline. The build **SHALL FAIL** if:
* Code lint or type analysis contains warnings.
* Domain code test coverage falls below 90%.
* Code duplication exceeds 1%.
* Circular dependencies are detected.
* Secrets or vulnerability scans report errors.
* Accessibility or performance budgets are violated.

---

## 8. Institutional Testing Principle

> **Core Philosophy:**  
> Untested code is undocumented behavior. Passing tests create confidence. Meaningful tests create trust. Trust is the foundation of LifeCircle OS.

🙏 श्री गणेशाय नमः
