/// Defines how a missed dose should be escalated.
enum EscalationPolicy {
  /// No escalation for missed doses.
  none,

  /// Notify assigned caregivers after the grace period.
  standard,

  /// Notify caregivers and the owner immediately.
  emergency,
}
