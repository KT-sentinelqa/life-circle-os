import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_list_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:uuid/uuid.dart';

/// Notifier for adding/editing/deleting a medicine.
class MedicineFormNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Saves the medicine and schedule.
  Future<void> saveMedicine({
    required String name,
    required String dosage,
    required String form,
    required String instructions,
    required int frequencyPerDay,
    String? id,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(authProvider).valueOrNull;
      if (user == null || user.familyId == null) {
        throw StateError(
          'Cannot save medicine without an active user and family',
        );
      }

      final repository = ref.read(medicineRepositoryProvider);
      final clock = ref.read(appClockProvider);
      final now = clock.now().toUtc();
      
      final medicineId = id ?? const Uuid().v4();

      final medicine = MedicineEntity(
        id: medicineId,
        familyId: user.familyId!,
        memberId: user.id,
        name: name,
        dosage: dosage,
        form: form,
        instructions: instructions,
        createdAtUtc: now,
        updatedAtUtc: now,
      );

      final schedule = DosageScheduleEntity(
        id: const Uuid().v4(),
        medicineId: medicineId,
        familyId: user.familyId!,
        memberId: user.id,
        frequencyPerDay: frequencyPerDay,
        timesOfDay: [],
        specificDaysOfWeek: [],
        createdAtUtc: now,
        updatedAtUtc: now,
      );

      await repository.saveMedicine(medicine, schedule);
      await ref.read(medicineListStateProvider.notifier).refresh();
    });
  }

  /// Deletes the given medicine.
  Future<void> deleteMedicine(String medicineId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(medicineRepositoryProvider);
      await repository.deleteMedicine(medicineId);
      await ref.read(medicineListStateProvider.notifier).refresh();
    });
  }
}

/// Provider for the medicine form state.
final medicineFormProvider =
    AutoDisposeAsyncNotifierProvider<MedicineFormNotifier, void>(
  MedicineFormNotifier.new,
);

/// Provider to fetch an existing dosage schedule for editing.
final dosageScheduleProvider =
    AutoDisposeFutureProviderFamily<DosageScheduleEntity?, String>(
  (ref, medicineId) async {
    final repository = ref.read(medicineRepositoryProvider);
    return repository.getDosageSchedule(medicineId);
  },
);
