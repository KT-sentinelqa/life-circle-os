import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';

part 'isar_adherence_record.g.dart';

/// Isar collection mapping for [AdherenceRecord].
@collection
class IsarAdherenceRecord {
  /// Creates an empty [IsarAdherenceRecord].
  IsarAdherenceRecord();

  /// Creates this Isar model from a pure domain [AdherenceRecord].
  IsarAdherenceRecord.fromEntity(AdherenceRecord entity) {
    id = entity.id;
    familyId = entity.familyId;
    memberId = entity.memberId;
    medicineId = entity.medicineId;
    dateUtc = entity.dateUtc;
    dosesScheduled = entity.dosesScheduled;
    dosesTaken = entity.dosesTaken;
    dosesSkipped = entity.dosesSkipped;
    dosesMissed = entity.dosesMissed;
    status = entity.status;
  }

  /// Auto-incremented Isar ID.
  Id isarId = Isar.autoIncrement;

  /// Domain entity unique identifier.
  @Index(unique: true, replace: true)
  late String id;

  /// Family ID for scoped querying.
  @Index()
  late String familyId;

  /// Member ID for scoped querying.
  @Index()
  late String memberId;

  /// Associated medicine ID, if applicable.
  @Index()
  String? medicineId;

  /// Date (UTC) of this adherence record.
  @Index()
  late DateTime dateUtc;

  /// Total doses scheduled.
  late int dosesScheduled;

  /// Total doses taken.
  late int dosesTaken;

  /// Total doses skipped.
  late int dosesSkipped;

  /// Total doses missed.
  late int dosesMissed;

  /// Computed adherence status.
  @enumerated
  late AdherenceStatus status;

  /// Converts this Isar model to a pure domain [AdherenceRecord].
  AdherenceRecord toEntity() {
    return AdherenceRecord(
      id: id,
      familyId: familyId,
      memberId: memberId,
      medicineId: medicineId,
      dateUtc: dateUtc,
      dosesScheduled: dosesScheduled,
      dosesTaken: dosesTaken,
      dosesSkipped: dosesSkipped,
      dosesMissed: dosesMissed,
      status: status,
    );
  }
}
