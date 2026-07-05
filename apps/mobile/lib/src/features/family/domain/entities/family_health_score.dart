import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_health_score.freezed.dart';
part 'family_health_score.g.dart';

/// Aggregated adherence and health metrics for a family.
@freezed
class FamilyHealthScore with _$FamilyHealthScore {
  /// Creates a [FamilyHealthScore].
  const factory FamilyHealthScore({
    /// Total doses scheduled across all family members.
    required int totalDosesScheduled,

    /// Total doses taken across all family members.
    required int totalDosesTaken,

    /// Total doses missed across all family members.
    required int totalDosesMissed,

    /// The weighted adherence percentage for the family (0.0 to 1.0).
    required double adherencePercentage,

    /// Number of active caregivers.
    required int activeCaregiverCount,

    /// Number of members with 'critical' or 'atRisk' status.
    required int membersAtRisk,
  }) = _FamilyHealthScore;

  /// Creates a [FamilyHealthScore] from a JSON object.
  factory FamilyHealthScore.fromJson(Map<String, dynamic> json) =>
      _$FamilyHealthScoreFromJson(json);
}
