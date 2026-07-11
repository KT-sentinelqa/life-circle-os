# ADR-039: Experience Certification

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
As LifeCircle OS moves from a feature-complete application to an enterprise-grade platform, we must stop evaluating quality solely by functional completeness ("Does it compile? Does it crash?"). We need a formal certification process that guarantees the *experience* of the application remains pristine across updates.

## Decision
We establish a mandatory **Production Experience Certification** for every release candidate. A release candidate cannot proceed to Internal Beta or Production unless it passes six distinct certification workstreams:

1. **Accessibility Certification:** Strict adherence to WCAG AA, VoiceOver/TalkBack compatibility, and Dynamic Type.
2. **Visual Certification:** Golden tests for all UI states (Light/Dark, Skeleton, Empty, Error, Offline).
3. **Interaction Certification:** Validation of haptics, gesture handling, and animation timings (<16ms frames).
4. **Performance Certification:** Measured budgets for cold start, memory footprint, and rendering latency (QA-002).
5. **Offline Certification:** Validation of edge cases (airplane mode, zombie devices, conflict resolution).
6. **Beta Experience Audit:** Can a first-time family use this without engineer guidance?

## Consequences
- Every Pull Request must include Golden Tests for modified UI.
- Performance regressions discovered in CI or manual profiling will block the merge.
- This dramatically increases the time required to merge UI changes, but guarantees the "Calm Interface" product principle is never compromised.
