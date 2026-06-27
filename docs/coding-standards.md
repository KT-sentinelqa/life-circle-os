# LifeCircle OS — Coding Standards Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Quality Engineering Board & Principal Architects
* **Review Board:** Executive Architecture Board, Mobile Architecture Board, Backend Architecture Board, Security & Privacy Board, Reliability & Operations Board, Quality Engineering Board, Governance Board, Documentation Board, Change Advisory Board (CAB)
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Confirms coding standards maintain DDD bounded context isolation and modularity).
* **Enterprise Architect:** APPROVED (Ensures deprecation rules and evolution matrices support 50-year system viability).
* **Principal Mobile Architect:** APPROVED (Validates Flutter/Dart coding standards, widget tree performance budgets, and lint checks).
* **Backend Architect:** APPROVED (Validates Python 3.12 static check requirements, FastAPI payload constraints, and ORM usage).
* **Domain Architect:** APPROVED (Enforces strict domain purity, blocking database/HTTP leakage in domain files).
* **API Governance Architect:** APPROVED (Validates API contract compatibility and deprecation cycle rules).
* **Integration Architect:** APPROVED (Ensures event serializations and messaging models obey type safety).
* **Security Architect:** APPROVED (Confirms secure coding rules map directly to OWASP ASVS and MASVS standards).
* **Privacy Architect:** APPROVED (Ensures PII sanitization in logs and data validation routines prevent leaks).
* **Identity Architect:** APPROVED (Ensures JWT tokens and claims handling standards are implemented securely).
* **DevSecOps Architect:** APPROVED (Validates that static linter gates, checkov scans, and complexity limits block PR merges on failure).
* **Cryptography Reviewer:** APPROVED (Ensures cryptographic standard functions are isolated and correctly typed).
* **Compliance Officer:** APPROVED (Confirms that data handling coding guidelines respect GDPR/DPDP requirements).
* **Observability Architect:** APPROVED (Enforces log statement models, ensuring Correlation-ID and Trace-ID are passed).
* **Site Reliability Architect (SRE):** APPROVED (Validates exception handling models to prevent unhandled crashes).
* **Platform Architect:** APPROVED (Validates cache connection isolation and connection pool coding standards).
* **Infrastructure Architect:** APPROVED (Ensures IaC formatting rules and Terraform coding conventions match quality targets).
* **Release Governance Board:** APPROVED (Confirms deprecation tracking tags block early api/library pruning).
* **Chief QA Architect:** APPROVED (Ensures test coverage requirements and mocking conventions protect software health).
* **Test Automation Architect:** APPROVED (Validates test naming conventions and integration test setups).
* **Contract Testing Board:** APPROVED (Ensures contract schemas map directly to typed API models).
* **UX Guardian:** APPROVED (Validates rendering loops coding rules, ensuring zero frames are dropped).
* **Localization Architect:** APPROVED (Enforces localization helper types, blocking hardcoded strings in presentation).
* **Legacy Governance Board:** APPROVED (Enforces verbose and explicit code rules, banning clever or compressed hacks).
* **Documentation Governance Board:** APPROVED (Ensures docstring formatting standards match API docs extraction schemas).
* **Change Advisory Board (CAB):** APPROVED (Validates definition of done and code review checklist gates).
* **Mobile Testing Architect:** APPROVED (Ensures unit test structures match Widget and Bloc testing styles).
* **Accessibility Testing Board:** APPROVED (Enforces widget accessibility labels coding requirements).
* **Security Testing Board:** APPROVED (Confirms that SAST rule configurations align with secure coding guides).
* **Mutation Testing Board:** APPROVED (Enforces logic structures that are testable via mutation analysis checks).
* **Test Data Governance Board:** APPROVED (Ensures test seed datasets are generated via anonymized factories).
* **Design System Architect:** APPROVED (Enforces design tokens variable usage in mobile presentation widgets).
* **Elder Experience Specialist:** APPROVED (Ensures dynamic font size adaptation coding boundaries are respected).
* **Human Factors Reviewer:** APPROVED (Validates touch target coding conventions).
* **Dependency Governance Board:** APPROVED (Validates that all imports obey the approved technology baseline).
* **Open Source Governance Board:** APPROVED (Confirms package file licensing headers code conventions).
* **Financial Sustainability Board:** APPROVED (Validates that resource consumption limits are optimized via clean code constraints).
* **Founder Office:** APPROVED (Validates that code formatting, structures, and documentation conform to long-term stewardship).

### Abstained Roles
* **Disaster Recovery Board:** ABSTAINED. Reason: No backup operations, WAL journaling, or database replication configurations are managed within general coding style guidelines.

---

## 1. Python 3.12 Coding Standards

Backend development uses Python 3.12, adhering to strict static analysis and styling guidelines:

### Standard Toolchain
* **Formatter & Linter:** `ruff` (replaces `black`, `isort`, and `flake8`).
* **Type Checker:** `mypy` (enforces strict static typing checks).
* **Test Framework:** `pytest` (enforces 90%+ domain test coverage).
* **Boundary Checks:** `import-linter` (enforces directory dependency boundaries).

### Ruff Configuration Guidelines
Projects must enable the following Ruff rule subsets in `pyproject.toml`:
* `E`, `W` — Pycodestyle style and warning checks.
* `F` — Pyflakes logic checks.
* `I` — Import order sorting checks.
* `N` — Naming conventions checks.
* `UP` — Pyupgrade modern Python syntax enforcement.
* `B` — Flake8-bugbear safety checks.
* `A` — Built-in shadowing checks.
* `C4` — Comprehensions optimization checks.
* `T20` — Print detection (banned; use structured logging).
* `ARG` — Unused arguments checks.
* `ERA` — Eradicate commented-out code checks.
* `PL` — Pylint complexity and style checking.
* `RUF` — Ruff-specific safety rules.

### Typing & Code Conventions
* **Strict Type Annotations:** Every function signature must define argument types and return type:
  ```python
  def calculate_medicine_dosage(dosage_mg: float, frequency_hours: int) -> float:
      ...
  ```
* **No Mutable Defaults:** Banned in function parameters:
  ```python
  # FORBIDDEN:
  def register_family_member(roles: list[str] = []) -> None: ...

  # ALLOWED:
  def register_family_member(roles: list[str] | None = None) -> None:
      actual_roles = roles or []
  ```
* **Immutable Constructs:** Prefer `typing.Final` and custom generic types for read-only values.
* **Safe Exceptions:** Never catch generic exceptions (`except Exception:`). Always intercept targeted exceptions and wrap them in application boundary exception envelopes.

---

## 2. Flutter/Dart Coding Standards

Mobile development uses the latest Flutter and Dart compiler constraints:

### Standard Toolchain
* **Formatter:** `dart format` (replaces custom project spacing).
* **Static Analysis:** `dart analyze --fatal-warnings` (treats warnings as build failures).
* **Quality Checker:** `dart_code_metrics` (or approved replacement plugins to verify line limits).

### Dart Naming & Formatting
* **PascalCase** for classes, mixins, extension names, and enum types.
* **camelCase** for variable names, constant names, parameter names, and method names.
* **snake_case** for source file names and directory names.
* **Const Constructors:** Mandatory for all widgets containing unchanging layouts:
  ```dart
  const Text('Medicine Schedule', style: TextStyle(fontSize: 16));
  ```
* **Strict Typing:** Banned usage of dynamic types unless explicitly annotated with a type parameter. Specify explicit types for variables instead of using generic `var` when type inference is not obvious.
* **Async Safety:** Never use `async void`. Always return `Future<void>` to allow callers to intercept errors and track execution completion.

---

## 3. Complexity Budgets

To keep the codebase accessible and maintainable across generations, we enforce strict limits on code complexity:

| Scope | Metric | Maximum Limit | Verification Tool |
| :--- | :--- | :--- | :--- |
| **Function / Method** | Cyclomatic Complexity | **10** | Ruff (PLR0911) / dart_code_metrics |
| **Function / Method** | Cognitive Complexity | **10** | Ruff (PLR0912) / dart_code_metrics |
| **Function / Method** | Maximum Length | **50 lines** | Ruff (PLR0915) / dart_code_metrics |
| **Source File** | Maximum Length | **500 lines** | Ruff / dart_code_metrics |
| **Class** | Maximum Length | **200 lines** | Ruff / dart_code_metrics |

*Complexity budgets are checked on every commit. Violations fail the CI pipeline.*

---

## 4. Secure Coding Rules (OWASP Aligned)

All application code must satisfy modern security paradigms:

### Backend Secure Coding Rules (ASVS Aligned)
1. **Input Validation:** Enforce strict type validation using Pydantic models. String parameters must be constrained (e.g. max lengths and regex patterns).
2. **Output Serialization:** Never return raw entities. Always serialize payloads through output schemas to prevent PII or database attributes leakage.
3. **No Raw SQL Construction:** Database queries must use parameterized interfaces or SQLAlchemy ORM patterns to prevent SQL Injection.
4. **Log Sanitization:** Log statements must pass through filter decorators that strip out passwords, credit cards, emails, and names.

### Mobile Secure Coding Rules (MASVS Aligned)
1. **Secure Storage:** Sensitive data (auth tokens, cryptographic secrets) must be stored inside the device's secure keychain (iOS) or Keystore (Android) using validated packages (e.g., `flutter_secure_storage`).
2. **IPC Boundary Restrictions:** Disable broadcast receivers and package sharing unless explicitly declared under a strict trust boundary contract.
3. **Secure Networking:** Enforce TLS 1.3 for all HTTP connections, configure SHA-256 SSL pinning, and block cleartext HTTP traffic.

---

## 5. Deprecation & API Evolution Rules

Code elements must be updated and retired gracefully, avoiding breaking consumer applications:

1. **Explicit Tagging:** Deprecated code must use deprecation tags indicating replacement paths and the removal version:
   * **Python:** Use the `@deprecated` decorator or custom warnings:
     ```python
     import warnings

     @deprecated("Use calculate_dosage_v2 instead. Target removal: v1.5.0")
     def calculate_dosage_v1(...) -> float:
         ...
     ```
   * **Dart:** Use the `@Deprecated` annotation:
     ```dart
     @Deprecated('Use calculateDosageV2 instead. Target removal: v1.5.0')
     double calculateDosageV1(...) { ... }
     ```
2. **Coexistence Policy:** Deprecated methods must coexist with their replacements for at least one minor release cycle.
3. **Zero Deprecation Warnings:** Before promoting a build to release, consumers must replace all calls to deprecated methods. The build will fail if deprecation warnings are emitted during dependency compilations.

---

## 6. Exception Governance Policy

No standard is absolute, but deviations must be managed under strict governance controls to prevent architectural decay.

### Standard Exception Process
```
STANDARD VIOLATION PROCESS
Request
↓
Technical Justification
↓
Board Review
↓
Time-Bound Exception
↓
Removal Plan
↓
Archive (CDR)
```

### Exception Rules
* **No Permanent Exceptions:** All exceptions must have a clear path to remediation.
* **Requirements per Exception:** Every request must explicitly document:
  * **Owner:** The designated role responsible for compliance.
  * **Expiry Date:** A calendar date when the exception expires.
  * **Risk Assessment:** Impact analysis of the temporary violation.
  * **Removal Milestone:** The target release or roadmap sprint for remediation.
* **Enforcement:** Expired exceptions automatically become critical governance violations, immediately blocking CI pipelines.

---

## 7. Architectural Fitness Functions

If architecture cannot be tested automatically, it is not truly institutional. The CI/CD pipeline must execute the following automated verification checks:

### Backend Enforcement
* `ruff check .` — Enforces style and static code quality gates.
* `mypy --strict .` — Ensures strict typing parameters pass validation.
* `pytest --cov` — Monitors unit coverage and fails if logic coverage drops.
* `import-linter` — Asserts package and feature boundary checks.
* `bandit` — Performs automated security auditing scans.
* `pip-audit` — Scans for known third-party dependency vulnerabilities.

### Mobile Enforcement
* `dart analyze --fatal-warnings` — Ensures zero compiler warnings remain.
* `dart test --coverage` — Runs tests and gathers verification coverage stats.
* `dart_code_metrics` — Enforces cyclomatic and cognitive budgets.
* `flutter test --update-goldens=false` — Audits visual widget regression runs.

### Repository Infrastructure
* `make architecture` — Validates dependency flow direction constraints.
* `make verify` — Triggers GitGuardian, checkov, and tfsec checks.

---

## 8. Definition of Ready (DoR) & Definition of Done (DoD)

### Definition of Ready (DoR)
A task is ready to begin implementation only when:
* [ ] Requirements and user acceptance criteria are fully specified and approved by the Product owner.
* [ ] External dependencies are identified, approved, and available.
* [ ] Security and privacy constraints (e.g., PII tracking details) are documented.
* [ ] Design assets (for mobile layouts) are published and approved in the Design System.
* [ ] Any naming standard changes are approved via an ADR.

### Definition of Done (DoD)
A task is complete and ready to merge only when:
* [ ] Code compiles without warnings (`Zero Warnings Policy`).
* [ ] Code conforms to Python 3.12 / Flutter-Dart formatting standards.
* [ ] Static analysis tools (`mypy`, `dart analyze`) and complexity budgets pass successfully.
* [ ] Code coverage is maintained or improved (minimum 90% core coverage).
* [ ] Security scanning (`tfsec`, `checkov`, `bandit`) returns zero issues.
* [ ] All tests (unit, integration, widget, goldens) pass green in the pipeline.
* [ ] Documentation (Markdown specifications, docstrings, ADRs, CDRs) is updated.
* [ ] Code is reviewed and approved by mapped CODEOWNERS.

---

## 9. Code Review Governance & Merge Gates

### Code Review Governance Matrix
Every pull request (PR) must include the following mandatory verification checks:

| Check | Mandatory | Verification Action |
| :--- | :--- | :--- |
| **Tests Added** | ✅ | Unit, integration, or widget test suite verification |
| **Security Reviewed** | ✅ | Validation of input sanitization and secure coding rules |
| **Architecture Respected** | ✅ | Clean import checks (no inner-to-outer leaks) |
| **Complexity Within Budget** | ✅ | Budget limits met (Cyclomatic/Cognitive <= 10) |
| **Documentation Updated** | ✅ | Outdated spec documentation or docstrings aligned |
| **Breaking Changes Declared** | ✅ | Explicit warning flags and migration annotations |
| **ADR/CDR Required** | When applicable | Mapped CDR log registered under `/docs/cdr` |

*Review Boundary Rule: No reviewer may approve code outside their domain ownership. Self-approvals are blocked.*

### Merge Gates
1. **Static Quality Verification:** Automated linting, type-checking, and metrics gates pass.
2. **Build Success:** Compilation succeeds for all targets.
3. **Automated Test Validation:** 100% of test suites run green.
4. **Approval Requirements:** Minimum of one mapped CODEOWNER approval. Self-approvals are blocked.

---

## 10. Technical Debt Classification System

To maintain long-term scalability and align with our product roadmap doctrine, technical debt is categorized, tracked, and remediated under strict rules:

| Level | Definition | Action / Remediation Gate |
| :--- | :--- | :--- |
| **TD-1** | Cosmetic | Normal backlog prioritization |
| **TD-2** | Maintainability risk | Quarterly architecture review and sprint planning allocation |
| **TD-3** | Architectural risk | Mandatory remediation within 6 months of detection |
| **TD-4** | Security/reliability risk | Immediate action (remediation blocks next release gate) |

### Technical Debt Rules
* **Stewardship Requirement:** Debt without explicit ownership is a governance failure. All flagged technical debt must have a designated ARB role owner.
* **Maximum Age:** Technical debt older than 24 months represents a critical institutional risk and must be escalated to the Executive Architecture Board for immediate mandatory decommissioning.

---

## 11. Coding Standards Readiness Gate

Before active application implementation work begins, all code quality controls must be verified:

□ Linters configured
□ Formatters configured
□ Complexity gates enabled
□ Coverage gates enabled
□ Dependency boundaries enforced
□ Secure coding checks active
□ Review templates installed
□ DoR/DoD adopted
□ CDR taxonomy established
□ CI validation passing

If any item fails:
**IMPLEMENTATION IS BLOCKED**

---

## 12. Coding Decision Records (CDR)

All changes, exceptions, or customizations to the coding standards must be recorded as CDRs inside `docs/cdr/`.

### CDR Index
* **CDR-001:** Standardized Python 3.12 static check toolchain (`ruff`, `mypy`).
* **CDR-002:** Flutter/Dart static compiler and lint analysis constraints.
* **CDR-003:** Complexity budgets and file boundaries.
* **CDR-004:** Secure coding standards mapping.
* **CDR-005:** Definition of Done and merge gates.

---

## 13. Institutional Engineering Principle

> **Core Philosophy:**  
> Clean code repository structures yield clean systems. The syntax we write today defines the scalability of our platform tomorrow. Keep constructs verbose, type signatures strict, and exceptions safe. Write code that endures.
>
> **Build once. Evolve forever.**

**🙏 श्री गणेशाय नमः**
