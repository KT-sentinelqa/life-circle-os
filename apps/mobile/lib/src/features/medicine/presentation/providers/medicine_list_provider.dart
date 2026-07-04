import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medicine_list_provider.g.dart';

/// Provider for the list of medicines for the current user.
@riverpod
class MedicineListState extends _$MedicineListState {
  @override
  Future<List<MedicineEntity>> build() async {
    final user = ref.watch(authProvider).valueOrNull;
    if (user == null || user.familyId == null) {
      return [];
    }

    final repository = ref.watch(medicineRepositoryProvider);
    return repository.getMedicines(user.familyId!, user.id);
  }

  /// Refreshes the list of medicines.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(build);
  }
}
