# LifeCircle OS - Investor Demo Script

This document provides a deterministic, step-by-step walkthrough for presenting LifeCircle OS to investors. The demo utilizes the deterministic seed engine built in Sprint 2.7 to ensure a 100% reproducible experience.

## Setup
1. Launch the app on a physical device (or simulator).
2. Ensure you are at the `OnboardingScreen`.

## Scene 1: The Vision
**Action:** Show the Onboarding Screen with the breathing gradient.
**Talking Track:** 
> "LifeCircle OS is the operating system for Indian families. It brings household management, health tracking, and family coordination into one secure, offline-first environment."

## Scene 2: Deterministic Demo Login
**Action:** Tap the `Try Demo Family` button.
**Expected Result:** The app skips the Auth flow and instantly populates the Isar database with `DemoScenario.healthyFamily`. You are redirected to the `FamilyDashboardScreen`.
**Talking Track:**
> "By tapping this, we bypass the standard SMS OTP and instantly load a fully populated, offline-first family environment."

## Scene 3: The Family Dashboard & Health Score
**Action:** On the `FamilyDashboardScreen`, highlight the pulsing **Family Health Score Card**.
**Expected Result:** A smooth, spring-animated gauge shows the family's health score.
**Talking Track:**
> "Here is the unified dashboard. The health score aggregates the well-being of all members. Notice the fluid motion and premium typography—all running natively without network latency."

## Scene 4: Medicine Module & Adherence
**Action:** Tap the **Medications** module to navigate to the `MedicineDashboardScreen`.
**Expected Result:** The `TodayMedicationsView` loads showing upcoming and completed doses.
**Talking Track:**
> "Health is a core pillar. Here we see today's medications for the family. Because this is offline-first, this data is instantly available, ensuring no dose is missed even in poor connectivity."

**Action:** Tap the **Adherence** tab.
**Expected Result:** Displays the `AdherenceSummaryCard`, `WeeklyInsightsCard`, and `AdherenceHeatmap`.
**Talking Track:**
> "We provide deep, actionable insights. The heatmap gives a GitHub-style contribution graph of a family member's adherence history."

## Scene 5: Motion and Polish
**Action:** Navigate back and forth between tabs and screens.
**Expected Result:** Observe the `LcSharedAxisSwitcher` and `FadePageRoute` transitions.
**Talking Track:**
> "Every interaction, from the buttons to the page transitions, is governed by a unified design token system, providing a tactile, premium experience."

## End of Demo
**Action:** Leave the device on the dashboard for the investors to explore.
