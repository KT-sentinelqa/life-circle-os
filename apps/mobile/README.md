# LifeCircle OS: Mobile App

**The Operating System for Indian Families.**

LifeCircle OS is a multigenerational family management application designed to centralize and automate the critical responsibilities that keep a household running smoothly. From medical adherence to financial obligations and household duties, LifeCircle OS provides peace of mind through unified intelligence.

## 🚀 Product Vision
* **Health & Medical**: Centralized tracking for elders' medication, appointments, and vitals.
* **Financial Protection**: Unified dashboard for EMIs, loan schedules, and insurance renewals.
* **Shared Responsibility**: Clear delegation and timeline tracking for household chores and special events.
* **Peace-of-Mind Engine**: An algorithmic score (0-100) combining adherence, financial health, and duty completion to give families a single "Care Score" metric.

## 🏗 High-Level Architecture
The application is built on modern, robust Flutter foundations:
- **Framework**: Flutter (v3.27+) with strictly typed Dart 3.
- **State Management**: Riverpod (`riverpod_annotation`, `flutter_riverpod`) for reactive, deterministic state.
- **Routing**: GoRouter for type-safe, declarative navigation and deep-linking.
- **Local Storage**: Isar database for high-performance, offline-first data persistence.
- **Domain-Driven Design**: Clean architecture separating Entities, Data Repositories, and Presentation layers.

## 🎬 Investor Demo Showcase (v0.3.0)
The app includes a fully deterministic "Showcase Mode" featuring the **Sharma Family**.

**The Scenario:**
- **Rajesh (Father)**: Managing BP & Diabetes medications.
- **Sunita (Mother)**: Managing Arthritis care and Physiotherapy.
- **Amit (Son)**: Responsible for EMI payments (Home Loan, Car Loan) and Insurance renewals.
- **Priya (Daughter-in-law)**: Coordinating weekly groceries and morning medicines.
- **Aarav (Child)**: Upcoming birthday event.

**How to trigger the Demo:**
1. Launch the app and view the emotional onboarding sequence.
2. Tap "Try Demo Family" at the end of onboarding.
3. The dashboard will instantly populate the Sharma Family data and calculate the dynamic Peace-of-Mind Score based on the unified timeline.

## 🛠 Setup & Run
Ensure you are using FVM (Flutter Version Management).
```bash
# Install dependencies
fvm flutter pub get

# Generate freezed/riverpod boilerplate
fvm dart run build_runner build --delete-conflicting-outputs

# Run the app
fvm flutter run
```

## 🧪 Testing
We maintain rigorous quality gates including 100% deterministic Golden Tests for UI regression protection.
```bash
# Run tests
fvm flutter test

# Update golden snapshots
fvm flutter test --update-goldens
```
