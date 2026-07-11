# ADR-042: Beta Distribution

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
We need a secure, automated way to distribute pre-release builds to internal stakeholders and eventual design partners, without leaking the binary to the public or compromising device security.

## Decision
1. **iOS Distribution:** We will use **Apple TestFlight**.
   - Requires provisioning profiles and certificates managed via Fastlane Match.
   - Internal Beta: Distributed to predefined Apple IDs.
   - External Beta: Distributed via Public Link (with invite limits).
2. **Android Distribution:** We will use **Firebase App Distribution** for Internal Beta and **Google Play Internal Testing** for External Beta.
   - Firebase allows faster iteration without Play Console review delays for internal team members.
   - Play Internal Testing ensures the final App Bundle (AAB) is tested exactly as it will be delivered by the Play Store.

## Consequences
- Requires setting up a Google Service Account for Firebase and Play Console API access.
- Requires an App Store Connect API Key for Fastlane integration.
- Automated distribution pipelines will be triggered by GitHub tags (e.g., `v0.9.0-rc1`).
