/// Aggregate intelligence metrics for a specific period (e.g. week, month).
class AdherenceMetrics {
  /// Creates [AdherenceMetrics].
  const AdherenceMetrics({
    required this.totalDosesScheduled,
    required this.totalDosesTaken,
    required this.totalDosesMissed,
    required this.totalDosesSkipped,
    required this.adherencePercentage,
    required this.streak,
  });

  /// Total number of doses scheduled in this period.
  final int totalDosesScheduled;

  /// Total number of doses taken in this period.
  final int totalDosesTaken;

  /// Total number of doses missed in this period.
  final int totalDosesMissed;

  /// Total number of doses intentionally skipped in this period.
  final int totalDosesSkipped;

  /// Adherence percentage (0.0 to 1.0) based on taken / scheduled.
  final double adherencePercentage;

  /// The active streak at the end of this metric's period.
  final int streak;
}
