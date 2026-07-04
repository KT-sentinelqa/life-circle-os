import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_dosage_schedule.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine_log.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_reminder.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
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
      await isar.isarReminders
          .filter()
          .medicineIdEqualTo(medicineId)
          .deleteAll();
      await isar.isarOutboxEntrys.put(outboxEntry);
    });
  }

  @override
  Future<void> saveReminders(List<ReminderEntity> reminders) async {
    final isar = databaseService.db;
    final isarReminders = reminders.map(IsarReminder.fromEntity).toList();

    await isar.writeTxn(() async {
      await isar.isarReminders.putAll(isarReminders);
    });
  }

  @override
  Future<void> updateReminder(ReminderEntity reminder) async {
    final isar = databaseService.db;
    final isarReminder = IsarReminder.fromEntity(reminder);

    final outboxEntry = IsarOutboxEntry()
      ..id = const Uuid().v4()
      ..aggregateType = 'Reminder'
      ..aggregateId = reminder.id
      ..operationType = 'UPDATE'
      ..payload = '{"status": "${reminder.status.name}"}'
      ..status = SyncStatusEntity.pending
      ..createdAt = clock.now().toUtc()
      ..updatedAt = clock.now().toUtc()
      ..retryCount = 0
      ..deviceId = 'local'
      ..operationId = const Uuid().v4();

    await isar.writeTxn(() async {
      await isar.isarReminders.put(isarReminder);
      await isar.isarOutboxEntrys.put(outboxEntry);
    });
  }

  @override
  Future<void> markReminderCompleted(
    String reminderId,
    DateTime completedAt,
  ) async {
    final isar = databaseService.db;
    final isarReminder = await isar.isarReminders
        .filter()
        .idEqualTo(reminderId)
        .findFirst();

    if (isarReminder == null) return;

    final existing = isarReminder.toEntity();
    final updatedEntity = ReminderEntity(
      id: existing.id,
      medicineId: existing.medicineId,
      familyId: existing.familyId,
      memberId: existing.memberId,
      scheduledTimeUtc: existing.scheduledTimeUtc,
      status: ReminderStatus.completed,
      completedAt: completedAt,
      skippedAt: existing.skippedAt,
      snoozedUntil: existing.snoozedUntil,
      note: existing.note,
      createdAt: existing.createdAt,
      updatedAt: clock.now().toUtc(),
    );

    await updateReminder(updatedEntity);
  }

  @override
  Future<void> markReminderSkipped(
    String reminderId,
    DateTime skippedAt,
  ) async {
    final isar = databaseService.db;
    final isarReminder = await isar.isarReminders
        .filter()
        .idEqualTo(reminderId)
        .findFirst();

    if (isarReminder == null) return;

    final existing = isarReminder.toEntity();
    final updatedEntity = ReminderEntity(
      id: existing.id,
      medicineId: existing.medicineId,
      familyId: existing.familyId,
      memberId: existing.memberId,
      scheduledTimeUtc: existing.scheduledTimeUtc,
      status: ReminderStatus.skipped,
      completedAt: existing.completedAt,
      skippedAt: skippedAt,
      snoozedUntil: existing.snoozedUntil,
      note: existing.note,
      createdAt: existing.createdAt,
      updatedAt: clock.now().toUtc(),
    );

    await updateReminder(updatedEntity);
  }

  @override
  Future<void> snoozeReminder(
    String reminderId,
    Duration snoozeDuration,
  ) async {
    final isar = databaseService.db;
    final isarReminder = await isar.isarReminders
        .filter()
        .idEqualTo(reminderId)
        .findFirst();

    if (isarReminder == null) return;

    final now = clock.now().toUtc();
    final existing = isarReminder.toEntity();
    final updatedEntity = ReminderEntity(
      id: existing.id,
      medicineId: existing.medicineId,
      familyId: existing.familyId,
      memberId: existing.memberId,
      scheduledTimeUtc: existing.scheduledTimeUtc,
      status: ReminderStatus.snoozed,
      completedAt: existing.completedAt,
      skippedAt: existing.skippedAt,
      snoozedUntil: now.add(snoozeDuration),
      note: existing.note,
      createdAt: existing.createdAt,
      updatedAt: now,
    );

    await updateReminder(updatedEntity);
  }

  @override
  Future<void> markReminderMissed(String reminderId) async {
    final isar = databaseService.db;
    final isarReminder = await isar.isarReminders
        .filter()
        .idEqualTo(reminderId)
        .findFirst();

    if (isarReminder == null) return;

    final existing = isarReminder.toEntity();
    final updatedEntity = ReminderEntity(
      id: existing.id,
      medicineId: existing.medicineId,
      familyId: existing.familyId,
      memberId: existing.memberId,
      scheduledTimeUtc: existing.scheduledTimeUtc,
      status: ReminderStatus.missed,
      completedAt: existing.completedAt,
      skippedAt: existing.skippedAt,
      snoozedUntil: existing.snoozedUntil,
      note: existing.note,
      createdAt: existing.createdAt,
      updatedAt: clock.now().toUtc(),
    );

    await updateReminder(updatedEntity);
  }

  @override
  Future<void> restoreReminderToPending(String reminderId) async {
    final isar = databaseService.db;
    final isarReminder = await isar.isarReminders
        .filter()
        .idEqualTo(reminderId)
        .findFirst();

    if (isarReminder == null) return;

    final existing = isarReminder.toEntity();
    final updatedEntity = ReminderEntity(
      id: existing.id,
      medicineId: existing.medicineId,
      familyId: existing.familyId,
      memberId: existing.memberId,
      scheduledTimeUtc: existing.scheduledTimeUtc,
      status: ReminderStatus.pending,
      completedAt: existing.completedAt,
      skippedAt: existing.skippedAt,
      snoozedUntil: existing.snoozedUntil,
      note: existing.note,
      createdAt: existing.createdAt,
      updatedAt: clock.now().toUtc(),
    );

    await updateReminder(updatedEntity);
  }

  @override
  Future<List<ReminderEntity>> getRemindersByStatuses(
    String familyId,
    String memberId,
    List<ReminderStatus> statuses,
  ) async {
    final isar = databaseService.db;
    
    // Convert entity statuses to Isar model status strings
    final statusStrings = statuses.map((s) => s.name).toList();

    final isarReminders = await isar.isarReminders
        .filter()
        .familyIdEqualTo(familyId)
        .and()
        .memberIdEqualTo(memberId)
        .and()
        .anyOf(statusStrings, (q, String s) => q.statusEqualTo(s))
        .findAll();

    return isarReminders.map((r) => r.toEntity()).toList();
  }

  @override
  Future<List<ReminderEntity>> getRemindersForDate(
    String familyId,
    String memberId,
    DateTime date,
  ) async {
    final isar = databaseService.db;
    
    final startOfDay = DateTime.utc(date.year, date.month, date.day);
    final endOfDay = DateTime.utc(
      date.year,
      date.month,
      date.day,
      23,
      59,
      59,
      999,
    );

    final isarReminders = await isar.isarReminders
        .filter()
        .familyIdEqualTo(familyId)
        .and()
        .memberIdEqualTo(memberId)
        .and()
        .scheduledTimeUtcBetween(startOfDay, endOfDay)
        .findAll();

    return isarReminders.map((r) => r.toEntity()).toList();
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
