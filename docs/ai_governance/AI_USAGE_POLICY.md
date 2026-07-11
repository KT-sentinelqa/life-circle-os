# AI Usage Policy & Model Selection

## 1. Architectural Constraint (Zero Trust AI)
LifeCircle OS explicitly prohibits the transmission of raw family data (tasks, medical logs, chat) to cloud-based Large Language Models (e.g., OpenAI API, Anthropic API) unless the data is strictly scrubbed of PII and explicit user consent is granted.

## 2. Model Selection (On-Device Preferred)
To maintain our Zero Trust posture, AI features must prioritize **On-Device Execution**:
- **iOS:** CoreML / Apple Neural Engine (using localized small models).
- **Android:** AICore / Local TensorFlow Lite models.

If a feature requires a cloud-hosted LLM (e.g., complex scheduling parsing), the feature must be strictly opt-in, and the data must pass through our `AnalyticsService` PII-scrubber before leaving the device.

## 3. Acceptable Use Cases for AI
- **Predictive Logistics:** Suggesting when to re-order medicine based on local adherence patterns (On-Device).
- **Tone Adjustment:** Helping an exhausted caregiver rephrase a passive-aggressive task assignment into a neutral, deterministic request (On-Device).
- **Pattern Recognition:** Identifying that the "Peace Index" drops every Tuesday and suggesting a redistribution of chores.
