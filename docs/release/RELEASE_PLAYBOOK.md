# LifeCircle OS — Release Playbook

**Status**: Approved
**Owner**: Release Manager
**Effective**: Phase 4 Sprint 4

## Overview
This playbook governs every production release of LifeCircle OS. No release may bypass this process.

---

## Release Types

| Type | Branch | Tag | Audience |
| :--- | :--- | :--- | :--- |
| Development | `develop` | auto | Engineering |
| Beta | `release/vX.Y.Z` | `vX.Y.Z-beta.N` | Trusted testers |
| Release Candidate | `release/vX.Y.Z` | `vX.Y.Z-rc.N` | Final validation |
| Stable | `main` | `vX.Y.Z` | General availability |

---

## Pre-Release Checklist

### Engineering Sign-off
- [ ] All CI gates (1–5) are green on the release branch.
- [ ] 0 open blocker or critical issues.
- [ ] Coverage ≥ 90% on all core domain modules.
- [ ] Architecture compliance tests pass.
- [ ] Performance benchmarks have not regressed.
- [ ] `flutter analyze` returns 0 issues.

### Architecture Sign-off
- [ ] No new cross-domain imports introduced.
- [ ] No new ADR violations detected.
- [ ] SDK contract has not changed without a MAJOR version bump.

### Security Sign-off
- [ ] No new high-severity dependency vulnerabilities.
- [ ] No secrets in code (automated scan).
- [ ] Encryption at rest and in transit verified.

---

## Release Execution Steps

### Step 1: Create Release Branch
```bash
git checkout develop
git pull
git checkout -b release/vX.Y.Z
git push origin release/vX.Y.Z
```

### Step 2: Bump Version
Update `apps/mobile/pubspec.yaml`:
```yaml
version: X.Y.Z+BUILD_NUMBER
```
Commit: `chore: bump version to X.Y.Z`

### Step 3: Tag Beta
```bash
git tag vX.Y.Z-beta.1
git push origin vX.Y.Z-beta.1
```
GitHub Actions will build and publish the beta artifact automatically.

### Step 4: Internal Testing Period
- Minimum 48-hour soak for beta.
- All reported critical issues must be resolved before proceeding.

### Step 5: Tag Release Candidate
```bash
git tag vX.Y.Z-rc.1
git push origin vX.Y.Z-rc.1
```

### Step 6: Release Candidate Sign-off
- Release Manager reviews the generated `PlatformHealthSnapshot`.
- Security team confirms no outstanding hotspots.
- Explicit approval from: Engineering Lead, Architecture Lead, Security Lead.

### Step 7: Merge and Tag Stable Release
```bash
git checkout main
git merge release/vX.Y.Z --no-ff
git tag vX.Y.Z
git push origin main vX.Y.Z
```

### Step 8: Post-Release Verification
- [ ] App Store / Play Store upload confirmed.
- [ ] Smoke tests run against production build.
- [ ] Platform health check returns `healthy`.
- [ ] Monitoring dashboards show baseline metrics.

---

## Rollback Procedure

If a production incident requires rollback:

1. Revert the Play Store / App Store to the previous stable build immediately.
2. Tag the previous release as the current stable:
   ```bash
   git tag vX.Y.Z-hotfix.1 <previous-stable-commit>
   ```
3. Open a Severity-1 incident and assign a Root Cause Analysis (RCA) owner.
4. Do not re-release until the RCA is complete and the fix is verified.

---

## Release Communication

Every stable release must include:
- Auto-generated CHANGELOG from commit history.
- `security_release: true | false` flag.
- `breaking_changes: true | false` flag.
- Link to the `PlatformHealthSnapshot` at time of release.
