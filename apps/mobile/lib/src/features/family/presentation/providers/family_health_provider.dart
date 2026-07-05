import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_repository_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/family/data/repositories/local_family_repository.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_health_score.dart';
import 'package:lifecircle_mobile/src/features/family/domain/services/family_intelligence_engine.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_health_provider.g.dart';

/// Provides the aggregated [FamilyHealthScore] for the current family
/// over the past 7 days.
@riverpod
Future<FamilyHealthScore?> familyHealthScore(FamilyHealthScoreRef ref) async {
  final user = ref.watch(authProvider).valueOrNull;
  if (user == null || user.familyId == null) {
    return null;
  }

  final clock = ref.watch(appClockProvider);
  final endDate = clock.now().toUtc();
  final startDate = endDate.subtract(const Duration(days: 7));

  final familyRepo = ref.read(familyRepositoryProvider);
  final adherenceRepo = ref.read(adherenceRepositoryProvider);

  final members = await familyRepo.getMembers(user.familyId!);

  final allRecords = <AdherenceRecord>[];
  for (final member in members) {
    final records = await adherenceRepo.getAdherenceRecords(
      user.familyId!,
      member.userId,
      startDateUtc: startDate,
      endDateUtc: endDate,
    );
    allRecords.addAll(records);
  }

  const engine = FamilyIntelligenceEngine();
  return engine.calculateFamilyHealthScore(
    members: members,
    allFamilyRecords: allRecords,
  );
}
