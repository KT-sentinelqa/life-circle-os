import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';

abstract class ResponsibilityRepository {
  Future<void> saveResponsibility(FamilyResponsibility responsibility);
  Future<FamilyResponsibility?> getResponsibilityByUuid(String uuid);
  Future<List<FamilyResponsibility>> getAllResponsibilities();
  Future<void> deleteResponsibility(String uuid);
  Future<List<FamilyResponsibility>> getResponsibilitiesForOwner(
    String ownerId,
  );
}
