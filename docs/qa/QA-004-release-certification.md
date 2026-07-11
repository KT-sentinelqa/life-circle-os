# QA-004: Release Certification

**Status:** Active | **Phase:** 7

## Objective
To serve as the final Go/No-Go checklist before a Release Candidate is distributed to testers.

## Mandatory Certification Gates
Before an RC is approved, the Release Manager must verify:

### 1. Code Quality
- [ ] All CI checks are green (Unit, Widget, Integration, Goldens).
- [ ] Test coverage meets the 85% threshold.
- [ ] No P0 (Critical) or P1 (High) bugs are open.

### 2. Security & Privacy
- [ ] Automated security scans (SAST, Secrets, Dependencies) are clean.
- [ ] New feature flags have corresponding Kill Switches configured on the backend.
- [ ] Telemetry instrumentation has been verified to omit PII.

### 3. Release Engineering
- [ ] `CHANGELOG.md` is updated with all features, fixes, and breaking changes.
- [ ] `KNOWN_ISSUES.md` is updated with accepted P2/P3 bugs.
- [ ] `MIGRATION_GUIDE.md` is updated (if there is a breaking Isar schema change or Sync Event format change).

### 4. Regression Sweeps
- [ ] Complete app uninstall and reinstall works flawlessly.
- [ ] Upgrading from the previous version works without data loss.
- [ ] Complete offline operation (Airplane mode) functions as expected.
