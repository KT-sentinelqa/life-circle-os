# LifeCircle OS — Experience Verification Checklist

**Version:** 1.0 | Phase 6.6
**Status:** MANDATORY. Every user-facing screen must pass this before production merge.
**Rule:** This is the final governance document. After this, the project transitions to Production UI Hardening.

> **How to use:** For each screen, copy this checklist. Mark ✅ PASS, ❌ FAIL, or ⚠️ DEFER (with justification). A screen with any ❌ does not merge to main.

---

## Screen Under Review: ___________________
**Reviewer:** ___________________  **Date:** ___________  **Build:** ___________

---

## 1. Accessibility

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| A1 | Contrast — body text | ≥ 4.5:1 against background (WCAG AA) | |
| A2 | Contrast — large text / icons | ≥ 3.0:1 (WCAG AA Large) | |
| A3 | Touch targets | All interactive elements ≥ 48 × 48 dp | |
| A4 | VoiceOver (iOS) | Every element has a meaningful `semanticsLabel`. No "button, button, button." | |
| A5 | TalkBack (Android) | Same as A4. Focus order is logical (top → bottom, left → right). | |
| A6 | Dynamic Type — XXXL | No text truncates. No layout breaks. All content remains readable. | |
| A7 | High Contrast mode | UI remains usable. Skeleton colors adjust. Borders appear where needed. | |
| A8 | Color blindness | Run Deuteranopia simulation. Confidence levels (green/amber/red) must remain distinguishable by shape/label, not color alone. | |
| A9 | No icon-only actions | Every icon button has a visible or accessible label. | |

---

## 2. Calmness

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| C1 | Anxiety audit | No element on this screen could make a user feel judged, panicked, or guilty. | |
| C2 | Notification audit | Every notification this screen could trigger has explicit justification. | |
| C3 | Silence test | If nothing needs action, does this screen communicate that clearly and then get out of the way? | |
| C4 | No dark patterns | No urgency manipulation, no streak counters, no "You haven't opened the app" messaging. | |
| C5 | Calmness score | Score ≥ 65/80 using the rubric in `EMOTIONAL_INTERACTION_SYSTEM.md §9`. | |

---

## 3. Trust

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| T1 | Post-interaction question | After every action on this screen, will the user trust LifeCircle OS *more*? | |
| T2 | Data transparency | No data is collected or transmitted that the user hasn't been informed of. | |
| T3 | Destructive action safety | Irreversible actions require a swipe-to-confirm. No accidental data loss possible. | |
| T4 | Error ownership | All error messages are written in first person from the app ("Something went wrong on our end.") | |
| T5 | Stale data labelled | If data is offline/cached, the age is shown ("as of 2 hours ago"). No silently stale data presented as current. | |

---

## 4. Motion

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| M1 | All animations use design tokens | No hardcoded `Duration(milliseconds: X)` outside `LCMotion`. | |
| M2 | Max duration | No animation exceeds 600ms. | |
| M3 | Reduce Motion support | All animations respect `MediaQuery.of(context).disableAnimations`. Screens remain fully functional with motion off. | |
| M4 | Entrance/exit curves | Entrances use `easeOutCubic`. Exits use `easeInCubic`. Springs only for confirmations. | |
| M5 | No decorative motion | Every animation communicates a state change. No idle animations, no looping backgrounds. | |

---

## 5. Performance

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| P1 | No bare spinners | Every loading state has a skeleton that matches the content shape. | |
| P2 | Optimistic UI | Actions respond in < 16ms locally. Network is never on the critical path for user-visible feedback. | |
| P3 | 60 FPS | Screen scrolls and animations maintain 60 FPS on a mid-range Android device (Snapdragon 700 series). | |
| P4 | No jank on load | First meaningful paint occurs within 300ms of navigation. | |
| P5 | Memory | Screen does not introduce persistent memory growth (no leaks in `AnimationController`, `StreamSubscription`). | |

---

## 6. Offline Behaviour

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| O1 | Screen renders offline | Disable network before navigating to this screen. It must render, even if with cached data. | |
| O2 | Actions queue offline | Any write action taken offline is queued to the Isar Outbox. The user receives immediate confirmation. | |
| O3 | Offline indicator | The `LCSyncStatusBar` appears automatically. No other offline UI is required. | |
| O4 | Emergency always works | If this screen is Emergency, it must function with zero network. No exceptions. | |
| O5 | No silent failure | If an offline action cannot be queued, the user is told — inline, not with a modal. | |

---

## 7. One-Handed Usage

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| H1 | Primary action reachability | The single most important action on this screen is reachable by the right thumb on a 6.1" phone without shifting grip. | |
| H2 | FAB position | Floating action buttons are bottom-right only. | |
| H3 | No top-of-screen critical actions | Destructive or primary actions are not placed at the top of the screen. | |
| H4 | Swipe gestures optional | No workflow requires a two-handed gesture. All swipe actions have tap alternatives. | |

---

## 8. Elder-Friendly Interaction

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| E1 | No jargon | No technical terms, no abbreviations without explanation. A 70-year-old first-time user can understand every label. | |
| E2 | No gesture-only actions | Every gesture (swipe, long-press) has a visible tap alternative. | |
| E3 | Text size at default | At the system default font size, all labels are ≥ 15sp and all captions ≥ 13sp. | |
| E4 | Primary task completion | A first-time elder user can complete the screen's primary task without coaching. (Hallway test.) | |

---

## 9. Error Recovery

| # | Check | Criteria | Result |
| :- | :--- | :--- | :---: |
| R1 | Every error has a recovery action | No error state is a dead end. At minimum, a "Retry" or "Go Back" option exists. | |
| R2 | No technical errors | No HTTP codes, stack traces, or raw exception messages are shown to the user. | |
| R3 | Interrupted flow recovery | Close the app mid-action. Reopen. The user's progress is preserved (Isar state persistence). | |
| R4 | Form validation is inline | Validation errors appear inline, below the relevant field. No modal alerts for form errors. | |

---

## Summary

| Category | Total Checks | Passed | Failed | Deferred |
| :--- | :---: | :---: | :---: | :---: |
| Accessibility | 9 | | | |
| Calmness | 5 | | | |
| Trust | 5 | | | |
| Motion | 5 | | | |
| Performance | 5 | | | |
| Offline | 5 | | | |
| One-Handed | 4 | | | |
| Elder-Friendly | 4 | | | |
| Error Recovery | 4 | | | |
| **Total** | **46** | | | |

### Merge Decision
- **PASS:** 0 ❌ failures. Deferred items have written justification.
- **FAIL:** Any ❌ must be resolved before merge to `main`.

**Decision:** ☐ PASS  ☐ FAIL  **Signed:** ___________________
