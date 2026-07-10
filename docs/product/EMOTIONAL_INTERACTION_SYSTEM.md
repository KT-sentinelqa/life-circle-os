# LifeCircle OS — Emotional Interaction System

**Version:** 1.0 | Phase 6.5
**Mandate:** Every interaction reduces anxiety. Every interaction reduces cognitive load. Every interaction preserves trust.
**Rule:** If an interaction cannot justify its existence in human terms, it is removed.

---

## 1. Motion Rules

Motion communicates state. It is never decorative.

| Rule | Specification | Rationale |
| :--- | :--- | :--- |
| **Entrances decelerate** | `Curves.easeOutCubic`, 300ms | Elements arrive with confidence, not aggression |
| **Exits accelerate** | `Curves.easeInCubic`, 200ms | Elements leave without hesitation or ceremony |
| **Confirmations spring** | `Curves.elasticOut`, 450ms | Task complete, score updates feel alive and satisfying |
| **Maximum duration** | 600ms hard ceiling | Anything longer is punishment, not polish |
| **No bounce on failure** | Use `Curves.easeOut` for errors | Bouncing errors feel playful; errors deserve gravity |
| **Peace Score changes** | `gentle` (450ms) for drops; `spring` (450ms) for rises | Drops are honest. Rises are earned. Both feel human. |

**Never animate:** Disabled states, placeholder text, background elements the user didn't touch.

---

## 2. Haptic Rules

Haptics are the nervous system of the UI. Used sparingly, they make the app feel alive. Overused, they create noise.

| Interaction | Haptic | Why |
| :--- | :--- | :--- |
| Task marked complete | `mediumImpact` | Significant, satisfying. This matters. |
| Exception acknowledged | `mediumImpact` | Action taken. Family is safer. |
| Navigation tab selected | `selectionClick` | Lightweight orientation feedback |
| Family member invited | `lightImpact` | Positive, small. A handshake, not a celebration. |
| Swipe-to-delete | `heavyImpact` | This is irreversible. Weight is appropriate. |
| Score rises above 80 | `lightImpact` | A quiet acknowledgment, not a firework |
| Score drops below 50 | *(none)* | Don't physically alarm the user |
| Form field focused | *(none)* | Never interrupt intent |
| Offline detected | *(none)* | Offline is normal. It doesn't deserve an alert. |

---

## 3. Gesture Rules

Predictable. Standard. Never surprising.

| Gesture | Action | Constraint |
| :--- | :--- | :--- |
| **Tap** | Primary action on any element | Always visible affordance (≥ 48dp target) |
| **Swipe left** | Reveal actions (delete, delegate) | One action revealed at a time. Never a menu. |
| **Swipe down** | Dismiss bottom sheets | Standard iOS/Android pattern. Muscle memory. |
| **Long press** | Contextual options (edit, move) | Used only where tap is already occupied |
| **Pull to refresh** | Manual sync trigger | Only on list screens. Never on the Dashboard — silence is the default state. |
| **Back navigation** | Never destroys state | `INTERACTION_GUIDELINES.md` rule. Form state persists. |

**Forbidden gestures:** Multi-finger custom gestures, force press, shake-to-action. These are not learned behaviours for elderly or low-literacy users.

---

## 4. Transition Rules

Transitions communicate relationships between places in the app.

| Transition | Specification | Meaning |
| :--- | :--- | :--- |
| Tab switch | `AnimatedSwitcher`, 300ms, `easeOutCubic` | Lateral movement between sibling spaces |
| Push (detail view) | Slide from right, 300ms | Going deeper into a topic |
| Pop (back) | Slide to right, 200ms | Returning to where you were |
| Bottom sheet appear | Slide from bottom, 300ms | A temporary layer, not a new destination |
| Alert appear | Fade + slide from top, 200ms | Arrives to inform, not to alarm |
| Score update | Animated counter + color crossfade, 450ms spring | The most emotional transition in the app |

---

## 5. Feedback Rules

Every action must acknowledge itself. Silence after action is failure.

| Action | Feedback | Timing |
| :--- | :--- | :--- |
| Task completed | Circle fills green + haptic + task fades to 60% | Immediate (< 16ms) |
| Task completion undone | Reverse animation, circle empties | Immediate |
| Exception acknowledged | Card slides out with spring + haptic | Immediate |
| Form submitted | Loading skeleton replaces form | Immediate |
| Sync successful | *(no feedback — silence = success)* | N/A |
| Offline detected | Quiet banner appears from top | Within 1 second |
| Network restored | Banner disappears (no fanfare) | Immediate |
| Error (network) | Inline error text below action | Immediate |

---

## 6. Empty State Rules

Empty states are the app's welcome mat. They must never feel like a dead end.

Every empty state must contain:
1. **A human icon** (not an error icon, not a box, not a folder)
2. **One sentence** explaining what this space is for
3. **One call to action** — never two

| Screen | Icon | Message | CTA |
| :--- | :--- | :--- | :--- |
| Dashboard (all covered) | `check_circle_outline` (green) | "Everything is covered." | *(none — this is a success state)* |
| Responsibilities (empty) | `check_circle_outline` (grey) | "Add the things your family manages together." | "Add Your First Responsibility" |
| Emergency (no contacts) | `emergency_outlined` (grey) | "Add doctors, neighbours, or family members anyone can reach instantly." | "Add Emergency Contact" |
| Family (no members) | `people_outline` (grey) | "Invite your family to share the load." | "Invite Family Member" |

---

## 7. Loading Rules

Loading states must never be empty.

| Rule | Specification |
| :--- | :--- |
| **No bare spinners** | Every loading state uses a skeleton that matches the shape of the expected content |
| **Skeleton color** | `LCColors.borderSubtle` with shimmer effect |
| **Maximum skeleton duration** | 3 seconds. If data hasn't loaded, show an inline error with retry. |
| **No full-screen loaders** | The app is offline-first. Loading should never block the entire UI. |
| **Optimistic updates** | Complete actions locally first. Show the result immediately. Sync in background. |

---

## 8. Error Recovery Rules

Errors are the app's responsibility, not the user's.

| Rule | Microcopy |
| :--- | :--- |
| **Network error** | "Something went wrong on our end. We're retrying." |
| **Sync failed** | "Sync paused. Will retry automatically." |
| **Action failed** | "We couldn't complete that. Try again?" [Retry button] |
| **Session expired** | "Please sign in again to keep your family data safe." |

**Never:** Show HTTP codes, technical stack traces, or the word "Error" without context.
**Always:** Give the user one clear next action.

---

## 9. Calmness Review (The Quality Gate)

Before any feature merges, it answers these questions:

| Question | Required Answer |
| :--- | :--- |
| Does it increase anxiety? | No |
| Does it interrupt unnecessarily? | No |
| Can silence solve it? | If yes → reject the notification |
| Does it reduce thinking? | Yes |
| Does it create guilt? | No |
| Does it reward obsession? | No |
| Is it interruptible at any point? | Yes |
| Can an 80-year-old understand it without training? | Yes |

**Calmness Score (minimum 65/80 to merge):**

| Metric | /10 |
| :--- | :---: |
| Anxiety Reduction | |
| Simplicity | |
| Accessibility | |
| Trust | |
| Privacy | |
| Offline | |
| Recovery | |
| Cognitive Load | |

---

## 10. Inclusive Experience Review

Every screen is validated across these dimensions before production:

| Dimension | Validation Method |
| :--- | :--- |
| **Low vision** | Test at 200% font scale. No text truncation, no overflow. |
| **Color blindness** | Run through Deuteranopia, Protanopia, Tritanopia simulators. Confidence levels must remain distinguishable. |
| **Screen reader** | VoiceOver (iOS) + TalkBack (Android). Every element has a `Semantics` label. Live regions on score changes. |
| **One-handed use** | All primary actions reachable with right thumb. FABs bottom-right. No critical actions at top of screen. |
| **Slow device** | Test on low-end Android (Snapdragon 400 equivalent). Animations must not drop below 60fps. |
| **Offline user** | Disconnect before launching. Every screen must render without network. |
| **Large text** | iOS Accessibility font size "XXXL". Layout must not break. |
| **Elder user** | Labels must be explicit. No icon-only buttons without labels. Contrast ≥ 4.5:1. |
