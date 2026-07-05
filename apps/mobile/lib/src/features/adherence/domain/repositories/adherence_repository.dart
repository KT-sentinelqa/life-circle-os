import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/medicine_streak.dart';

/// Contract for managing adherence persistence.
abstract interface class AdherenceRepository {
  /// Saves an adherence record for a specific date and context.
  Future<void> saveAdherenceRecord(AdherenceRecord record);

  /// Retrieves adherence records within a date range for a user.
  /// If [medicineId] is provided, gets records for that specific medicine.
  /// If [medicineId] is null, gets aggregated records across all medicines.
  Future<List<AdherenceRecord>> getAdherenceRecords(
    String familyId,
    String memberId, {
    required DateTime startDateUtc,
    required DateTime endDateUtc,
    String? medicineId,
  });

  /// Saves a user's adherence streak.
  Future<void> saveMedicineStreak(MedicineStreak streak);

  /// Retrieves a user's adherence streak.
  /// If [medicineId] is provided, gets the streak for that specific medicine.
  /// If [medicineId] is null, gets the aggregated global streak.
  Future<MedicineStreak?> getMedicineStreak(
    String familyId,
    String memberId, {
    String? medicineId,
  });
}
