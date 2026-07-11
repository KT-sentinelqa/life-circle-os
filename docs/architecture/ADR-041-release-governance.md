# ADR-041: Release Governance

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
As LifeCircle OS moves towards Beta and Production, ad-hoc releases are no longer acceptable. We require a formal, auditable release process to ensure that buggy or insecure code never reaches end-users.

## Decision
1. **Branching Strategy:** We adopt a trunk-based development model with short-lived feature branches (`feat/`, `fix/`).
2. **Semantic Versioning:** Format: `MAJOR.MINOR.PATCH`.
   - `MAJOR`: Breaking architectural changes or total UI overhauls.
   - `MINOR`: New features (e.g., adding a new module).
   - `PATCH`: Bug fixes and performance improvements.
3. **Release Candidate (RC) Lifecycle:**
   - A release branch `release/vX.Y.Z` is cut from `main`.
   - `RC1` is generated and distributed to internal testers.
   - Bugs found in RC1 are fixed directly on the release branch.
   - `RC2` is generated.
   - Once an RC passes the QA-004 certification, it is promoted to the final Release.
4. **Hotfix Protocol:** Critical production bugs are fixed on a `hotfix/vX.Y.Z+1` branch cut directly from the current production tag, merged, and released immediately.

## Consequences
- Requires automated CI/CD pipelines to tag and build RCs.
- Enforces discipline on developers: no new features can be merged into a release branch once cut.
