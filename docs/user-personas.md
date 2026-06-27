# LifeCircle OS — User Personas

> **Status:** Locked (v1.0)  
> **Author:** Gemini (Implementation Engineer)  
> **Reviewed & Approved By:** Krishna & ChatGPT Architecture Board  
> **Date:** June 26, 2026  

This document outlines the primary user personas for LifeCircle OS. It details their demographics, behaviors, pain points, core goals, and technical profiles to guide the design of the user experience, accessibility structures, and domain capabilities.

---

## Persona Overview

LifeCircle OS is designed for the modern, multi-generational Indian household. Our three core personas represent the primary segments that interact with the system:

```
                  ┌───────────────────────────────┐
                  │   Aarav Sharma (36, Anchor)   │
                  │  - Coordinates household      │
                  │  - Tracks bills, EMIs, health │
                  │  - Technical & Premium-focused│
                  └──────────────┬────────────────┘
                                 │
         ┌───────────────────────┴───────────────────────┐
         ▼                                               ▼
┌───────────────────────────────┐               ┌───────────────────────────────┐
│   Ramesh Sharma (68, Elder)   │               │   Priya Sharma (34, Partner)  │
│  - Aging parent               │               │  - Co-manages domestic life   │
│  - Medicine tracking, vitals  │               │  - Seeks shared alignment     │
│  - Needs high accessibility   │               │  - Calm & efficient tool user │
└───────────────────────────────┘               └───────────────────────────────┘
```

---

## 1. Aarav Sharma — The Family Anchor (Household Coordinator)

*“I just want a single place where I can see that my parents’ health is stable, the household bills are paid on time, and our family responsibilities are shared without constant back-and-forth on WhatsApp.”*

### Demographic & Context
* **Age:** 36
* **Location:** Bengaluru, India
* **Occupation:** Senior Software Product Manager
* **Family Structure:** Lives with his spouse (Priya), their 6-year-old child, and his aging parents (Ramesh and Kanta).
* **Role in Family:** The primary logistical and financial administrator of the household.

### Profile & Behavior
* **Daily Routine:** Fast-paced, high cognitive load. Splits time between professional deadlines, parenting duties, and coordinating care for his parents.
* **Information Intake:** Heavily reliant on digital tools, but suffers from notification fatigue. Values premium, clean design.
* **Family Dynamic:** Deeply respects and cares for his parents, wanting to manage their health proactively without making them feel micro-managed or dependent.

### Pain Points
* **Fragmented Information:** Medication lists are on paper, doctor prescriptions are scattered across PDF files in WhatsApp chats, and utility bills are buried in his email inbox.
* **Missed Deadlines:** Occasional late fees on vehicle insurance renewals or utility bills because they got lost in the noise of daily notifications.
* **Anxiety and Mental Load:** Constantly worries if his father took his critical diabetes medication or if a home loan EMI payment successfully cleared.

### Core Goals for LifeCircle OS
* **Centralized Coordination:** A single dashboard to monitor parent health, upcoming insurance/vehicle renewals, and shared domestic tasks.
* **Automated & Calm Reminders:** Receive timely, low-anxiety notifications for upcoming EMIs and critical household renewals.
* **Parental Health Verification:** A simple way to check if his father, Ramesh, logged his medication for the day without having to call and ask.

### Tech Profile
* **Devices:** iPhone 15 Pro, Mac Mini, iPad.
* **App Preferences:** High-quality, premium iOS apps (Apple Notes, Things 3, CRED).
* **Technical Comfort:** Advanced. Expects fluid animations (120 Hz support), seamless cloud synchronization, and offline accessibility.

---

## 2. Ramesh Sharma — The Elder (Aging Parent)

*“I want to manage my health independently and stay on top of my routines without being a source of stress or dependency for my children.”*

### Demographic & Context
* **Age:** 68
* **Location:** Bengaluru (living with Aarav)
* **Occupation:** Retired Government Bank Officer
* **Family Structure:** Lives with his son, daughter-in-law, and grandchild.
* **Role in Family:** The family patriarch, focused on managing his health and maintaining personal structure.

### Profile & Behavior
* **Daily Routine:** Enjoys morning walks, reading, and spending time with his grandchild. Has structured daily timings for meals and medicine.
* **Information Intake:** Prefers physical newspapers and diaries but uses mobile apps for basic communication and news reading.
* **Family Dynamic:** Proud and independent. Dislikes feeling like a burden to Aarav and Priya, but occasionally struggles with the complexity of modern digital interfaces.

### Pain Points
* **Accessibility Barriers:** Small font sizes, low contrast, and complex navigation structures make modern apps frustrating and hard to use.
* **Medication Mistakes:** Worry about double-dosing or forgetting to take specific tablets (diabetes, hypertension) that must be taken at precise times relative to meals.
* **Cognitive Overload:** Complex multi-step digital workflows cause anxiety about making mistakes (e.g., clicking the wrong button or deleting data).

### Core Goals for LifeCircle OS
* **Independent Health Tracking:** A simple, high-contrast, large-font interface to view and log daily medicine intake with a single tap.
* **Accessible Reminders:** Large, clear, and calm alarms for medications and health check-ups.
* **Quiet Status Sync:** Automatically notify Aarav that he has taken his medicine, eliminating the need for checking calls.

### Tech Profile
* **Devices:** Mid-range Android smartphone (Samsung Galaxy A-series).
* **App Preferences:** WhatsApp, YouTube, simple regional news apps.
* **Technical Comfort:** Basic to Intermediate. Needs clear visual indicators, large touch targets, screen reader compatibility (TalkBack), and simple, single-purpose screens.

---

## 3. Priya Sharma — The Co-Pilot (Partner in Coordination)

*“Our home shouldn't run on unstructured WhatsApp pings and assumptions. We need a calm, shared system where we can align on responsibilities without the noise.”*

### Demographic & Context
* **Age:** 34
* **Location:** Bengaluru, India
* **Occupation:** Digital Marketing Consultant (Work-from-Home)
* **Family Structure:** Lives with Aarav, their child, and her parents-in-law.
* **Role in Family:** Co-manager of household operations, domestic coordination, and daily schedules.

### Profile & Behavior
* **Daily Routine:** Balances consulting clients from home with child scheduling, managing domestic staff, grocery runs, and coordinating home maintenance.
* **Information Intake:** Values efficiency and clean visual checklists. Despises clutter and redundant notifications.
* **Family Dynamic:** Partners closely with Aarav to run the household, but wants a clear separation of tasks so duties don't slip through the cracks or fall entirely on one person.

### Pain Points
* **Lack of Accountability:** Unclear delegation of chores (e.g., "Who was supposed to call the plumber?", "Did we pay the electricity bill today?") leads to household friction.
* **WhatsApp Fatigue:** Daily household logistics are mixed with social chat and family forwards, making it easy to miss important tasks.
* **Cognitive Clutter:** Constantly trying to remember micro-tasks (ordering groceries, checking domestic helper logs, organizing child's vaccinations).

### Core Goals for LifeCircle OS
* **Shared Task Alignment:** A simple, real-time shared checklist to assign and track domestic duties and chores with Aarav.
* **Calm Daily Status:** A quick, glanceable view of the day's household status (e.g., bills paid, chores done, parent medicine verified).
* **Frictionless Sync:** Changes made on her phone must synchronize with Aarav's phone via eventually consistent and reliable synchronization, without sending annoying notification alerts.

### Tech Profile
* **Devices:** OnePlus 11, iPad.
* **App Preferences:** Notion, Google Keep, Instagram, simple habit trackers.
* **Technical Comfort:** High. Expects modern, responsive, and aesthetically pleasing interfaces with smooth transitions.

---

## 4. Persona Governance & Policies

### Persona Governance Rules
* Every feature must map to at least one persona.
* Every RFC must declare primary and secondary personas, detailing expected benefits and emotional outcomes.
* Features without validated personas shall not enter the roadmap.

### Persona Evolution Policy
* Personas are living artifacts and must be reviewed every 18 months.
* Persona modifications require research evidence, ADR documentation, and governance approval. No persona changes are permitted without explicit validation.

---

## 5. Engineering & Experience Baselines

### Mobile Experience Principles
The application shall provide consistent device-level optimizations aligned to specific persona needs:
* **Aarav:** Premium iOS expectations (60 FPS minimum, 120 Hz fluid optimization, native haptics, platform-adaptive navigation).
* **Ramesh:** Accessibility-first expectations (dynamic type scaling, large touch targets, high contrast).
* **Priya:** Fast, battery-efficient synchronization that operates in the background.

### Security Expectations Per Persona
Security controls must align with the OWASP Mobile Application Security Verification Standard (MASVS) and OWASP MASTG guidelines:
* **Aarav:** MFA, biometric authentication, and device trust verification.
* **Ramesh:** Elder-safe recovery flows and simplified, zero-friction local authentication.
* **Priya:** Shared family permissions, fine-grained role-based controls, and audit history/logs of critical administrative changes.

### Elder Mode Requirements
For Ramesh's primary screens, the user interface must enforce:
* Minimum 48dp touch targets.
* High-contrast visual themes.
* Large typography presets supporting Dynamic Type.
* Voice guidance and screen reader support (TalkBack/VoiceOver).
* One primary action per screen with zero hidden gestures.
* Reduced cognitive load.

### Critical Persona Continuity (Offline Strategy)
If cloud connectivity is lost, offline continuity remains mandatory:
* Ramesh must still access his medicine schedules and log intake history locally.
* Aarav must still be able to view critical bill and EMI schedules.
* Priya must still be able to check off and view local household tasks.

---

## 6. Metrics & Emotional Success Criteria

### Emotional Success Criteria
We measure the qualitative impact of LifeCircle OS by how it changes our users' daily states:
* **Aarav:** Should feel **“Everything is under control.”**
* **Ramesh:** Should feel **“I remain independent.”**
* **Priya:** Should feel **“We are aligned without friction.”**

Any feature that compromises these outcomes will be rejected during governance reviews.

### Persona-Based Metrics
We track operational outcomes strictly, ensuring business metrics never collect or expose personal family content:
* **Aarav:** EMI completion rates, insurance renewal success rates, and household task completion metrics.
* **Ramesh:** Medicine adherence tracking, Elder Mode adoption, and accessibility success indicators.
* **Priya:** Shared task coordination efficiency, notification effectiveness, and household alignment indicators.

---

## How LifeCircle OS Resolves Persona Pain Points

The following matrix maps how specific domain features of LifeCircle OS directly resolve the core pain points of our personas:

| Domain | Aarav (Anchor) | Ramesh (Elder) | Priya (Co-Pilot) |
| :--- | :--- | :--- | :--- |
| **Medicines Context** | Verifies Dad's medicine log remotely; reduces health anxiety. | Logs daily doses with a single tap via large, accessible touch targets. | Quick status view avoids duplicate checks or redundant questions. |
| **Finance Context** | Tracks recurring bills/EMIs; alerts prevent late payments. | N/A (Out of daily scope). | Shared ledger shows which bills are cleared, preventing double payments. |
| **Household Context** | Delegates chore ownership; schedules vehicle/insurance renewals. | N/A (Out of daily scope). | Coordinates plumber/repair tasks and domestic lists in a shared space. |
| **Accessibility Framework** | Customizes settings for Ramesh's device from his phone. | Uses high-contrast, scaled-text "Elder Mode" with system voice guidance. | Seamless adaptive behavior on both Android and iOS devices. |

🙏 श्री गणेशाय नमः
