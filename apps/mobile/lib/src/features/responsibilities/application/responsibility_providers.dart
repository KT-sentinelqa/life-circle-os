import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/infrastructure/isar_provider.dart';
import 'package:lifecircle_mobile/src/core/utils/trusted_clock.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/application/responsibility_service.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/infrastructure/repositories/isar_responsibility_repository.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/infrastructure/repositories/responsibility_repository.dart';

final responsibilityRepositoryProvider =
    Provider<ResponsibilityRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return IsarResponsibilityRepository(isar);
});

final responsibilityServiceProvider = Provider<ResponsibilityService>((ref) {
  final repository = ref.watch(responsibilityRepositoryProvider);
  final clock = ref.watch(trustedClockProvider);
  return ResponsibilityService(repository, clock);
});

final familyResponsibilitiesProvider =
    FutureProvider<List<FamilyResponsibility>>((ref) async {
  final repository = ref.watch(responsibilityRepositoryProvider);
  return repository.getAllResponsibilities();
});
