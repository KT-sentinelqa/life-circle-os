import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_dosage_schedule.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine_log.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_entry_model.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';
import 'package:uuid/uuid.dart';

/// Local implementation of the [MedicineRepository] backed by Isar.
class LocalMedicineRepository implements MedicineRepository {
  /// Creates a [LocalMedicineRepository] requiring a database and clock.
  LocalMedicineRepository(
    this.databaseService,
    this.clock,
  );

  /// The database service providing access to Isar.
  final DatabaseService databaseService;

  /// The clock abstraction for deterministic timestamps.
  final AppClock clock;

  @override
  Future<List<MedicineEntity>> getMedicines(
    String familyId,
    String memberId,
  ) async {
    final isar = databaseService.db;
    final isarMedicines = await isar.isarMedicines
        .filter()
        .familyIdEqualTo(familyId)
        .and()
        .memberIdEqualTo(memberId)
        .findAll();

    return isarMedicines.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveMedicine(
    MedicineEntity medicine,
    DosageScheduleEntity schedule,
  ) async {
    final isar = databaseService.db;

    final isarMedicine = IsarMedicine.fromEntity(medicine);
    final isarSchedule = IsarDosageSchedule.fromEntity(schedule);

    final outboxEntry = IsarOutboxEntry()
      ..id = const Uuid().v4()
      ..aggregateType = 'Medicine'
      ..aggregateId = medicine.id
      ..operationType = 'CREATE'
      ..payload = '{"name": "${medicine.name}"}'
      ..status = SyncStatusEntity.pending
      ..createdAt = clock.now().toUtc()
      ..updatedAt = clock.now().toUtc()
      ..retryCount = 0
      ..deviceId = 'local'
      ..operationId = const Uuid().v4();

    await isar.writeTxn(() async {
      await isar.isarMedicines.put(isarMedicine);
      await isar.isarDosageSchedules.put(isarSchedule);
      await isar.isarOutboxEntrys.put(outboxEntry);
    });
  }

  @override
  Future<DosageScheduleEntity?> getDosageSchedule(String medicineId) async {
    final isar = databaseService.db;
    final isarSchedule = await isar.isarDosageSchedules
        .filter()
        .medicineIdEqualTo(medicineId)
        .findFirst();

    return isarSchedule?.toEntity();
  }

  @override
  Future<void> deleteMedicine(String medicineId) async {
    final isar = databaseService.db;

    final outboxEntry = IsarOutboxEntry()
      ..id = const Uuid().v4()
      ..aggregateType = 'Medicine'
      ..aggregateId = medicineId
      ..operationType = 'DELETE'
      ..payload = '{}'
      ..status = SyncStatusEntity.pending
      ..createdAt = clock.now().toUtc()
      ..updatedAt = clock.now().toUtc()
      ..retryCount = 0
      ..deviceId = 'local'
      ..operationId = const Uuid().v4();

    await isar.writeTxn(() async {
      await isar.isarMedicines.filter().idEqualTo(medicineId).deleteAll();
      await isar.isarDosageSchedules
          .filter()
          .medicineIdEqualTo(medicineId)
          .deleteAll();
      await isar.isarOutboxEntrys.put(outboxEntry);
    });
  }

  @override
  Future<void> logMedicineTaken(MedicineLogEntity log) async {
    final isar = databaseService.db;

    final isarLog = IsarMedicineLog.fromEntity(log);

    final outboxEntry = IsarOutboxEntry()
      ..id = const Uuid().v4()
      ..aggregateType = 'MedicineLog'
      ..aggregateId = log.id
      ..operationType = 'CREATE'
      ..payload = '{"status": "${log.status.name}"}'
      ..status = SyncStatusEntity.pending
      ..createdAt = clock.now().toUtc()
      ..updatedAt = clock.now().toUtc()
      ..retryCount = 0
      ..deviceId = 'local'
      ..operationId = const Uuid().v4();

    await isar.writeTxn(() async {
      await isar.isarMedicineLogs.put(isarLog);
      await isar.isarOutboxEntrys.put(outboxEntry);
    });
  }
}
