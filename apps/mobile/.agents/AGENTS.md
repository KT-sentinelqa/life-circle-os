# Engineering Constitution & Rules

## Release Guidelines
- **RULE #1**: RED GATE = NO COMMIT
- **RULE #2**: RED GATE = NO PUSH
- **RULE #3**: RED GATE = NO TAG
- **RULE #4**: Release Sequence:
  1. `build_runner` (success)
  2. `flutter analyze` (0 issues)
  3. `flutter test` (100% pass)
  4. commit
  5. push
  6. tag
  7. merge
  8. start next phase
- **GREEN GATE POLICY v1.0**: You must NEVER commit, push, tag, or transition phases if the build, analyzer, or tests fail.

## Architecture & Design Guidelines
- **RULE #5**: Domain entities must be the source of truth. Notifications are projections, not state owners.
- **RULE #6**: No bool flags for state machines. Use enums (e.g., `enum ReminderStatus { pending, completed, skipped, snoozed, missed }`).

## Testing Guidelines
- **RULE #7**: Tests must use deterministic clocks. Never depend on the system time. (Always inject `MockAppClock` into providers when dealing with time-sensitive logic).
- **RULE #8**: All custom Mocktail types require `registerFallbackValue()` during `setUpAll()` before they can be used with `any()` or `captureAny()`.
