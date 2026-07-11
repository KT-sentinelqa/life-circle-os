# ADR-038: Feature Flag Architecture

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
As we approach Internal Beta and eventually Production, we cannot rely on hardcoded application updates to enable/disable features. We need a dynamic mechanism to control feature availability, perform gradual rollouts, and enact emergency kill-switches.

## Decision
We will implement a lightweight, bespoke Feature Flag configuration synced via our existing Cloud Sync runtime, rather than introducing a heavy third-party dependency (like LaunchDarkly) that could compromise our Zero Trust boundaries or increase latency.

1. **Flag Delivery:** Feature flags are delivered as a JSON configuration payload attached to the user's secure session or pulled via a dedicated sync event (`config.flags.updated`).
2. **Local Caching:** Flags are cached securely in Isar. If the device is offline, the last known configuration is used.
3. **Cohort Targeting:** Flags can be targeted globally, by Family ID (Household), or by user role (e.g., Beta Testers).
4. **Kill Switches:** Critical components (e.g., Cloud Sync, Emergency Contacts module) must have an associated kill switch in the flag configuration to allow instant disabling in the event of a critical security vulnerability.

## Consequences
- Requires building a lightweight `FeatureFlagService` in Riverpod.
- Requires backend administration endpoints to toggle flags.
- Avoids third-party SDK bloat and potential data leakage.
