# LifeCircle OS — Product Requirements Document (PRD)

> **Status:** Locked (v1.0)  
> **Author:** Gemini (Implementation Engineer)  
> **Reviewed & Approved By:** Krishna & ChatGPT Architecture Board  
> **Date:** June 26, 2026  

---

## 1. Introduction & Context

Modern Indian households face a silent coordination crisis. Managing a family involves juggling parent care, medication schedules, utility bills, EMIs, household repairs, domestic chores, and insurance renewals. Currently, this coordination occurs over chaotic WhatsApp groups, leading to lost messages, missed deadlines, duplicate payments, parent health anxiety, and constant mental strain.

**LifeCircle OS** is the **Family Life Management Platform** (The Operating System for Indian Families). It is a warm, calm, and premium application designed to reduce household administrative stress. It brings structure, accountability, and offline-first stability to daily family operations, using a subscription model (₹99 Premium for secure cloud sync/backup) to align incentives without monetizing user data.

---

## 2. Product Goals & Success Metrics

We measure product success through performance, accessibility compliance, and user state outcomes:

* **Performance Budgets:**
  * Mobile Cold Start: < 2 seconds.
  * API P95 Latency: < 300 milliseconds.
  * Database Query Performance: < 100 milliseconds.
  * Active Battery Consumption: < 3% usage per hour.
* **Accessibility Compliance:** WCAG 2.2 AA compliance across all client interfaces.
* **Data Privacy:** Zero third-party telemetry, advertisements, or tracking SDKs.
* **Durability:** Eventual consistency synchronization that completes within specified windows (Medicine: < 5s, Bills/Tasks: < 10s).
* **Emotional Success Criteria:**
  * Aarav (Anchor): Feels *“Everything is under control.”*
  * Ramesh (Elder): Feels *“I remain independent.”*
  * Priya (Co-Pilot): Feels *“We are aligned without friction.”*

---

## 3. Target Audience & Roles

The product serves the multi-generational household through three distinct user roles:
1. **The Household Coordinator (Aarav):** Acts as the logistical anchor. Sets schedules, tracks financial commitments, and monitors parent health remotely.
2. **The Aging Parent (Ramesh):** Requires simple, ultra-legible, single-purpose interfaces to log daily medications and receive reminders independently.
3. **The Co-Pilot (Priya):** Manages day-to-day household operations, domestic chores, and coordinates tasks with the coordinator.

---

## 4. Key Epics & Functional Requirements

The initial scope (V1) is strictly divided into five core functional epics.

```
┌────────────────────────────────────────────────────────┐
│               LIFECIRCLE OS V1 EPICS                   │
├────────────────────────────────────────────────────────┤
│  Epic 1: Medicines Context (Parent Health)             │
├────────────────────────────────────────────────────────┤
│  Epic 2: Finance Context (Bills, EMIs & Renewals)      │
├────────────────────────────────────────────────────────┤
│  Epic 3: Household Context (Tasks & Domestic Chores)   │
├────────────────────────────────────────────────────────┤
│  Epic 4: Accessibility Framework (Elder Mode UI)       │
├────────────────────────────────────────────────────────┤
│  Epic 5: Offline-First Synchronization Engine          │
└────────────────────────────────────────────────────────┘
```

---

### Epic 1: Medicines Context (Parent Health)

* **Objective:** Ensure elders can log their medicines independently, and coordinates can verify status remotely.
* **Requirements:**
  * **Medicine Schedule Builder:**
    * Coordinators (Aarav/Priya) can create, edit, and delete medication schedules for family members.
    * Each schedule must specify: Medicine Name, Dosage, Frequency, Time of Day relative to meals (e.g., "After Breakfast"), and Start/End Dates.
  * **Medicine Reminder Alarm:**
    * A quiet, persistent alarm triggered on the parent's device at scheduled times.
  * **One-Tap Medicine Log:**
    * In Elder Mode, the app displays a single primary action button to log a medicine dose (maximum 1 tap).
    * Logging is timestamped and saved locally.
  * **Health Status Dashboard:**
    * Real-time status indicators showing whether daily medicines are `"Taken"` (with timestamps) or `"Missed/Pending"`.
    * Alerts sent to coordinators only when a critical dose window has been missed (reducing notification noise).

---

### Epic 2: Finance Context (Bills, EMIs & Renewals)

* **Objective:** Provide a shared ledger of family commitments, preventing late fees and double payments.
* **Requirements:**
  * **Shared Bill Ledger:**
    * Create records for recurring household commitments: Utility Bills (electricity, gas, water), EMIs (home loan, car loan), and Insurance Policies (health, life, vehicle).
    * Track: Vendor, Amount, Due Date, and Assignment.
  * **Payment Assignment:**
    * The coordinator can assign a bill to a specific family member (e.g., Aarav assigns electricity bill to Priya).
  * **Two-Tap Payment Confirmation:**
    * Users check off paid bills in a maximum of 2 taps (Tap 1: Open Bill Details, Tap 2: Confirm Payment).
    * Requires transaction reference input to maintain a verifiable audit trail.
  * **Double-Payment Prevention:**
    * When a user selects "Mark as Paid," the record locks. If another family member is viewing the same bill, the interface updates to show "Processing..." or "Paid," preventing duplicate transactions.
  * **Renewal Calendar:**
    * Dedicated calendar view highlighting upcoming yearly renewals (vehicle insurance, registration, policy premiums).

---

### Epic 3: Household Context (Tasks & Domestic Chores)

* **Objective:** Delegate and manage daily chores without unstructured chat noise.
* **Requirements:**
  * **Shared Family Chore Board:**
    * Create tasks (e.g., "Plumbing Tap Repair", "Order Rice Bag", "Water Filter Service").
    * Track: Description, Owner, Scheduled Time, and Current Status (Pending, In Progress, Completed).
  * **Two-Tap Task Completion:**
    * Assigned members log task completion in a maximum of 2 taps.
    * Optional text log support for completion details (e.g., "Paid plumber ₹500").
  * **Domestic Helper Registry:**
    * Simple registry to log domestic help attendance (e.g., maid, cook, driver) and notes.

---

### Epic 4: Accessibility Framework (Elder Mode UI)

* **Objective:** Ensure the application is accessible to aging parents with vision or motor limitations.
* **Requirements:**
  * **Elder Mode Toggle:**
    * Global settings toggle to switch the interface into Elder Mode.
  * **Typography & Contrast:**
    * Large typography presets supporting system-level Dynamic Type (scaling up to 200%).
    * Strict adherence to high-contrast themes (AA contrast ratios).
  * **Layout Constraints:**
    * Touch targets must be a minimum of 48dp x 48dp.
    * Maximum of one primary action per screen.
    * Elimination of hidden navigation patterns (e.g., no swipe gestures, no double-taps to proceed).
  * **Screen Reader Compatibility:**
    * 100% compatibility with Android TalkBack and iOS VoiceOver.

---

### Epic 5: Offline-First Synchronization Engine

* **Objective:** Ensure seamless, battery-friendly synchronization that is completely resilient to network failures.
* **Requirements:**
  * **Local Storage Cache:**
    * All user actions (medicine logging, bill confirmation, task creation) must write immediately to local storage.
  * **Battery-Aware Eventual Sync:**
    * Background sync triggers adaptively based on battery level and connection strength.
    * Target Sync Latencies: Medicine Logging (< 5 seconds), Bills (< 10 seconds), Tasks (< 10 seconds).
  * **Graceful Degradation:**
    * If offline, the UI shows a visual indicator (e.g., `"Cached locally - syncing when online"`), allowing complete read/write access to cached data.

---

## 5. Non-Functional Requirements & Guardrails

### Mobile Quality Requirements
The application shall support:
* 60 FPS minimum on supported devices.
* 120 Hz optimization on flagship hardware.
* Native haptic feedback.
* Reduced-motion accessibility mode.
* Battery-first synchronization strategies.
* Platform-adaptive navigation patterns.
* *Performance regressions block releases.*

### Security Non-Functional Requirements
Security requirements must align with OWASP MASVS and MASTG guidance:
* **Authentication:** MFA support, biometric authentication, and device trust verification.
* **Storage:** Encrypted local databases, encrypted backups, and secure key storage.
* **Communications:** TLS 1.3 minimum, certificate pinning, and replay protection.
* **Auditing:** Immutable audit trails, administrative action history, and permission change tracking.

### Performance Guardrails
* No synchronous blocking calls on UI threads.
* Background synchronization must be adaptive.
* Database queries must be indexed.
* Critical screens must render within 500ms.
* Offline operations must complete instantly.

### UX Non-Functional Requirements
The product shall:
* Reduce cognitive load.
* Minimize decision fatigue.
* Avoid notification overload.
* Prioritize clarity over flexibility.
* Respect elderly users.
* *Technology must remain invisible; the family experience is the product.*

### Accessibility Non-Functional Requirements
Accessibility failures block releases. All critical journeys must support:
* WCAG 2.2 AA standard.
* VoiceOver and TalkBack screen readers.
* Dynamic Type up to 200%.
* High Contrast themes.
* Reduced Motion.
* Keyboard Navigation.
* No hidden gestures.
* One primary action per screen.

---

## 6. System Policies & Governance

### Feature Acceptance Governance
A feature shall enter implementation only if it satisfies the following check:
* Approved Epic
* Approved Persona
* Approved Customer Journey
* Has a registered RFC
* Has a registered ADR
* Has a registered Threat Model
* Defined Accessibility Requirements
* Defined Offline Behavior
* Defined Rollback Procedures
* *Otherwise: REJECT.*

### Conflict Resolution Policy
* **Medicines:** Last-write-wins with audit history.
* **Household Tasks:** Optimistic concurrency control.
* **Bills & Financial Records:** Explicit transaction ownership and immutable payment events.
* *Financial entities shall never rely on last-write-wins semantics.*

### Business Continuity Requirements
All critical functions must operate offline:
* **Cloud Outage:** Medicines remain operational, bills remain visible, and tasks remain editable.
* **Database Outage:** Cached data remains accessible locally.
* **Recovery:** Automatic synchronization resumes after restoration.
* *Quarterly restoration drills are mandatory.*

### PRD Evolution Policy
* PRDs are institutional artifacts and must be reviewed every 18 months.
* Changes require user research, ADR updates, RFC approval, and governance sign-off.
* Backward compatibility must always be considered.

---

## 7. Metrics & Analytics

### Product Metrics
Only aggregated, operational metrics are tracked. Personal content collection is strictly prohibited:
* **Medicines:** Adherence rates and reminder success logs.
* **Finance:** Bill completion, EMI completion, and renewal completion rates.
* **Household:** Task completion and assignment efficiency indicators.
* **Premium:** Subscription conversion and retention rates.

---

## 8. Non-Goals (Strictly Out of Scope for V1)

The following features are explicitly excluded from V1:
* **No Cryptographic Legacies or Dead-Man Switches:** No estate transfer protocols, inheritances, or multi-signature keys.
* **No Payment Execution:** LifeCircle OS does not execute UPI or banking payments; it is a shared log, scheduler, and reminder ledger.
* **No Archival Compiler:** No static HTML compilations or archival hardware configurations (e.g., M-DISC generation).
* **No Public Social Media Feeds:** No public sharing, commenting, or external communications outside the shared family context.

🙏 श्री गणेशाय नमः
