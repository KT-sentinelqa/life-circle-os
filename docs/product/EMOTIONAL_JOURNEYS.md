# LifeCircle OS — Emotional Journeys

**Version:** 1.0 | Phase 6.2 Experience Architecture
**Purpose:** To define the *emotional arc* of each core user flow so that engineers and designers make decisions that serve feelings, not just functions.

---

## The Governing Principle
> Every screen must be answerable with: **"What emotion should the user leave with?"**
> If the team cannot agree on the answer, the screen is not ready to be designed.

---

## Journey 1: First Open (Onboarding)
| Stage | What Happens | Target Emotion |
| :--- | :--- | :--- |
| **Blank slate** | App opens for the first time. Nothing configured. | *Calm curiosity. Not overwhelm.* |
| **First prompt** | "What's one thing your family worries about every week?" | *Recognition. "This app gets it."* |
| **Family invite** | User invites spouse. Invitation sent. | *Anticipation. Building something together.* |
| **First score** | Peace Score appears for the first time: 72. | *Honest orientation. Not judgment.* |

**Anti-pattern to avoid:** Confetti, gamification, or "You're on a streak!" Families are not playing a game.

---

## Journey 2: Daily Return (The Healthy Loop)
| Stage | What Happens | Target Emotion |
| :--- | :--- | :--- |
| **Opens app** | Peace Score ≥ 80. Green. | *Immediate reassurance. Like a nod from a trusted friend.* |
| **Closes app** | Nothing required. | *Permission to stop worrying.* |

**Duration target:** Under 10 seconds. The goal of this journey is for it to be forgettable in the best way.

---

## Journey 3: The Exception Discovery
| Stage | What Happens | Target Emotion |
| :--- | :--- | :--- |
| **Opens app** | Peace Score at 61. Amber. | *Alert attention. Not panic.* |
| **Reads alert** | One exception card visible. Calm description. | *Understanding. Clarity.* |
| **Takes action** | Taps "I'll handle it." | *Agency. Control restored.* |
| **Score updates** | Score rises to 89. Green returns. | *Resolution. Satisfaction.* |

**Key emotion arc:** Mild concern → Clarity → Agency → Satisfaction. Never: Fear → Confusion → Guilt → Helplessness.

---

## Journey 4: The Cross-Family Check (NRI)
| Stage | What Happens | Target Emotion |
| :--- | :--- | :--- |
| **Opens app (night)** | Kavya opens LifeCircle at 1 AM. | *Anxiety. Checking out of worry.* |
| **Sees score** | 91. Green. Parents' tasks all confirmed. | *Immediate relief.* |
| **Closes app** | No action required. | *Permission to sleep. Genuine peace.* |

**The most important moment in this journey is not the data — it is the permission to stop worrying.**

---

## Journey 5: Offline Recovery
| Stage | What Happens | Target Emotion |
| :--- | :--- | :--- |
| **Goes offline** | Sync banner appears quietly. No alarm. | *Minor acknowledgment. Not disruption.* |
| **Continues using** | All actions work normally. App responds instantly. | *Trust. The app is reliable.* |
| **Reconnects** | Banner disappears. Sync happens silently. | *Invisible resolution. The app handled it.* |

**The emotion of offline must be: "The app waited for me." Not: "The app failed me."**

---

## Emotional Anti-Patterns (Never Engineer These)
1. **Guilt loops:** Score drops because a family member was sick. Must not feel like failure.
2. **Anxiety spirals:** Showing a history of all missed tasks. History is not therapy.
3. **Engagement bait:** "You haven't opened the app in 3 days!" This is a violation of Product Principle #1.
4. **False urgency:** Making amber feel like red. If everything is watchAmber, it desensitizes users.
5. **Silent failures:** If sync fails permanently, the user must eventually know. Silence that hides a real problem erodes trust.
