# LifeCircle OS — Design Principles

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** UX Guardian
* **Review Board:** Executive Architecture Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates that design patterns are clean and decoupled from backend schemas).
* **Enterprise Architect:** APPROVED (Ensures design principles support long-term system evolution).
* **Principal Mobile Architect:** APPROVED (Confirms Flutter layouts support premium haptics and 60/120 Hz render budgets).
* **Backend Architect:** APPROVED (Ensures design templates do not require real-time API integrations).
* **Domain Architect:** APPROVED (Validates user states match the pure core domain entities).
* **Security Architect:** APPROVED (Validates biometric re-authentication prompts use system UI layers).
* **Identity Architect:** APPROVED (Ensures login and local passcode views align with design principles).
* **Observability Architect:** APPROVED (Reason: Validates that aggregate, anonymous operational metrics do not include user-generated content, medicine names, financial values, or family relationships).
* **Chief QA Architect:** APPROVED (Validates visual regression test strategies).
* **Test Automation Architect:** APPROVED (Ensures automated integration tests can target UI components cleanly).
* **Mobile Testing Architect:** APPROVED (Confirms Golden visual test guidelines map to typography scale limits).
* **Accessibility Testing Board:** APPROVED (Ensures design system tokens align with WCAG 2.2 AA).
* **UX Guardian:** APPROVED (Validates emotional outcome targets and cognitive load constraints).
* **Design System Architect:** APPROVED (Ensures typography, spacing, and colors match system tokens).
* **Elder Experience Specialist:** APPROVED (Validates Elder Mode layout scales and contrast rules).
* **Localization Architect:** APPROVED (Ensures UI designs support text expansion for regional languages).
* **Human Factors Reviewer:** APPROVED (Validates spacing scale and button ergonomics).
* **Legacy Governance Board:** APPROVED (Ensures design patterns require no tribal knowledge).
* **Documentation Governance Board:** APPROVED (Ensures design system assets and tokens are version-controlled).
* **Change Advisory Board (CAB):** APPROVED (Validates UI evolution pipelines).

### Abstained Roles
* **API Governance Architect:** ABSTAINED. Reason: HTTP JSON payloads do not have visual or layout presentation layers.
* **Integration Architect:** ABSTAINED. Reason: RabbitMQ sync configurations do not impact frontend look-and-feel.
* **Privacy Architect:** ABSTAINED. Reason: Client-side styling, colors, and fonts do not modify user data ownership rights.
* **DevSecOps Architect:** ABSTAINED. Reason: Specific CI/CD pipeline scans (SAST/SCA) do not check visual styling details.
* **Cryptography Reviewer:** ABSTAINED. Reason: Security keystores and encryptions are independent of layout designs.
* **Site Reliability Architect (SRE):** ABSTAINED. Reason: Server availability and SLO budgets are separate from client-side visual guidelines.
* **Disaster Recovery Board:** ABSTAINED. Reason: Backup restoration and database failover drills do not impact UI layout designs.
* **Platform Architect:** ABSTAINED. Reason: Cloud server components and memory cache tuning are outside the scope of presentation rules.
* **Infrastructure Architect:** ABSTAINED. Reason: Terraform provisioning does not manage front-end styles.
* **Release Governance Board:** ABSTAINED. Reason: Mobile build signing and distribution tags do not evaluate pixel designs.
* **Performance Testing Architect:** ABSTAINED. Reason: Backend service load and throughput testing are managed under the Performance Strategy.
* **Security Testing Board:** ABSTAINED. Reason: Secrets detection and vulnerability scanning do not evaluate design system tokens.
* **Mutation Testing Board:** ABSTAINED. Reason: Mutation testing code runs on backend domain models, not UI styles.
* **Contract Testing Board:** ABSTAINED. Reason: Schema contract validation checks do not analyze layout themes.
* **Test Data Governance Board:** ABSTAINED. Reason: Anonymized seed fixtures do not impact visual style guides.
* **Dependency Governance Board:** ABSTAINED. Reason: UI libraries and framework check-offs are managed under Dependency guidelines.
* **Open Source Governance Board:** ABSTAINED. Reason: Self-hosting fallbacks do not change layout typography rules.
* **Financial Sustainability Board:** ABSTAINED. Reason: UI style and typography definitions have no direct impact on unit economics.

---

## 1. Core Design Philosophy

LifeCircle OS is designed to be an oasis of calm. Our aesthetic is defined as **“Apple meets Indian family values.”** It is warm, supportive, clean, and premium. 

We operate under the directive that **technology must remain invisible; the family experience is the product.**

```
┌────────────────────────────────────────────────────────┐
│                   UX DECISION TREE                     │
├────────────────────────────────────────────────────────┤
│   Does this feature reduce family stress?              │
│                        │                               │
│            ┌───────────┴───────────┐                   │
│            ▼                       ▼                   │
│         [ YES ]                 [ NO ]                 │
│      Keep designing          REJECT feature            │
└────────────────────────────────────────────────────────┘
```

---

## 2. Emotional Success Criteria (Emotional Acceptance)

Every screen design, interaction, and prompt must be validated against our emotional success criteria. If a feature fails these outcomes, it will be rejected:
* **Aarav (Anchor):** Must feel **“Everything is under control.”**
  * *UI Response:* A clean, glanceable dashboard indicating all parent medications have been logged, bills are settled, and chores are assigned.
* **Ramesh (Elder):** Must feel **“I remain independent.”**
  * *UI Response:* Minimal choices, large high-contrast buttons, simple passcodes, and instant feedback that requires no configuration steps.
* **Priya (Co-Pilot):** Must feel **“We are aligned without friction.”**
  * *UI Response:* Shared checklist alignment, simple delegation flows, and silent background syncing with zero noisy alarms.

---

## 3. Typography & Spacing Foundations

### Typography Fallback Policy
* **Primary Header Font:** Outfit (Soft, premium modern geometric font).
  * *Fallback Chain:* Inter → SF Pro → Roboto → System Sans Serif.
* **Primary Body Font:** Inter (Highly readable, neutral, and clear sans-serif).
  * *Fallback Chain:* SF Pro → Roboto → Noto Sans → System Sans Serif.

### Typography Tokens
To facilitate localization, accessibility scaling, and multi-platform theme integration, typography is strictly tokenized. Absolute pixel mapping is handled exclusively inside the design system:
* `text-xs`: Micro-labels and logs.
* `text-sm`: Supplementary descriptions and timestamps.
* `text-md`: Default body text and form inputs.
* `text-lg`: Small headers and card titles.
* `text-xl`: Core section headings.
* `text-2xl`: Main dashboard titles.
* `text-elder`: High-visibility scale specifically optimized for Ramesh's device context under Elder Mode.

### Spacing Grid
* **8px Spacing Grid:** All margins, padding, and layout distances must be multiples of **8px** (e.g., 8px, 16px, 24px, 32px).

---

## 4. Visual Language & Color Palettes

We avoid generic colors (plain red, blue, green). Instead, we use harmonious palettes inspired by traditional Indian tones, balanced with sleek dark modes:
* **Warm Light Palette:**
  * Saffron Gold (Primary): Soft accent color for critical schedules and highlights.
  * Organic Sand (Background): Soft, warm off-white that reduces eye strain.
  * Slate Grey (Text): High-readability charcoal.
* **Sleek Dark Mode:**
  * Saffron Ember (Primary Accent).
  * Deep Clay (Background): Warm, premium dark charcoal/grey.
* **Visual Styling:**
  * Smooth, curved grids (8px to 16px border-radius) creating an organic, human feel.
  * Subtle, clean gradients representing states (e.g., transition from morning sun colors to evening calm colors for medicines).

---

## 5. Interaction & Calm Technology Rules

* **Notification Minimization:**
  * Zero badge count numbers on application icons.
  * Notifications are sent only for critical escalations (e.g., dad's medicine missed for over 30 minutes, or bill due tomorrow). Daily completions and tasks sync silently.
* **Native Haptic Integrations:**
  * Interactive operations (mark paid, mark taken) emit subtle, platform-adaptive haptic clicks to confirm state transitions.
* **Linear Progressive Flow:**
  * Multi-step wizards are structured linearly. We avoid nesting tabs inside tab views to minimize navigation cognitive load.

---

## 6. Motion Design Principles

LifeCircle OS respects native accessibility preferences (iOS Reduce Motion and Android Remove Animations):
* **No Essential Info in Animations:** Crucial changes in system state must be conveyed via clear text or layout updates, never through animation alone.
* **Duration Constraints:** Interactive animations must remain under **300ms** in length.
* **Parallax Disabled:** Multi-layered parallax movements are prohibited.
* **Auto-playing Animations Prohibited:** Loops, gifs, and moving elements must remain paused unless activated via explicit user clicks.
* **State Clarity:** Visual state transitions must remain fully understandable even when all animations are disabled.

---

## 7. Cognitive Load Constraints

To minimize user decision fatigue and keep the interface clear and helpful, we enforce strict cognitive budgets. The user must always know: *Where am I? What happened? and What happens next?*
* **Maximum 7 items per list:** Menus, schedules, and active chores are split into blocks containing at most 7 items.
* **Maximum 3 actions per modal:** Dialog interactions must remain simple and focused.
* **One dominant CTA:** A clear visual weight distinction must guide the user's primary action.
* **Plain language only:** Zero technical terminology, database keys, or dev jargon.
* **Consistent navigation locations:** Core settings and dashboard routes occupy static layouts on screen.

---

## 8. Explicit Design Anti-Patterns

The following interaction patterns are strictly forbidden inside LifeCircle OS:
* **Infinite scrolling:** All logs and histories must be explicitly paginated.
* **Auto-playing videos or animations:** Media remains static until clicked.
* **Dark patterns:** No trick checkboxes, pre-selected signups, or deceptive layouts.
* **Badge-count addiction mechanisms:** No red dot notifications designed to capture attention.
* **Multiple floating action buttons:** Maximum of one floating action button per context dashboard.
* **Nested tab bars:** No secondary horizontal tabs nested inside a primary tab system.
* **Hidden swipe-only interactions:** All swipe actions must have a visible primary button equivalent.
* **Red-only error communication:** Errors must be communicated using text descriptors and icons alongside color changes (respecting color-blind users).
* **Forced onboarding sequences:** Users must be able to skip tutorials directly.
* **Permission prompts without context:** System permissions (e.g., notification alerts) must be preceded by a clear explanation card.

---

## 9. Institutional Design Principle

> **Core Philosophy:**  
> The beauty of our design is measured by the silence of the application. High-fidelity visuals must serve structural calm.

🙏 श्री गणेशाय नमः
