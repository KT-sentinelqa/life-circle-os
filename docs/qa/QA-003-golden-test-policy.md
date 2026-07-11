# QA-003: Golden Test Policy

**Status:** Active | **Phase:** 6B

To prevent UI regressions and ensure visual stability across LifeCircle OS, we mandate the use of Golden Tests.

## Policy Rules

1. **Coverage Requirements:**
   Every distinct screen (e.g., Dashboard, Responsibilities, Emergency) and major complex widget (e.g., Peace Index Card, Add Responsibility Sheet) must have golden tests.

2. **Required Variations per Screen:**
   - Light Mode
   - Dark Mode
   - Dynamic Type (Standard vs. 150% scaled)
   - Simulated Device Sizes (e.g., iPhone SE, iPhone 14 Pro Max, iPad Mini)

3. **Golden Generation:**
   - Goldens are generated strictly using the `golden_toolkit` package.
   - Run `flutter test --update-goldens` to generate baseline images.
   - Baseline images must be committed to version control.

4. **CI Enforcement:**
   - The CI pipeline will execute `flutter test`. If any pixel deviates from the committed golden baseline, the build fails.
   - If a visual change is intentional, the developer must regenerate the goldens and include them in the Pull Request for explicit design review.

5. **Mocking Data:**
   - Golden tests must use deterministic mock data (e.g., fixed dates via `TrustedClock`, fixed UUIDs, predictable text) to prevent flakiness.
