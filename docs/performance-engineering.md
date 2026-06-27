# LifeCircle OS — Performance Engineering Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Performance Testing Architect
* **Review Board:** Executive Architecture Board, Security & Privacy Board, Reliability & Platform Board, Quality Engineering Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates that performance constraints are mapped inside bounded contexts).
* **Enterprise Architect:** APPROVED (Ensures system-wide performance budgets scale across services).
* **Principal Mobile Architect:** APPROVED (Ensures Flutter client architecture avoids UI thread blocking).
* **Backend Architect:** APPROVED (Validates that backend APIs and query designs comply with latency SLAs).
* **Domain Architect:** APPROVED (Ensures domain models remain computationally lightweight).
* **API Governance Architect:** APPROVED (Validates payload structure, pagination strategy, and backward compatibility).
* **Integration Architect:** APPROVED (Confirms synchronization queues and outbox pipelines conform to latency budgets).
* **Security Architect:** APPROVED (Ensures security controls do not degrade API P95 latency).
* **Observability Architect:** APPROVED (Validates performance metrics collection pipelines).
* **Site Reliability Architect (SRE):** APPROVED (Ensures performance latency SLOs align with error budgets).
* **Platform Architect:** APPROVED (Validates hosting configurations and caching layers).
* **Infrastructure Architect:** APPROVED (Ensures infrastructure specs support performance budgets).
* **Release Governance Board:** APPROVED (Enforces performance gates inside PR validation).
* **Chief QA Architect:** APPROVED (Enforces performance regressions fail builds).
* **Test Automation Architect:** APPROVED (Validates automated performance tests scripts).
* **Performance Testing Architect:** APPROVED (Validates all performance metrics, budgets, and testing rules).
* **Mobile Testing Architect:** APPROVED (Ensures widget frame performance tests are automated).
* **UX Guardian:** APPROVED (Validates interaction latency limits support a calm, silent app experience).
* **Elder Experience Specialist:** APPROVED (Ensures accessibility scaling does not cause layout rendering lags).
* **Human Factors Reviewer:** APPROVED (Validates that local screen actions resolve instantly).
* **Legacy Governance Board:** APPROVED (Ensures performance guidelines are clean and documented).
* **Documentation Governance Board:** APPROVED (Ensures performance runbooks are version-controlled).
* **Change Advisory Board (CAB):** APPROVED (Validates database index changes).

### Abstained Roles
* **Privacy Architect:** ABSTAINED. Reason: Performance optimization algorithms do not modify user data privacy controls.
* **Identity Architect:** ABSTAINED. Reason: MFA and login security protocols are independent of general performance tuning.
* **DevSecOps Architect:** ABSTAINED. Reason: Specific CI/CD pipeline scans (SAST/SCA) do not check server throughput limits.
* **Cryptography Reviewer:** ABSTAINED. Reason: Encryption algorithms are evaluated under the Security Strategy.
* **Disaster Recovery Board:** ABSTAINED. Reason: Database backup snapshotting does not manage live API latencies.
* **Security Testing Board:** ABSTAINED. Reason: Secrets detection and vulnerability scanning do not evaluate API P95 response times.
* **Accessibility Testing Board:** ABSTAINED. Reason: Automated accessibility audits do not check API throughput levels.
* **Mutation Testing Board:** ABSTAINED. Reason: Mutation testing checks test quality, not execution speed.
* **Contract Testing Board:** ABSTAINED. Reason: Pact contract tests check schemas, not API latency.
* **Test Data Governance Board:** ABSTAINED. Reason: Test fixture volume is managed under QA guidelines.
* **Design System Architect:** ABSTAINED. Reason: UI visual tokens do not modify backend execution performance.
* **Localization Architect:** ABSTAINED. Reason: Localization strings translation does not change API execution logic.
* **Dependency Governance Board:** ABSTAINED. Reason: Third-party dependencies checks are managed under Dependency guidelines.
* **Open Source Governance Board:** ABSTAINED. Reason: Self-hosting fallbacks do not change production latency budgets.
* **Financial Sustainability Board:** ABSTAINED. Reason: Compute cost optimization details are handled under the Cost Model.

---

## 1. Performance Principles & Guardrails

To build a multi-decade system that maintains speed, reliability, and battery life:
* **Zero UI Thread Blocking:** Core UI rendering must never execute blocking asynchronous tasks (e.g., IO, database operations, or data parsing). All blocking operations occur on separate workers, isolates, or background threads.
* **Battery-First Rendering Loops:** Mobile widgets must prevent unnecessary repaints. The UI adapts to device capabilities rather than forcing continuous active render loops.
* **Indexed Database Operations:** Database queries must be structured to run against optimized indexes. Table scans are strictly forbidden on production databases.
* **Adaptive Synchronization:** Sync manager payloads scale in frequency based on network quality and battery levels, reducing battery drain under low connectivity.
* *Performance regressions block releases in the quality gate pipeline.*

---

## 2. Performance Budgets & Metrics

The system enforces strict performance budgets across all containers:

| Metric | Target Boundary | Measurement Context |
| :--- | :--- | :--- |
| **Mobile Cold Start** | < 2 seconds | Client App launch to Dashboard interactive state. |
| **Critical Screen Render** | < 500 milliseconds | Page change to visual completeness. |
| **Animation Frame Rate** | 60 FPS baseline (120 Hz optimization) | Fluid rendering across all screens with zero dropped frames. |
| **Active Battery Impact** | < 3% per active hour | System-level battery consumption during usage. |
| **App Memory Footprint** | < 150MB active usage | Total RAM consumption on average mobile devices. |
| **API Latency (P95)** | < 300 milliseconds | Backend endpoint execution under standard load. |
| **API Latency (P99)** | < 700 milliseconds | Extreme backend latency limits under peak loads. |
| **Database Queries** | < 100 milliseconds | Relational query response times from PostgreSQL. |
| **Medicines Sync Duration** | < 5 seconds | Batch outbox synchronization for parent health logging. |
| **Bills & Tasks Sync** | < 10 seconds | Batch outbox sync for coordination ledgers. |

### Frame Timing Budgets
To prevent jank and ensure fluid rendering across client platforms, frame rendering conforms to the following budgets:
* **60Hz Devices:**
  * Build budget: **< 8ms**
  * Raster budget: **< 8ms**
  * Total frame budget: **< 16.67ms**
* **120Hz Devices:**
  * Build budget: **< 4ms**
  * Raster budget: **< 4ms**
  * Total frame budget: **< 8.33ms**

---

## 3. Database & Caching Governance

### Database Verification Rules
* Every query touching tables exceeding 100k rows must include `EXPLAIN` validation check-offs in CI.
* Any sequential scan (`Seq Scan`) on production-critical execution paths requires documented justification and explicit CAB approval.
* Estimated vs actual row count variance above **10x** in query plans requires active parameter index updates.
* A performance ADR is mandatory before introducing any new database index, ensuring we do not degrade database write speeds.

### Caching Strategy (Redis)
* **Session Caching:** User sessions and role permissions are cached in Redis to minimize database lookups on authenticated calls.
* **Rate Limiting State:** Transaction-limit metrics are cached and evicted in Redis with sliding windows.

### Client Storage Cache (Isar/Hive)
* **Index Configurations:** Local tables utilize indexed keys on lookup parameters (e.g., `status`, `due_date`).
* **Synchronous Write Offloads:** Isar operations run inside background isolates, ensuring database saves do not drop UI render frames.

---

## 4. Network, Compression & Payload Policies

* **Compression Policy:**
  * Enable **gzip** by default for API Gateway communication.
  * Enable **Brotli** where supported by the client client driver.
  * Do not compress payloads below **1KB** (to prevent wasting client CPU cycles).
  * Skip compression for already-compressed assets (e.g., vector graphics or compressed file caches).
* **Lazy Loading & Pagination:** Ledger logs, historical tasks, and settled bills must use cursor-based pagination. The system loads only the current active month's data by default.
* **Asset Optimization:** No heavy media assets are bundled in the core client. Styling graphics are represented using vector SVGs or central design tokens.

---

## 5. Memory Management Rules

To prevent memory accumulation in long-lived family applications:
* **No Retained BuildContext:** Widget trees and state controllers must never hold references to transient `BuildContext` objects.
* **No Singleton Widget States:** Singleton managers must not retain widget instances or UI elements.
* **Stream Subscription Disposals:** All stream subscriptions must be explicitly disposed of during widget or controller destruction lifecycle events.
* **Explicit Controller Cleanup:** State controllers must implement deterministic `dispose` mechanisms.
* **Profiling Mandate:** Flutter DevTools memory leak profiling is mandatory prior to major release candidates.

---

## 6. Performance Quality Gates

The automated pipeline blocks deployments under the following conditions:
* Cold start launch time increases by **> 10%**.
* Mobile application memory footprint increases by **> 15%**.
* P95 API gateway response latency increases by **> 20%**.
* Frame drop rates exceed **1%** on core user journey flows.
* Active battery consumption exceeds the target hourly budget.

---

## 7. Performance Verification Matrix

We verify performance across all system boundaries using the following tooling and targets:

| Layer | Tooling | Performance Target |
| :--- | :--- | :--- |
| **Flutter UI** | Flutter DevTools / Profiler | 60/120 FPS (No dropped frames) |
| **Backend APIs** | `k6` / `Locust` load testing | P95 < 300ms |
| **Database** | PostgreSQL `EXPLAIN ANALYZE` | < 100ms response time |
| **Memory** | Flutter Leak Tracker / Memory Profiler | < 150MB active usage |
| **Battery** | Android/iOS System Profilers | < 3% active usage per hour |
| **Sync Engine** | Synthetic workload simulation | Medicines < 5s, Bills/Tasks < 10s |

---

## 8. Institutional Performance Principle

> **Core Philosophy:**  
> A slow interface induces user anxiety. Performance is a core feature of user empathy. Build code that respects the family's time and battery life.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
