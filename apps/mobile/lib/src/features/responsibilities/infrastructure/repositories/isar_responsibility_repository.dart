import 'package:isar/isar.dart';
import '../../domain/models/family_responsibility.dart';
import 'responsibility_repository.dart';

class IsarResponsibilityRepository implements ResponsibilityRepository {
  final Isar isar;

  IsarResponsibilityRepository(this.isar);

  @override
  Future<void> saveResponsibility(FamilyResponsibility responsibility) async {
    await isar.writeTxn(() async {
      await isar.familyResponsibilitys.put(responsibility);
    });
  }

  @override
  Future<FamilyResponsibility?> getResponsibilityByUuid(String uuid) async {
    return await isar.familyResponsibilitys.where().uuidEqualTo(uuid).findFirst();
  }

  @override
  Future<List<FamilyResponsibility>> getAllResponsibilities() async {
    return await isar.familyResponsibilitys.where().findAll();
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
  Future<List<FamilyResponsibility>> getResponsibilitiesForOwner(String ownerId) async {
    return await isar.familyResponsibilitys.where().primaryOwnerIdEqualTo(ownerId).findAll();
  }
}
