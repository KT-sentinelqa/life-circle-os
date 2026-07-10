import 'package:isar/isar.dart';

part 'peace_index_audit_entry.g.dart';

/// An immutable record of every Peace Score change.
/// Purpose: Every score shown to the user must be traceable and explainable
/// to engineering — not necessarily to the user (MILESTONE 3 spec).
@collection
class PeaceIndexAuditEntry {
  Id id = Isar.autoIncrement;

  @Index()
  late String householdId;

  late int previousScore;
  late int newScore;
  late int delta; // newScore - previousScore (negative = score dropped)

  /// Human-readable reason for the score change.
  /// Examples: "Health responsibility escalated", "Cooling off period applied"
  late String reason;

  /// The responsibility UUID that triggered this change, if applicable.
  String? triggeringResponsibilityUuid;

  /// The category of the triggering responsibility.
  String? triggeringCategory;

  late DateTime calculatedAt;
}
