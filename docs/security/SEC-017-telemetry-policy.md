# SEC-017: Telemetry & Observability Policy

## 1. Objective
To monitor application health (crashes, ANRs, performance) without violating MASVS-PRIVACY or leaking sensitive family data to third-party dashboards like Firebase Crashlytics or Sentry.

## 2. The Golden Rule of Telemetry
**No telemetry packet may contain PII, Responsibility titles, category names, or the exact FamilyPeaceIndex score.**

## 3. Crash Reporting Constraints
* All crash reports must scrub local state variables before transmission.
* Stack traces must be verified to exclude user-input strings.
* Identifiers sent to telemetry dashboards must use a rotating anonymous UUID that cannot be correlated back to the `FamilyResponsibility.primaryOwnerId`.

## 4. Consent Requirement
Telemetry is strictly **opt-in**. The user must explicitly agree to share diagnostic data during onboarding. If opted-out, the telemetry SDK must not initialize.
