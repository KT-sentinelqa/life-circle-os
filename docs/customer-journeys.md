# LifeCircle OS — Customer Journeys

> **Status:** Locked (v1.0)  
> **Author:** Gemini (Implementation Engineer)  
> **Reviewed & Approved By:** Krishna & ChatGPT Architecture Board  
> **Date:** June 26, 2026  

This document defines the step-by-step user journeys for the core scenarios of LifeCircle OS, mapping user actions directly to the technical, security, and accessibility constraints established in the Engineering Baselines.

---

## Journey Overview

We track three core multi-generational journeys:
1. **Daily Medication Logging & Remote Verification** (Ramesh & Aarav)
2. **Shared Finance & Bill Coordination** (Aarav & Priya)
3. **Domestic Chore Allocation & Completion** (Priya & Aarav)

```
┌────────────────────────────────────────────────────────────────────────┐
│                        CORE JOURNEY PATHWAYS                           │
├──────────────────────────┬──────────────────────────┬──────────────────┤
│    1. Medicine Logging   │     2. Bill Tracking     │ 3. Domestic Task │
├──────────────────────────┼──────────────────────────┼──────────────────┤
│ Ramesh logs dose locally │ Aarav assigns bill       │ Priya logs task  │
│          ▼               │          ▼               │        ▼         │
│ Syncs to Platform        │ Priya pays & logs status │ Aarav checks off │
│          ▼               │          ▼               │        ▼         │
│ Aarav views status E2E   │ Finance dashboard updates│ Sync completes   │
└──────────────────────────┴──────────────────────────┴──────────────────┘
```

---

## Journey 1: Daily Medication Logging & Remote Verification

* **Primary Persona:** Ramesh Sharma (Elder)
* **Secondary Persona:** Aarav Sharma (Anchor)
* **Scenario:** Ramesh needs to take and log his morning Metformin dose. Aarav needs verification that the dose was taken without calling to interrupt.

### Step-by-Step Flow

```
[ Ramesh's Phone ] ──(Reminder Alarms)──> [ Ramesh Logs Dose ]
                                                 │
                                           (Local Db Save)
                                                 │
                                                 ▼
[ Aarav's Phone ] <──(Eventually Synced)── [ Family Coordination Platform ]
```

1. **Trigger:** At 8:00 AM, Ramesh’s Samsung Galaxy A-series phone triggers a calm, high-contrast, audible notification.
2. **Launch & Layout:** Ramesh picks up his phone and taps the notification. The app opens immediately in **Elder Mode**:
   - The UI scales to large typography presets.
   - Text is high contrast, and dynamic type scaling is active.
   - The screen features exactly **one primary action** button: `"Mark Metformin (Morning) as Taken"`.
3. **Execution:** Ramesh taps the primary button (size: 56dp touch target).
   - The system triggers a native Android haptic confirmation vibration.
   - The screen displays a green checkmark with simple text: `"Morning Medicine Logged at 8:05 AM"`.
   - The application does not require any secondary confirmation dialogs.
4. **Offline Logging:** The event is written immediately to the local database on Ramesh's device.
5. **Background Sync:** The app checks network status. Since Ramesh's internet is active, it initiates an eventually consistent synchronization to the **Family Coordination Platform**, completing in under 5 seconds.
6. **Remote Verification:** At 8:10 AM, Aarav opens the app on his iPhone 15 Pro. The parent health dashboard displays a clean green checkmark under Ramesh’s name: `"Morning Medicine: Taken at 8:05 AM"`.
7. **Offline Fallback Scenario:** If Ramesh’s phone is completely offline (e.g., during a local power outage):
   - Ramesh still receives his notification and can successfully tap to log the medicine.
   - The data is stored safely in his local database.
   - Aarav’s phone will show `"Pending confirmation (Dad is offline)"`. 
   - As soon as Ramesh's phone reconnects to a network, the sync automatically completes, and Aarav's dashboard updates.

### Emotional Outcome
* **Aarav:** Feels **“Everything is under control”** upon seeing the confirmation checkmark.
* **Ramesh:** Feels **“I remain independent”** because he logged his medication without requiring Aarav's phone call or manual oversight.

---

## Journey 2: Shared Finance & Bill Coordination

* **Primary Persona:** Aarav Sharma (Anchor)
* **Secondary Persona:** Priya Sharma (Co-Pilot)
* **Scenario:** The monthly electricity bill is generated. Aarav and Priya need to track and pay the bill, ensuring it is paid on time without duplicate payments.

### Step-by-Step Flow

```
[ Electricity Bill ] ──> [ Aarav Assigns to Priya ] ──> [ Priya Pays Bill ]
                                                              │
                                                        (Logs status)
                                                              │
                                                              ▼
[ Aarav's Dashboard ] <──(Eventually Synced in <10s)── [ Family Coordination Platform ]
```

1. **Trigger:** The system detects an upcoming utility bill due in 7 days (Electricity: ₹4,200).
2. **Assignment:** Aarav opens the app, views the pending item in the Finance Dashboard, and assigns the task to Priya.
3. **Notification:** Priya receives a quiet, low-priority notification on her OnePlus device: `"New Bill Assigned: Electricity (₹4,200) due on July 3rd"`.
4. **Execution:** Priya taps the notification. The app opens to her task manager.
   - She leaves the app to execute the payment via her banking/UPI application.
   - Upon completion, she returns to LifeCircle OS and taps `"Mark as Paid"`.
   - She inputs the transaction reference number.
5. **Conflict Prevention:** Once marked as paid, the task is locked on the cloud database. If Aarav attempts to edit or mark the same bill as paid simultaneously, the system prevents double-writes.
6. **Synchronization:** The status is synchronized to the **Family Coordination Platform**. Within 10 seconds, Aarav’s dashboard updates:
   - The bill is moved to the `"Settled"` archive.
   - The joint ledger registers: `"Paid by Priya on June 26, 15:45"`.
7. **Offline Scenario:** If Priya marks the bill as paid while offline, the local database records the "Paid" state. If Aarav is online, he will see `"Payment pending upload"` on the joint dashboard, preventing him from initiating a duplicate payment.

### Emotional Outcome
* **Aarav:** Feels **“Everything is under control”** knowing that the bill was successfully paid and archived.
* **Priya:** Feels **“We are aligned without friction”** because she didn't have to send screenshots or text messages confirming the payment.

---

## Journey 3: Domestic Chore Allocation & Completion

* **Primary Persona:** Priya Sharma (Co-Pilot)
* **Secondary Persona:** Aarav Sharma (Anchor)
* **Scenario:** A domestic repair task (plumber visit to fix a water tap) needs to be scheduled and confirmed by Aarav while Priya coordinates from home.

### Step-by-Step Flow

1. **Task Creation:** Priya notices a leaking faucet. She opens LifeCircle OS, navigates to the Household Dashboard, and creates a task: `"Plumber Tap Repair"`.
2. **Scheduling:** She sets the plumber's arrival time for Friday at 4:00 PM.
3. **Delegation:** Priya assigns the task to Aarav: `"Aarav to supervise repair work and confirm resolution"`.
4. **Sync & Reminder:** The task is saved locally, syncs to the backend, and is added to Aarav’s shared tasks. At 3:45 PM on Friday, Aarav receives a haptic-enabled reminder on his iPhone: `"Plumber scheduled to arrive in 15 mins"`.
5. **Execution & Log:** The plumber fixes the faucet. Aarav opens the app, selects the task, and clicks `"Complete Task"`.
   - The UI prompts a simple, optional comment box. Aarav inputs: `"Plumbing resolved. Paid ₹500 from cash pool."`
6. **Audit & Resolution:** The task shifts to the `"Completed"` tab. Priya receives a silent status update on her device. The shared household log records: `"Plumber Tap Repair: Completed by Aarav (June 26, 16:30)"`.

### Emotional Outcome
* **Priya:** Feels **“We are aligned without friction”** because the delegation and payment details were tracked silently.
* **Aarav:** Feels **“Everything is under control”** because he had the details of the schedule and payment readily accessible.

---

## 4. Governance & Experience Constraints

### Journey Governance Rules
Every future feature must include:
* Primary Journey
* Primary Persona
* Emotional Outcome (Emotional Acceptance Criteria)
* Offline Behavior
* Accessibility Requirements
* Security Requirements
* Failure Modes
* Recovery Behavior

Features without a documented customer journey shall not enter implementation.

### Mobile Experience Constraints
* **Medicine logging:** Maximum 1 tap.
* **Bill payment confirmation:** Maximum 2 taps.
* **Task completion:** Maximum 2 taps.
* Critical flows shall never exceed three interactions.

### Performance Budgets
* **Battery impact:** <3% active usage/hour.
* **Background synchronization:** Adaptive and battery-aware.
* **Network failures:** Must degrade gracefully.
* **Sync Latencies:** Medicine Sync (<5s), Bills (<10s), Tasks (<10s).

---

## 5. Accessibility, Security & Continuity Rules

### Accessibility Validation Rules
All critical flows must be usable under the following conditions. Accessibility failures block releases:
* Fully operable with TalkBack (Android)
* Fully operable with VoiceOver (iOS)
* Supports 200% text scaling (Dynamic Type)
* Fully functional with reduced motion enabled
* Requires no hidden gestures
* Baselines aligned to WCAG 2.2 AA.

### Security Requirements Per Journey
Security controls shall align with OWASP MASVS and MASTG guidance:
* **Medicine Logging:** Device authentication required, offline data encrypted, audit trail maintained, and Elder Mode must not weaken security controls.
* **Bill Management:** Shared ownership permissions, double-payment prevention, and immutable payment history.
* **Household Tasks:** Role-based assignments, activity history, and ownership tracking.

### Journey Recovery Requirements
All critical workflows must continue operating offline. Auto-sync resumes immediately when connectivity returns:
* **Cloud Outage:** Medicine workflows remain fully operational.
* **Database Outage:** Cached financial records remain available locally.
* **Network Outage:** Household coordination continues locally.

---

## 6. Metrics & Evolution Policy

### Journey Metrics
Metrics must remain aggregated and anonymous; no personal content logging is permitted:
* **Medicine Journey:** Reminder success rate, medication adherence rate, and offline synchronization rate.
* **Finance Journey:** Duplicate payment prevention rate, bill completion rate, and renewal completion rate.
* **Household Journey:** Task completion rate, delegation success rate, and resolution time.

### Journey Evolution Policy
* Customer journeys are versioned, living artifacts and must be reviewed every 18 months.
* Changes require research evidence, updated personas, ADR documentation, and governance approval.

🙏 श्री गणेशाय नमः
