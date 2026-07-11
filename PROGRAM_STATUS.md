# Program Management Office (PMO) Status

**Last Updated:** 2026-07-11
**Current Release Target:** `v0.9.0-rc1`
**Current Phase:** Release Candidate Program (RCP-1: Developer Alpha)

---

## Overall Program Health: 93%

This document is the operational heartbeat of LifeCircle OS. It tracks our readiness to advance through the Release Candidate Program based on empirical evidence, not assumptions.

---

## 1. Standing Board Policy: Evidence-Driven Roadmap
No roadmap item may enter the engineering execution phase unless it is explicitly justified by one of the following three evidence sources:
1. **Production Defect:** A measurable failure in the current release.
2. **Rule of Three User Evidence:** Three independent Design Partner families have explicitly validated the problem.
3. **Regulatory/Security Requirement:** Mandatory compliance or zero-trust patches.

*Speculative features are strictly prohibited.*

---

## 2. Engineering & Infrastructure

| Area | Status | Notes |
|---|---|---|
| **Architecture** | 🟢 Locked | Zero Trust & Offline-first principles fully established. No new features permitted. |
| **Security** | 🟡 Pending | Automated scans (SAST/SBOM) in CI exist, but requires final 3rd-party penetration test. |
| **QA / Testing** | 🟢 Active | CI pipeline active. Golden tests and accessibility checks integrated. |
| **Performance** | 🟢 Certified | `QA-002` benchmarks (60 FPS, <2s cold start) met in local profiling. |
| **SRE / DevOps** | 🟡 Pending | Fastlane scaffolded. Needs final manual execution of iOS/Android certificates. |

---

## 2. Release Candidate Program (RCP) Progression

We do not advance to the next RCP stage until the exit criteria of the current stage are empirically validated.

| Stage | Target Audience | Exit Criteria | Status |
|---|---|---|---|
| **RCP-1: Dev Alpha** | Internal Engineering | 0 Build Failures, 100% CI pass | 🔄 **In Progress** |
| **RCP-2: Friends & Fam** | 20-30 highly tolerant users | >99% Crash-Free rate | ⏳ Pending |
| **RCP-3: Design Ptnrs** | F001 - F010 | Positive qualitative feedback on "Mental Load" | ⏳ Pending |
| **RCP-4: Closed Beta** | 50-100 external families | < 2 bugs reported per day | ⏳ Pending |
| **RCP-5: Public Beta** | Open Registration | Scalability proven, Customer Support SLAs met | ⏳ Pending |
| **RCP-6: Production** | General Availability (v1.0) | Consistent MRR generation | ⏳ Pending |

---

## 3. Business & Launch Readiness

| Area | Status | Notes |
|---|---|---|
| **Design Partner Recruitment** | 🟡 Pending | Candidates identified; waiting for RCP-2 completion to onboard F001. |
| **Legal & Compliance** | 🟡 Pending | Privacy Policy & Terms of Service drafted. Awaiting external legal counsel review. |
| **Marketing & Positioning** | 🟡 Pending | App Store descriptions and Launch Story finalized. Website deployment pending. |
| **Customer Success** | 🟡 Pending | Support playbooks drafted. Needs tabletop exercise validation. |
