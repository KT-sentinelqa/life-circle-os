import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/core/notifications/providers/notification_provider.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/repositories/local_medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/reminder_scheduler.dart';

/// Provider for the [AppClock].
final appClockProvider = Provider<AppClock>((ref) {
  return const SystemClock();
});

/// Provider for the [MedicineRepository].
final medicineRepositoryProvider = Provider<MedicineRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  final clock = ref.watch(appClockProvider);
  return LocalMedicineRepository(dbService, clock);
});

/// Provider for the [ReminderScheduler].
final reminderSchedulerProvider = Provider<ReminderScheduler>((ref) {
  final notificationService = ref.watch(notificationServiceProvider);
  return ReminderScheduler(notificationService);
});
