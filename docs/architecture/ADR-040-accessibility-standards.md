# ADR-040: Accessibility Standards

**Date:** 2026-07-10  
**Status:** Accepted  

## Context
LifeCircle OS is designed for multi-generational families. The product must be inherently usable by elderly family members who may have reduced visual acuity, motor function limitations, or cognitive load sensitivities.

## Decision
All screens and components in LifeCircle OS must strictly adhere to the following accessibility standards:

1. **WCAG AA Compliance:** Minimum contrast ratio of 4.5:1 for normal text and 3:1 for large text or UI components.
2. **Dynamic Type (Text Scaling):** All text elements must respect OS-level font size preferences without breaking the layout (overflowing bounds).
3. **Screen Readers:** Every interactive element must possess a meaningful `Semantics` label. Custom widgets must define `button: true` or appropriate traits for VoiceOver (iOS) and TalkBack (Android).
4. **Reduced Motion:** When the OS setting for "Reduced Motion" is enabled, all non-essential page transitions, micro-animations, and parallax effects must be disabled or replaced with simple cross-fades.
5. **Touch Targets:** Minimum touch target size for all interactive elements must be 48x48 logical pixels.

## Consequences
- The design system tokens (`LCColors`, `LCTypography`) must be validated against contrast checkers.
- Golden Tests must be run with multiple font scale factors to catch overflow regressions.
- Developers must wrap interactive widgets in `Semantics` widgets where Flutter's default inference is insufficient.
