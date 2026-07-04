import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';

/// Abstract contract for managing medicine persistence and sync.
abstract interface class MedicineRepository {
  /// Retrieves a list of medicines belonging to a specific family member.
  Future<List<MedicineEntity>> getMedicines(
    String familyId,
    String memberId,
  );

  /// Saves a new medicine alongside its dosage schedule.
  Future<void> saveMedicine(
    MedicineEntity medicine,
    DosageScheduleEntity schedule,
  );

  /// Retrieves the dosage schedule for a specific medicine.
  Future<DosageScheduleEntity?> getDosageSchedule(String medicineId);

  /// Deletes a medicine and its associated schedule.
  Future<void> deleteMedicine(String medicineId);

  /// Logs a medicine action (e.g., taken, missed, skipped).
  Future<void> logMedicineTaken(
    MedicineLogEntity log,
  );
}
