import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/family/data/repositories/local_family_repository.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_members_provider.g.dart';

/// Provides the list of members in the active family.
@riverpod
Future<List<FamilyMemberEntity>> familyMembers(FamilyMembersRef ref) async {
  final user = ref.watch(authProvider).valueOrNull;
  if (user == null || user.familyId == null) {
    return [];
  }

  final familyRepo = ref.read(familyRepositoryProvider);
  return familyRepo.getMembers(user.familyId!);
}
