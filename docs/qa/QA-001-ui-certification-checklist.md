# QA-001: UI Certification Checklist

**Status:** Active | **Phase:** 6B

Before any screen is merged into the `main` branch or considered Beta-ready, it must pass the following manual and automated checks.

## 1. Visual States
- [ ] Light Mode rendering
- [ ] Dark Mode rendering
- [ ] Empty State (no data)
- [ ] Skeleton State (loading data)
- [ ] Error State (inline recovery, no blocking dialogs)
- [ ] Offline State (clear indication if actions are queued)

## 2. Accessibility (ADR-040)
- [ ] Minimum contrast ratio verified (4.5:1)
- [ ] Text scales gracefully at 150% and 200% font size without overflow
- [ ] All interactive widgets have meaningful VoiceOver/TalkBack Semantics
- [ ] Reduced Motion gracefully disables complex animations
- [ ] Touch targets are at least 48x48 logical pixels

## 3. Interactions
- [ ] Keyboard does not obscure input fields (keyboard-aware layout)
- [ ] Proper haptic feedback on success/failure actions
- [ ] Safe Area bounds are respected (no UI clipping under notches or dynamic islands)
- [ ] Device rotation (Landscape/Portrait) maintains usable layouts
- [ ] Backgrounding and foregrounding the app maintains exact state

## 4. Resilience
- [ ] Disabling network connectivity during an action gracefully queues the event
- [ ] Reconnecting flushes the queue accurately
- [ ] No infinite loading spinners on network timeouts
