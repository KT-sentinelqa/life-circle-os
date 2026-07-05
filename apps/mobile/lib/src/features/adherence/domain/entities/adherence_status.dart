/// Represents the user's adherence level for a specific period.
enum AdherenceStatus {
  /// 100% adherence.
  perfect,

  /// High adherence (e.g., 80-99%).
  good,

  /// Average adherence (e.g., 50-79%), might need attention.
  atRisk,

  /// Low adherence (e.g., <50%), critical intervention needed.
  critical,

  /// No data available for this period.
  unknown,
}
