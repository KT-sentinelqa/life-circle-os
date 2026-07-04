import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_family.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_invitation.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_member.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_invitation_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:lifecircle_mobile/src/features/family/domain/repositories/family_repository.dart';
import 'package:uuid/uuid.dart';

/// Provider for the [FamilyRepository].
final familyRepositoryProvider = Provider<FamilyRepository>((ref) {
  final dbService = ref.watch(databaseServiceProvider);
  return LocalFamilyRepository(dbService);
});

/// Local database implementation of [FamilyRepository].
class LocalFamilyRepository implements FamilyRepository {
  /// Creates a [LocalFamilyRepository].
  const LocalFamilyRepository(this._dbService);

  final DatabaseService _dbService;
  static const _uuid = Uuid();

  @override
  Future<FamilyEntity> createFamily(String name) async {
    final family = FamilyEntity(
      id: _uuid.v4(),
      name: name,
      createdAt: DateTime.now(),
    );

    final isarFamily = IsarFamily.fromDomain(family);

    await _dbService.db.writeTxn(() async {
      await _dbService.db.isarFamilys.put(isarFamily);
    });

    return family;
  }

  @override
  Future<List<FamilyMemberEntity>> getMembers(String familyId) async {
    final isarMembers = await _dbService.db.isarMembers
        .filter()
        .familyIdEqualTo(familyId)
        .findAll();

    return isarMembers.map((e) => e.toDomain()).toList();
  }

  @override
  Future<FamilyInvitationEntity> inviteMember(
    String familyId, 
    String email,
  ) async {
    final invitation = FamilyInvitationEntity(
      id: _uuid.v4(),
      familyId: familyId,
      email: email,
      invitedAt: DateTime.now(),
    );

    final isarInvitation = IsarInvitation.fromDomain(invitation);

    await _dbService.db.writeTxn(() async {
      await _dbService.db.isarInvitations.put(isarInvitation);
    });

    return invitation;
  }
}
