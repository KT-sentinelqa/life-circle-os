# LifeCircle OS — Interaction Guidelines

**Version:** 1.0 | Phase 6.2 Experience Architecture
**Purpose:** To define the behavioral rules that govern every interactive element, ensuring the product feels consistent, calm, and trustworthy across all states.

---

## The Interruptibility Rule
> **Every flow must be interruptible at any point, at any step, without data loss.**
> A baby cries. A phone rings. A battery dies. The user returns. Nothing is lost. Everything makes sense.

Implementation consequence: All form state and UI state must persist to Isar on every change. No modal dialogs that require completion. No "are you sure you want to leave?" for normal navigation.

---

## Interaction Principles

### 1. Offline First, Always
- Every action receives an **immediate local confirmation**.
- Network sync is a background process the user never waits for.
- If online sync fails, the app retries silently. The user is never asked to "try again."

### 2. Completion is Permanent (But Correctable)
- Marking a task complete triggers `HapticFeedback.mediumImpact()` and a spring animation.
- It does not ask "Are you sure?" — that adds friction and doubt.
- An undo option appears **inline for 5 seconds only**, then disappears. No modal.

### 3. Destructive Actions Have One Safeguard
- Deleting a responsibility or removing a family member requires a **single swipe-to-confirm**, not a multi-step modal.
- The safeguard is the swipe gesture itself, not a warning dialog.

### 4. Loading States Are Never Empty
- No bare spinners. Every loading state shows a **skeleton placeholder** matching the shape of the expected content.
- The skeleton uses the `LCColors.borderSubtle` shimmer to feel calm, not anxious.

### 5. Empty States Have a Next Step
- Every empty state includes exactly one clear call-to-action.
- Empty states never say "No data found." They explain what the space is for and what to do next.

### 6. Error States Do Not Blame the User
- Error messages are written in first-person from the app's perspective: *"Something went wrong on our end. We're retrying."*
- Never surface HTTP status codes or technical errors to the user.

### 7. The Peace Score is a Barometer, Not a Grade
- The score must never animate in a way that feels punishing (e.g., a red flash when it drops).
- Score drops animate with `LCMotion.gentle` — a slow, honest acknowledgment.
- Score increases animate with `LCMotion.spring` — a small, satisfying celebration.

---

## Touch Target Standards (Accessibility)
- All interactive elements: minimum **48 × 48 dp**.
- Primary CTAs (e.g., "I'll handle it"): minimum **54 dp height**, full width.
- Icon-only buttons must have a `Semantics(label: ...)` wrapper.

---

## Haptic Feedback Map
| Interaction | Haptic Type |
| :--- | :--- |
| Task completed | `HapticFeedback.mediumImpact()` |
| Alert acknowledged | `HapticFeedback.mediumImpact()` |
| Task tapped (navigation) | `HapticFeedback.selectionClick()` |
| Family member invited | `HapticFeedback.lightImpact()` |
| Destructive action (swipe-to-delete) | `HapticFeedback.heavyImpact()` |
| Form field focused | *(No haptic — do not interrupt typing)* |
