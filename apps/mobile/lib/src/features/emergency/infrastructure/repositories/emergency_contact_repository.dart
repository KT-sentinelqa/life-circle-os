import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/features/emergency/domain/models/emergency_contact.dart';

abstract class EmergencyContactRepository {
  Future<void> saveContact(EmergencyContact contact);
  Future<List<EmergencyContact>> getAllContacts(String householdId);
  Future<void> deleteContact(String uuid);
}

class IsarEmergencyContactRepository implements EmergencyContactRepository {
  IsarEmergencyContactRepository(this.isar);
  final Isar isar;

  @override
  Future<void> saveContact(EmergencyContact contact) async {
    await isar.writeTxn(() async {
      await isar.emergencyContacts.put(contact);
    });
  }

  @override
  Future<List<EmergencyContact>> getAllContacts(String householdId) async {
    return isar.emergencyContacts
        .where()
        .householdIdEqualTo(householdId)
        .findAll();
  }

  @override
  Future<void> deleteContact(String uuid) async {
    await isar.writeTxn(() async {
      final contact =
          await isar.emergencyContacts.where().uuidEqualTo(uuid).findFirst();
      if (contact != null) {
        await isar.emergencyContacts.delete(contact.id);
      }
    });
  }
}
