# SEC-029: Internal Beta Governance

**Status:** Enforced | **Phase:** 6A

## Policy Rules

### 1. Data Segregation
* Beta environments must use distinct backend infrastructure (databases, Redis clusters, object storage) entirely separate from Production.
* No production data or real family PII may be imported into the Beta environment for testing purposes.

### 2. Crash Reporting Sanitization
* Crash reporting tools (e.g., Sentry, Firebase Crashlytics) must be configured with aggressive data scrubbing.
* Stack traces must not capture local variable values if they could contain PII.
* Breadcrumbs leading up to a crash must follow SEC-028 (Analytics Privacy) rules.

### 3. Feature Flag Enforcement
* Every new feature introduced during the Beta phase must be wrapped in a Feature Flag (ADR-038).
* In the event of a critical defect or security vulnerability discovered during testing, the feature must be disabled remotely via Kill Switch within 60 seconds without requiring an App Store/Play Store update.

### 4. Rollback and Wipe Procedures
* A forced-logout feature flag must exist that can invalidate all sessions for all Beta users simultaneously.
* The mobile client must support a "Poison Pill" payload which, upon receipt, permanently wipes the local Isar database and unregisters the device.
