# LifeCircle OS — UX Constitution v1.0

**Status**: Approved
**Owner**: Product & Design Lead
**Effective**: Phase 5 Sprint 1

---

## Purpose

This document is the frontend equivalent of the Engineering Governance. It defines the non-negotiable design principles that govern every screen, interaction, and component in LifeCircle OS.

Every designer, every engineer writing Flutter code, and every product decision must be tested against these principles.

---

## What LifeCircle Should Feel Like

When someone opens LifeCircle, they should feel:

> **Calm. Trusted. Supported. Organized.**

Not overwhelmed. Not clever. Not impressive.

LifeCircle is not a feature showcase. It is a quiet, reliable partner in family life. Its job is to reduce cognitive load, not add to it.

---

## The 10 UX Laws

### Law 1 — Three Taps
Every primary action must be reachable in three taps or fewer from the home screen. If it takes more than three taps, the information architecture is wrong.

### Law 2 — Offline Is Normal
Offline is not an error state. It is a supported operating mode. Every screen must function meaningfully without network connectivity. The UI communicates sync status always, not only when syncing fails.

### Law 3 — No Lost Data
A user must never lose entered data due to a network change, background process, or navigation event. The platform guarantees this architecturally. The UI must honour it visually.

### Law 4 — Actionable Errors
Error messages must tell the user what happened AND what to do next. "Something went wrong" is never acceptable. "Unable to save — tap to retry when connected" is the minimum acceptable error message.

### Law 5 — Accessibility Is a Release Criterion
Accessibility is not a post-launch enhancement. Every component ships with:
- Semantic labels
- Minimum 4.5:1 contrast ratio (WCAG AA)
- Dynamic text scaling support (up to 200%)
- Screen reader (VoiceOver / TalkBack) compatibility

A sprint is not complete if its components fail accessibility validation.

### Law 6 — Confirmation Before Irreversible Actions
Any family-critical action that cannot be undone must show a confirmation step. Examples: archiving a document, deactivating a family member, activating emergency mode. Confirmation dialogs must describe the consequence, not just ask "Are you sure?"

### Law 7 — Composition Before Creation
No new component may be created if an existing component from the design system can satisfy the requirement. Engineers building screens must first check `design_system/components/`. Every exception requires a design review.

### Law 8 — Large Touch Targets
Every interactive element must have a minimum touch target of 48×48 dp, regardless of its visual size. Small icons receive invisible padding. Density never comes at the expense of usability.

### Law 9 — Sync Status Is Always Visible
Because LifeCircle is offline-first, the sync status of every significant piece of data must be communicable. The `LcSyncIndicator` component must be available on every data-bearing screen. Users must never wonder whether what they see is current.

### Law 10 — Motion Reinforces Understanding
Animations must communicate state change or spatial relationships. Animations that exist only for decoration are forbidden. Every animation has a defined duration and easing curve from the Animation Tokens.

---

## State Vocabulary (All Components Must Implement)

Every data-bearing screen or component must visually distinguish:

| State | Meaning | Visual Treatment |
| :--- | :--- | :--- |
| `loading` | Data is being fetched | `LcStateView.loading()` skeleton shimmer |
| `empty` | No data exists yet | `LcStateView.empty()` illustrated guidance |
| `success` | Data is present | Normal content render |
| `error` | A recoverable error occurred | `LcStateView.error()` with retry action |
| `offline` | Device is offline | `LcStateView.offline()` with queue confirmation |
| `syncing` | Data is queued, not yet confirmed | `LcSyncIndicator` subtle pulse |

---

## Color Philosophy

- The primary palette communicates **trust, depth, and calm**.
- The accent palette communicates **warmth and family connection**.
- Never use color alone to convey meaning. Always pair with a label, icon, or shape.
- The dark theme is not an afterthought. It receives equal design attention as light theme.

---

## Typography Philosophy

- Display text is expressive and human.
- Body text is functional and readable.
- Never sacrifice readability for visual density.
- Minimum body text size is 14sp. Minimum label size is 12sp.

---

## Compliance

This constitution is reviewed at the start of every Phase 5 sprint. Violations are architectural bugs, not style preferences. Any PR that introduces a component violating Laws 1–10 must be rejected until corrected.
