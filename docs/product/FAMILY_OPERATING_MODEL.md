# LifeCircle OS — Family Operating Model

**Version:** 1.0 | Phase 6.3
**Rule:** Every section must reduce implementation ambiguity. If it doesn't, it doesn't belong here.

---

## 1. Domain Hierarchy

The mental model is a Household, not an app. Engineers build screens. Families manage life.

```
Household
├── Members          — Who is in the family and what role do they have?
├── Responsibilities — What needs to happen? Who owns it?
│   ├── Health       — Medicines, checkups, prescriptions
│   ├── Finance      — Bills, EMIs, subscriptions, renewals
│   ├── Documents    — Insurance, passports, vehicle papers
│   └── Emergency    — Contacts, protocols, escalation paths
└── Peace Index      — The aggregated confidence score across all domains
```

Each domain answers the same six questions (see Section 3).

---

## 2. Permission Visibility Matrix

Who can see and do what, by role:

| Action | Primary Owner | Backup Owner | Family Member | Observer (e.g., NRI child) |
| :--- | :---: | :---: | :---: | :---: |
| View Peace Score | ✅ | ✅ | ✅ | ✅ |
| View Responsibilities | ✅ | ✅ | Own only | ✅ (read) |
| Complete a Responsibility | ✅ | ✅ | Own only | ❌ |
| Add a Responsibility | ✅ | ❌ | ❌ | ❌ |
| Edit a Responsibility | ✅ | ❌ | ❌ | ❌ |
| Delete a Responsibility | ✅ | ❌ | ❌ | ❌ |
| Invite a Family Member | ✅ (creator) | ❌ | ❌ | ❌ |
| View Emergency Contacts | ✅ | ✅ | ✅ | ✅ |
| Trigger Escalation | ✅ | ✅ | ❌ | ❌ |

**Privacy Rule:** Observers see the Peace Score and completion status. They never see task titles unless explicitly shared.

---

## 3. Domain Specification (The Six Questions)

Every domain must answer all six. If an answer is "undefined," the domain is not ready to implement.

### Health (Medicines, Checkups)
| Question | Answer |
| :--- | :--- |
| **Why does this exist?** | To ensure no health-critical task is missed without at least one family member knowing. |
| **Who owns it?** | Primary Owner (typically the caregiver). Backup Owner escalated after configurable window. |
| **Who can see it?** | All family members (completion status). Observers see the score only. |
| **When is it shown?** | Always on Dashboard. Highlighted if overdue. |
| **When is it escalated?** | After 2 consecutive misses (pattern, not noise). |
| **What happens offline?** | Completion recorded locally. Syncs when reconnected. Score updates on-device immediately. |

### Finance (Bills, EMIs, Subscriptions)
| Question | Answer |
| :--- | :--- |
| **Why does this exist?** | To prevent missed payments without requiring daily anxiety. |
| **Who owns it?** | Configurable per responsibility. Usually the person with account access. |
| **Who can see it?** | All members (task exists). Amount/account details: Primary Owner only. |
| **When is it shown?** | 7 days before due date, prominently. Before that, background. |
| **When is it escalated?** | 2 days before due date if unconfirmed. |
| **What happens offline?** | Completion recorded locally. |

### Documents (Insurance, Renewals)
| Question | Answer |
| :--- | :--- |
| **Why does this exist?** | To surface expiry dates before they become emergencies. |
| **Who owns it?** | Primary Owner. No backup needed (low urgency). |
| **Who can see it?** | Primary Owner and co-owners only (documents are sensitive). |
| **When is it shown?** | 30 days before expiry. Not before. |
| **When is it escalated?** | 7 days before expiry if no action taken. |
| **What happens offline?** | View only. No edits to document metadata offline. |

### Emergency
| Question | Answer |
| :--- | :--- |
| **Why does this exist?** | To give every family member immediate, reliable access to critical contacts. |
| **Who owns it?** | Entire family. All members can update. |
| **Who can see it?** | Everyone, including Observers. |
| **When is it shown?** | Always accessible via persistent tab. Never buried. |
| **When is it escalated?** | N/A — Emergency is triggered by the user, not the system. |
| **What happens offline?** | Fully available offline. Emergency contacts are the last thing that can be lost. |

---

## 4. Navigation Model

```
App Entry
    │
    ├── [Tab 1] Dashboard        ← Peace Index + Today's Exceptions
    ├── [Tab 2] Responsibilities ← All domains listed. Overdue first.
    ├── [Tab 3] Family           ← Members, roles, invitations
    └── [Tab 4] Emergency        ← Always visible. One tap from anywhere.
```

**Navigation Principles:**
1. **4 tabs maximum.** Every destination reachable in 2 taps from any tab.
2. **Emergency is always Tab 4.** Immovable. Muscle memory is a safety feature.
3. **Settings is not a tab.** Accessible from Family tab → Profile.
4. **No hamburger menus.** Nothing important is hidden.

---

## 5. Offline Behaviour Matrix

| Domain | Offline Read | Offline Write | Sync on Reconnect |
| :--- | :---: | :---: | :--- |
| Dashboard / Peace Score | ✅ (last known) | N/A | Score recalculates |
| Responsibilities | ✅ | ✅ | Outbox flush, LWW conflict resolution |
| Family Members | ✅ | ❌ (invitations require network) | N/A |
| Emergency Contacts | ✅ | ✅ | Outbox flush |
| Documents | ✅ | ❌ | N/A |

---

## 6. Experience Continuity Rules

These rules govern what happens when the user is interrupted mid-flow:

1. **All form state persists.** Every keystroke is saved to Isar. Closing the app mid-form loses nothing.
2. **Completion is idempotent.** Tapping "complete" twice has the same result as once. No duplicates.
3. **Peace Score is always stale-safe.** If the device cannot sync, it shows the last known score with a timestamp: *"as of 2 hours ago."*
4. **No session timeouts.** The app never logs the user out mid-session for inactivity.
5. **Back navigation never destroys state.** Pressing Back on a multi-step flow saves progress.
