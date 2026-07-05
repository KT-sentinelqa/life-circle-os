import 'package:lifecircle_mobile/src/features/family/domain/entities/family_member_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/visibility_policy.dart';

/// Service responsible for enforcing access control on medicines.
class MedicineAccessService {
  /// Determines if a family member can view a medicine.
  bool canViewMedicine(FamilyMemberEntity member, MedicineEntity medicine) {
    if (member.familyId != medicine.familyId) return false;

    // Owner can always view
    if (member.userId == medicine.ownerUserId) return true;

    // Assigned member can always view
    if (member.userId == medicine.memberId) return true;

    switch (medicine.visibilityPolicy) {
      case VisibilityPolicy.private:
        return false;
      case VisibilityPolicy.caregivers:
        return medicine.caregiverIds.contains(member.userId);
      case VisibilityPolicy.family:
        // Any family member with viewAdherence permission can see it
        return member.role.permissions.contains(FamilyPermission.viewAdherence);
    }
  }

  /// Determines if a family member can edit a medicine.
  bool canEditMedicine(FamilyMemberEntity member, MedicineEntity medicine) {
    if (member.familyId != medicine.familyId) return false;

    // Owner can always edit
    if (member.userId == medicine.ownerUserId) return true;

    if (member.role.permissions.contains(FamilyPermission.manageMedicines)) {
      final isPrivate = medicine.visibilityPolicy == VisibilityPolicy.private;
      final isAssigned = member.userId == medicine.memberId;
      if (isPrivate && !isAssigned) {
        return false;
      }
      return true;
    }

    return false;
  }
}
