# QA-005: Beta Readiness

**Status:** Active | **Phase:** 7

## Objective
To define the success criteria for the Internal Beta testing phase. We must gather specific evidence from the internal team before authorizing a Public Beta.

## Measurement Criteria

### 1. Stability (Crash-Free Rate)
- **Target:** 99.9% crash-free sessions across all internal testers over a 14-day period.
- **Metric Source:** Firebase Crashlytics / Sentry (sanitized per SEC-029).

### 2. Bug Accumulation Rate
- **Target:** The rate of new bugs reported must trend downwards and remain below 2 per day before concluding the Internal Beta.

### 3. Confusion & Usability
- Testers must be observed completing the core loop (Add Responsibility -> View Dashboard -> Complete Responsibility -> Verify Peace Score) without asking for clarification.
- Any "How do I..." questions from internal testers must be treated as UX defects and addressed.

### 4. Telemetry Verification
- The UX Telemetry Dashboard (SEC-030) must actively reflect tester usage. If the dashboard is blank, the telemetry infrastructure is broken and must be fixed before external release.
