/// Represents the execution state of a medicine reminder.
enum ReminderStatus {
  /// The reminder is scheduled for the future and has not yet been acted upon.
  pending,

  /// The user has taken the medicine for this reminder.
  completed,

  /// The user has chosen to skip this dose.
  skipped,

  /// The user has delayed this reminder to a later time.
  snoozed,

  /// The time for this reminder has passed without action.
  missed,
}
