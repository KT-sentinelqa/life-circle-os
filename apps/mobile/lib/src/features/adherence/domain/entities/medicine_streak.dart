/// Represents consecutive days of perfect adherence.
class MedicineStreak {
  /// Creates a [MedicineStreak].
  const MedicineStreak({
    required this.id,
    required this.familyId,
    required this.memberId,
    required this.currentStreak,
    required this.longestStreak,
    this.medicineId,
    this.lastPerfectDateUtc,
  });

  /// Unique identifier.
  final String id;

  /// The family this streak belongs to.
  final String familyId;

  /// The specific member this streak belongs to.
  final String memberId;

  /// If null, this represents the global streak across all medicines.
  final String? medicineId;

  /// Number of consecutive days of perfect adherence ending
  /// on [lastPerfectDateUtc].
  final int currentStreak;

  /// Historical longest streak.
  final int longestStreak;

  /// The most recent day of perfect adherence.
  final DateTime? lastPerfectDateUtc;
}
