import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/infrastructure/repositories/responsibility_repository.dart';

class IsarResponsibilityRepository implements ResponsibilityRepository {
  IsarResponsibilityRepository(this.isar);
  final Isar isar;

  @override
  Future<void> saveResponsibility(FamilyResponsibility responsibility) async {
    await isar.writeTxn(() async {
      await isar.familyResponsibilitys.put(responsibility);
    });
  }

  @override
  Future<FamilyResponsibility?> getResponsibilityByUuid(String uuid) async {
    return isar.familyResponsibilitys.where().uuidEqualTo(uuid).findFirst();
  }

  @override
  Future<List<FamilyResponsibility>> getAllResponsibilities() async {
    return isar.familyResponsibilitys.where().findAll();
  }

  @override
  Future<void> deleteResponsibility(String uuid) async {
    await isar.writeTxn(() async {
      final responsibility = await getResponsibilityByUuid(uuid);
      if (responsibility != null) {
        await isar.familyResponsibilitys.delete(responsibility.id);
      }
    });
  }

  @override
  Future<List<FamilyResponsibility>> getResponsibilitiesForOwner(
    String ownerId,
  ) async {
    return isar.familyResponsibilitys
        .where()
        .primaryOwnerIdEqualTo(ownerId)
        .findAll();
  }
}
