import 'package:lifecircle_mobile/src/features/adherence/domain/entities/medicine_streak.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_repository_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medicine_streak_provider.g.dart';

/// Provides the current streak for a medicine, or global streak if null.
@riverpod
Future<MedicineStreak?> medicineStreak(
  MedicineStreakRef ref, {
  String? medicineId,
}) async {
  final user = ref.watch(authProvider).valueOrNull;
  if (user == null || user.familyId == null) {
    return null;
  }

  final repository = ref.watch(adherenceRepositoryProvider);
  return repository.getMedicineStreak(
    user.familyId!,
    user.id,
    medicineId: medicineId,
  );
}
