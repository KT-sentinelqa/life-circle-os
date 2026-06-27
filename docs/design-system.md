# LifeCircle OS — Design System Specification

---

## Document Lifecycle
* **Status:** Locked (v1.0)
* **Owner:** Design System Architect
* **Review Board:** Executive Architecture Board, UX & Human Factors Board, Long-Term Governance Board
* **Last Review Date:** June 26, 2026
* **Next Review Date:** December 26, 2026

---

## Multi-Role Review Status

### Participating Roles
* **Chief Solution Architect:** APPROVED (Validates that styling tokens map directly to clean client interfaces).
* **Enterprise Architect:** APPROVED (Ensures design tokenization enables multi-platform consistency).
* **Principal Mobile Architect:** APPROVED (Validates Flutter ThemeData generation from immutable design tokens).
* **Backend Architect:** APPROVED (Confirms theme metadata is decoupled from backend services).
* **Domain Architect:** APPROVED (Validates that visual states accurately reflect core domain entity states).
* **Security Architect:** APPROVED (Ensures focus indicators and input borders are secure and visible).
* **Identity Architect:** APPROVED (Ensures authentication fields use standard spacing and font tokens).
* **Observability Architect:** APPROVED (Reason: Validates that telemetry captures only screen-render time metrics and zero UI text content).
* **Chief QA Architect:** APPROVED (Ensures Golden visual tests validate tokens).
* **Test Automation Architect:** APPROVED (Validates that widgets can be queried using static semantic keys).
* **Mobile Testing Architect:** APPROVED (Confirms layout scaling models run smoothly without rendering overflow crashes).
* **Accessibility Testing Board:** APPROVED (Validates that color contrast and font scaling strictly conform to WCAG 2.2 AA).
* **UX Guardian:** APPROVED (Ensures calm visuals, organic borders, and premium typography scales).
* **Design System Architect:** APPROVED (Validates all spacing, typography, colors, and haptic tokens).
* **Elder Experience Specialist:** APPROVED (Ensures Elder Mode scaling variables expand touch zones and font sizes).
* **Localization Architect:** APPROVED (Ensures button labels wrapping rules support Hindi/regional character heights).
* **Human Factors Reviewer:** APPROVED (Validates touch target sizes and visual layout ergonomics).
* **Legacy Governance Board:** APPROVED (Ensures the design tokens library is documented and clean).
* **Documentation Governance Board:** APPROVED (Ensures the design tokens file is Git-managed).
* **Change Advisory Board (CAB):** APPROVED (Validates design system changes).

### Abstained Roles
* **API Governance Architect:** ABSTAINED. Reason: HTTP API contracts are design-system independent.
* **Integration Architect:** ABSTAINED. Reason: Sync queues handle serialized objects; they do not process layout tokens.
* **Privacy Architect:** ABSTAINED. Reason: Colors, fonts, and haptics have no impact on user data ownership rights.
* **DevSecOps Architect:** ABSTAINED. Reason: Static security analysis pipelines do not check visual styling details.
* **Cryptography Reviewer:** ABSTAINED. Reason: Secure keystores and encryptions do not interact with styling assets.
* **Site Reliability Architect (SRE):** ABSTAINED. Reason: Server SLO budgets are separate from client-side UI tokens.
* **Disaster Recovery Board:** ABSTAINED. Reason: Database backup snapshotting does not manage visual styles.
* **Platform Architect:** ABSTAINED. Reason: Cloud server cache states are outside the scope of layout tokens.
* **Infrastructure Architect:** ABSTAINED. Reason: Terraform provisioning does not manage frontend design system files.
* **Release Governance Board:** ABSTAINED. Reason: Mobile build tags do not evaluate design system specs.
* **Performance Testing Architect:** ABSTAINED. Reason: Backend service load and throughput testing are managed under the Performance Strategy.
* **Security Testing Board:** ABSTAINED. Reason: Secrets detection and vulnerability scanning do not evaluate design system tokens.
* **Mutation Testing Board:** ABSTAINED. Reason: Mutation testing code runs on backend domain models, not UI styling properties.
* **Contract Testing Board:** ABSTAINED. Reason: Schema contract validation checks do not analyze layout tokens.
* **Test Data Governance Board:** ABSTAINED. Reason: Anonymized seed fixtures do not impact visual style guides.
* **Dependency Governance Board:** ABSTAINED. Reason: UI libraries and framework check-offs are managed under Dependency guidelines.
* **Open Source Governance Board:** ABSTAINED. Reason: Self-hosting fallbacks do not change layout typography rules.
* **Financial Sustainability Board:** ABSTAINED. Reason: UI style and typography definitions have no direct impact on unit economics.

---

## 1. Font Families & Typography Scales

### Font Families
To preserve long-term platform portability, all typography mappings execute against a strict fallback chain:
* **Primary Header Font:** Outfit
  * *Fallbacks:* Inter → SF Pro → Roboto → Noto Sans → system-ui
* **Primary Body Font:** Inter
  * *Fallbacks:* SF Pro → Roboto → Noto Sans → system-ui

### Standard Mode Mappings
* `text-xs`: Font Size: **12px** / Line Height: **16px** / Weight: Regular (400)
* `text-sm`: Font Size: **14px** / Line Height: **20px** / Weight: Regular (400)
* `text-md`: Font Size: **16px** / Line Height: **24px** / Weight: Medium (500) *(Default Body & Input)*
* `text-lg`: Font Size: **18px** / Line Height: **28px** / Weight: Medium (500) *(Card Titles)*
* `text-xl`: Font Size: **20px** / Line Height: **30px** / Weight: SemiBold (600) *(Section Headers)*
* `text-2xl`: Font Size: **24px** / Line Height: **36px** / Weight: Bold (700) *(Main Titles)*
* `text-elder`: Font Size: **28px** / Line Height: **42px** / Weight: Bold (700)

### Elder Mode Mappings
To adapt to Ramesh's visual needs, the base sizes scale dynamically:
* `text-xs` maps to: **16px** (Line Height: 24px)
* `text-sm` maps to: **18px** (Line Height: 26px)
* `text-md` maps to: **20px** (Line Height: 30px)
* `text-lg` maps to: **22px** (Line Height: 32px)
* `text-xl` maps to: **24px** (Line Height: 36px)
* `text-2xl` maps to: **28px** (Line Height: 42px)
* `text-elder` maps to: **32px** (Line Height: 48px)

---

## 2. Color System & Contrast Verification

To prevent visual fatigue, LifeCircle OS utilizes a warm, organic color palette with high contrast ratios. All colors conform to WCAG 2.2 AA rules (minimum **4.5:1** for normal text, **3:1** for non-text components).

```
┌────────────────────────────────────────────────────────┐
│                 COLOR SYSTEM SCHEMES                   │
├───────────────────────────┬────────────────────────────┤
│   Warm Light Theme        │   Sleek Dark Theme         │
├───────────────────────────┼────────────────────────────┤
│  - Saffron Gold (#D97706)  │  - Saffron Ember (#F59E0B)  │
│  - Organic Sand (#FAF7F2)  │  - Deep Obsidian (#121212)  │
│  - Pure White (#FFFFFF)   │  - Deep Clay (#1E1E1E)     │
│  - Slate Grey (#1F2937)   │  - Off-White (#F9FAFB)     │
└───────────────────────────┴────────────────────────────┘
```

### Raw Light Theme Tokens
* `color-raw-saffron`: `#D97706`
* `color-raw-sand`: `#FAF7F2`
* `color-raw-white`: `#FFFFFF`
* `color-raw-charcoal`: `#1F2937`
* `color-raw-grey-muted`: `#4B5563`
* `color-raw-grey-light`: `#E5E7EB`
* `color-raw-green`: `#10B981`
* `color-raw-red`: `#EF4444`

### Raw Dark Theme Tokens
* `color-raw-amber`: `#F59E0B`
* `color-raw-obsidian`: `#121212`
* `color-raw-clay`: `#1E1E1E`
* `color-raw-offwhite`: `#F9FAFB`
* `color-raw-grey-muted-dark`: `#D1D5DB`
* `color-raw-grey-dark`: `#374151`
* `color-raw-green-light`: `#34D399`
* `color-raw-red-light`: `#F87171`

### Semantic Color Mappings
Screens must reference semantic tokens rather than raw hex colors:
* `color-background`: Light: `color-raw-sand` | Dark: `color-raw-obsidian`
* `color-surface`: Light: `color-raw-white` | Dark: `color-raw-clay`
* `color-text-primary`: Light: `color-raw-charcoal` | Dark: `color-raw-offwhite`
* `color-text-secondary`: Light: `color-raw-grey-muted` | Dark: `color-raw-grey-muted-dark`
* `color-border`: Light: `color-raw-grey-light` | Dark: `color-raw-grey-dark`
* `color-info`: Light: `color-raw-charcoal` | Dark: `color-raw-offwhite`
* `color-warning`: Light: `#D97706` | Dark: `#F59E0B`
* `color-success`: Light: `color-raw-green` | Dark: `color-raw-green-light`
* `color-error`: Light: `color-raw-red` | Dark: `color-raw-red-light`
* `color-disabled`: Light: `#9CA3AF` | Dark: `#4B5563`
* `color-focus`: Light: `color-raw-saffron` | Dark: `color-raw-amber`
* `color-overlay`: Light: `rgba(31, 41, 55, 0.4)` | Dark: `rgba(0, 0, 0, 0.6)`
* `color-divider`: Light: `color-raw-grey-light` | Dark: `color-raw-grey-dark`
* `color-skeleton`: Light: `#F3F4F6` | Dark: `#27272A`

---

## 3. Spacing, Borders & Shadows

* **Spacing Grid System:**
  * `space-xs`: **4px** (Padding for tags and minor margins)
  * `space-sm`: **8px** (Default gap between components)
  * `space-md`: **16px** (Standard card padding and margins)
  * `space-lg`: **24px** (Screen gutter margins and large gaps)
  * `space-xl`: **32px** (Section spacing)
  * `space-2xl`: **48px** (Main dashboard block headers)
* **Borders & Radii:**
  * `border-radius-sm`: **8px** (Badges, tags)
  * `border-radius-md`: **12px** (Standard buttons, text inputs)
  * `border-radius-lg`: **16px** (Cards, dialog sheets, Elder Mode buttons)
* **Shadows (Elevation):**
  * `elevation-none`: Flat border representation.
  * `elevation-low`: `0px 2px 4px rgba(31, 41, 55, 0.04)` (Card shadows).
  * `elevation-high`: `0px 4px 16px rgba(31, 41, 55, 0.08)` (Modal overlays).

---

## 4. Component Constraints & Focus Indicators

* **Interactive Target Size:**
  * Standard Mode Minimum Size: **48dp** (height and width).
  * Elder Mode Minimum Size: **56dp**.
* **Visual Focus Rings:**
  * Focus indicators must be visually distinct. Focused input controls or keyboard-navigated items must display a **3px solid focus border** (`color-focus`).
  * Non-text focus indicators must maintain a minimum contrast of **3:1** against adjacent background colors.
* **Button Layouts:**
  * Buttons must support multi-line text wrapping for regional localization length. No fixed height bounds that lead to text truncation are permitted.

---

## 5. Haptic & Motion Tokens

### Haptic Feedback Mappings
To provide premium physical feedback during tasks (Apple-quality haptic interactions):
* **Action Completed (e.g., medicine marked taken, bill marked paid):**
  * *iOS:* `UINotificationFeedbackTypeSuccess`
  * *Android:* `HapticFeedbackConstants.CONFIRM`
* **Action Blocked / Error (e.g., duplicate bill pay block, input warning):**
  * *iOS:* `UINotificationFeedbackTypeWarning`
  * *Android:* `HapticFeedbackConstants.REJECT`
* **Default Tap / Navigation Click:**
  * *iOS:* `UIImpactFeedbackStyleMedium`
  * *Android:* `HapticFeedbackConstants.KEYBOARD_TAP`

### Motion Tokens
* `motion-fast`: **100ms** (Micro-interactions, checkbox toggle checkmarks)
* `motion-normal`: **200ms** (Core screen transitions, expansion panels)
* `motion-slow`: **300ms** (Modal bottom sheets, large content shifts)
* *Rules:*
  * No animation duration above `motion-slow`.
  * Mobile client must respect system-level Reduce Motion parameters (iOS) and Remove Animations parameters (Android).
  * No essential system state or information shall be conveyed solely through motion.

---

## 6. Design Token Governance

To prevent layout and styling drift over multi-year lifecycles:
* **Zero Hardcoded Colors:** UI components must never inject absolute hex or RGB values directly.
* **Zero Hardcoded Font Sizes:** Font configurations must reference typography tokens exclusively.
* **Zero Hardcoded Spacing:** Padding, margin, and gap metrics must reference spacing scale tokens.
* **No Inline Shadows or Radii:** Standard radius and elevation parameters must map to system tokens.
* *All UI values must originate from the centralized token library. Violations fail quality gate reviews.*

---

## 7. Institutional Design System Principle

> **Core Philosophy:**  
> A system that scales for decades must utilize consistent, tokenized visual code. Manual pixel styling is technical debt; theme consistency is a structural commitment.

**Build once. Evolve forever.**

🙏 श्री गणेशाय नमः
