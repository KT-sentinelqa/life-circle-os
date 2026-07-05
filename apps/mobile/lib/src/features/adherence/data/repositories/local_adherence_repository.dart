import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_medicine_streak.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/medicine_streak.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/repositories/adherence_repository.dart';

/// Isar-backed implementation of [AdherenceRepository].
class LocalAdherenceRepository implements AdherenceRepository {
  /// Creates a [LocalAdherenceRepository].
  const LocalAdherenceRepository(this._databaseService);

  final DatabaseService _databaseService;

  Isar get _db => _databaseService.db;

  @override
  Future<void> saveAdherenceRecord(AdherenceRecord record) async {
    final isarRecord = IsarAdherenceRecord.fromEntity(record);
    await _db.writeTxn(() async {
      await _db.isarAdherenceRecords.put(isarRecord);
    });
  }

  @override
  Future<List<AdherenceRecord>> getAdherenceRecords(
    String familyId,
    String memberId, {
    required DateTime startDateUtc,
    required DateTime endDateUtc,
    String? medicineId,
  }) async {
    var query = _db.isarAdherenceRecords
        .filter()
        .familyIdEqualTo(familyId)
        .and()
        .memberIdEqualTo(memberId)
        .and()
        .dateUtcBetween(startDateUtc, endDateUtc);

    if (medicineId != null) {
      query = query.and().medicineIdEqualTo(medicineId);
    } else {
      query = query.and().medicineIdIsNull();
    }

    final records = await query.findAll();
    return records.map((r) => r.toEntity()).toList();
  }

  @override
  Future<void> saveMedicineStreak(MedicineStreak streak) async {
    final isarStreak = IsarMedicineStreak.fromEntity(streak);
    await _db.writeTxn(() async {
      await _db.isarMedicineStreaks.put(isarStreak);
    });
  }

  @override
  Future<MedicineStreak?> getMedicineStreak(
    String familyId,
    String memberId, {
    String? medicineId,
  }) async {
    var query = _db.isarMedicineStreaks
        .filter()
        .familyIdEqualTo(familyId)
        .and()
        .memberIdEqualTo(memberId);

    if (medicineId != null) {
      query = query.and().medicineIdEqualTo(medicineId);
    } else {
      query = query.and().medicineIdIsNull();
    }

    final isarStreak = await query.findFirst();
    return isarStreak?.toEntity();
  }
}
