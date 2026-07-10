import '../../responsibilities/domain/models/family_responsibility.dart';
import '../../responsibilities/domain/models/responsibility_status.dart';
import '../../responsibilities/domain/models/responsibility_category.dart';
import '../../../../core/utils/trusted_clock.dart';
import '../domain/models/peace_index_audit_entry.dart';

/// The result of a Peace Index calculation — score plus a full audit trail.
class PeaceIndexResult {
  final int score;
  final List<PeaceIndexAuditEntry> auditEntries;

  const PeaceIndexResult({required this.score, required this.auditEntries});
}

/// PeaceIndexService — calculates the Family Peace Score (ADR-022).
///
/// Design invariants:
///   1. Every penalty is logged to an audit entry. Every score is explainable.
///   2. SEC-016: Only responsibilities the user is authorized to see are included.
///   3. Deterministic: same inputs → same output. TrustedClock is injected.
class PeaceIndexService {
  final TrustedClock _clock;
  PeaceIndexService(this._clock);

  /// Health penalties: -20 per escalated responsibility
  static const int _healthEscalationPenalty  = 20;
  /// Finance penalties: -10 per escalated responsibility
  static const int _financeEscalationPenalty = 10;
  /// Household/Other penalties: -5 per escalated responsibility
  static const int _otherEscalationPenalty   =  5;
  /// Cooling off: score capped at 95 within 24h of recovery from escalation
  static const int _coolingOffCap  = 95;
  static const int _coolingOffHours = 24;

  /// Calculates the contextual Peace Index for [currentUserId].
  ///
  /// Returns a [PeaceIndexResult] containing the score and a full audit trail.
  /// The audit trail makes every score change explainable to engineering.
  PeaceIndexResult calculateWithAudit(
    String currentUserId,
    List<FamilyResponsibility> allResponsibilities,
    String householdId, {
    int previousScore = 100,
  }) {
    final now = _clock.now();
    final entries = <PeaceIndexAuditEntry>[];
    int score = 100;

    // SEC-016: Contextual Aggregation — filter to authorized view only
    final authorized = allResponsibilities.where((r) =>
      r.primaryOwnerId == currentUserId ||
      r.backupOwnerId == currentUserId,
    ).toList();

    for (final resp in authorized) {
      if (resp.status == ResponsibilityStatus.escalated) {
        final penalty = _penaltyFor(resp.category);
        score -= penalty;

        entries.add(PeaceIndexAuditEntry()
          ..householdId = householdId
          ..previousScore = score + penalty
          ..newScore = score
          ..delta = -penalty
          ..reason = '${_categoryLabel(resp.category)} responsibility escalated'
          ..triggeringResponsibilityUuid = resp.uuid
          ..triggeringCategory = resp.category.name
          ..calculatedAt = now);

      } else if (resp.status == ResponsibilityStatus.completed) {
        final hoursSince = now.difference(resp.updatedAt).inHours;
        if (hoursSince < _coolingOffHours && resp.confidenceScore < 100) {
          if (score > _coolingOffCap) {
            final before = score;
            score = _coolingOffCap;

            entries.add(PeaceIndexAuditEntry()
              ..householdId = householdId
              ..previousScore = before
              ..newScore = score
              ..delta = score - before
              ..reason = '24-hour cooling off applied after recovery'
              ..triggeringResponsibilityUuid = resp.uuid
              ..triggeringCategory = resp.category.name
              ..calculatedAt = now);
          }
        }
      }
    }

    final finalScore = score.clamp(0, 100);
    return PeaceIndexResult(score: finalScore, auditEntries: entries);
  }

  /// Lightweight integer-only path — used by Riverpod providers.
  int calculateContextualIndex(
    String currentUserId,
    List<FamilyResponsibility> allResponsibilities,
  ) {
    return calculateWithAudit(
      currentUserId,
      allResponsibilities,
      'default', // householdId not needed for score-only path
    ).score;
  }

  int _penaltyFor(ResponsibilityCategory category) => switch (category) {
    ResponsibilityCategory.health   => _healthEscalationPenalty,
    ResponsibilityCategory.finance  => _financeEscalationPenalty,
    _                               => _otherEscalationPenalty,
  };

  String _categoryLabel(ResponsibilityCategory c) => switch (c) {
    ResponsibilityCategory.health   => 'Health',
    ResponsibilityCategory.finance  => 'Finance',
    ResponsibilityCategory.household=> 'Household',
    _                               => 'General',
  };
}
