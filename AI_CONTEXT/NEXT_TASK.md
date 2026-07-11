---
task_id: "SEC-001"
priority: "P0"
assignee: "Gemini"
status: "Ready"
---
# Next Task: Eradicate Mock Authentication

**Objective**: Remove all mock auth dependencies and fake JWT tokens from the production pipeline. The application must wire up to the genuine authentication interface without bypassing security controls.

**Acceptance Criteria**:
- No `MockAuthRepository` or `FakeSessionManager` referenced in `main.dart` or production providers.
- LocalAuthRepository interacts with real storage/network.
