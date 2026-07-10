# LifeCircle OS — User Stories & Experience Flows

**Version:** 1.0 | Phase 6.2 Experience Architecture
**Perspective:** Real families. Real moments. Real emotions.

---

## The Core Experience Promise
> *"I opened the app. Everything was fine. I closed it."*
> That is success. Not engagement. Not time-on-app. Calm dismissal.

---

## Story 1: The Green Morning (Most Common Flow)
**Persona:** Priya (42, working mother, primary caregiver)
**Moment:** 7:12 AM. Chai in hand. School rush in background.

1. Priya opens LifeCircle.
2. Peace Score: **94**.
3. Color: calm green.
4. She reads: *"Everything is covered."*
5. She closes the app in **4 seconds**.

**Emotion to engineer:** *Quiet confidence. Like checking the door is locked and it is.*
**Key constraint:** This flow must never require a scroll. The answer must be visible at launch.

---

## Story 2: The Silent Handoff (Exception-Based Alerting)
**Persona:** Rajesh (48, husband, backup owner for medication)
**Moment:** 9:45 AM. Priya is in a meeting.

1. Medicine reminder window opens.
2. Priya does not acknowledge within 20 minutes.
3. Rajesh receives a single, calm notification: *"Priya hasn't confirmed the 9:30 medicine yet. Can you take this one?"*
4. Rajesh taps **"I'll handle it."**
5. Priya's app updates silently. Her Peace Score holds.
6. **Nobody called. Nobody texted. Nobody panicked.**

**Emotion to engineer:** *Relief for Rajesh. Invisible support for Priya.*
**Key constraint:** The notification must never imply blame or failure. Language: possibility, not accusation.

---

## Story 3: The Invisible Outage (Offline Resilience)
**Persona:** Meena (68, grandmother, low-tech literacy)
**Moment:** Train journey. No network for 3 hours.

1. Meena marks the electricity bill as paid.
2. App responds instantly: ✅ *"Noted."*
3. A quiet indicator appears: *"You're offline. This will sync when connected."*
4. Three hours later, network restores.
5. The event silently syncs. No prompts. No errors. No lost data.
6. Her daughter in Bengaluru sees it update.

**Emotion to engineer:** *Grandmother feels capable, not confused.*
**Key constraint:** Offline must never feel like a punishment. The app must accept all input without hesitation.

---

## Story 4: The Teenager's Contribution
**Persona:** Arjun (16), asked to pay the broadband bill online.
**Moment:** After school. Parents at work.

1. Arjun opens the app. Sees the task assigned to him.
2. He pays the bill externally. Returns to LifeCircle.
3. Marks it complete. Optionally attaches a screenshot (evidence).
4. Both parents see a quiet update: *"Broadband bill — handled by Arjun."*
5. **Nobody needs to verify. The confidence score reflects it.**

**Emotion to engineer:** *Arjun feels trusted. Parents feel relieved.*
**Key constraint:** The completion flow must be under 3 taps. No friction for a teenager.

---

## Story 5: The NRI Daughter
**Persona:** Kavya (34, works in Singapore, only child)
**Moment:** 11:00 PM IST (1:30 AM SG time). Couldn't sleep. Worried about parents.

1. Kavya opens LifeCircle OS.
2. Family Peace Score: **87**.
3. She sees: Father's checkup — ✅ Done. Mother's medicine — ✅ Done.
4. *"Everything is covered."*
5. **She closes the app and goes to sleep.**

**Emotion to engineer:** *Peaceful sleep. Genuine peace of mind across 4,000 km.*
**Key constraint:** Cross-timezone data must be current. Stale data destroys trust more than no data.

---

## Story 6: The Interruption (Real-World Resilience)
**Persona:** Priya, mid-flow adding a new responsibility.
**Moment:** Phone rings. She must answer. App is abandoned mid-form.

1. App is closed abruptly.
2. Priya returns 20 minutes later.
3. The form is exactly where she left it. Nothing lost.

**Emotion to engineer:** *The app respects my time. It waits for me.*
**Key constraint:** All form state must persist locally (Isar) on every keystroke. Never require "save draft."

---

## Story 7: The Escalation (The Rare, High-Stakes Moment)
**Persona:** Rajesh. Father has missed his morning BP medicine for 2 consecutive days.
**Moment:** Thursday morning.

1. System detects pattern: 2 consecutive missed days.
2. An exception alert appears — not a push notification, but an in-app card.
3. **Tone:** *"Papa's morning BP medicine hasn't been confirmed for 2 days. This might need your attention."*
4. Rajesh can: Acknowledge / Delegate to Kavya / Mark as checked in person.
5. If he acknowledges: Peace Score stabilizes. Alert disappears.

**Emotion to engineer:** *Actionable urgency. Not panic. Not guilt.*
**Key constraint:** Two-day pattern, not one. Single misses are noise. Patterns are signal.
