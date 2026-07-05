import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/infrastructure/providers/isar_provider.dart';
import '../infrastructure/repositories/isar_responsibility_repository.dart';
import '../infrastructure/repositories/responsibility_repository.dart';
import 'responsibility_service.dart';
import '../domain/models/family_responsibility.dart';

final responsibilityRepositoryProvider = Provider<ResponsibilityRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return IsarResponsibilityRepository(isar);
});

final responsibilityServiceProvider = Provider<ResponsibilityService>((ref) {
  final repository = ref.watch(responsibilityRepositoryProvider);
  return ResponsibilityService(repository);
});

final familyResponsibilitiesProvider = FutureProvider<List<FamilyResponsibility>>((ref) async {
  final repository = ref.watch(responsibilityRepositoryProvider);
  return await repository.getAllResponsibilities();
});
