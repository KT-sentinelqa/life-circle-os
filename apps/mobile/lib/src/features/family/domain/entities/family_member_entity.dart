import 'package:freezed_annotation/freezed_annotation.dart';

part 'family_member_entity.freezed.dart';
part 'family_member_entity.g.dart';

/// Represents permissions available within a family.
enum FamilyPermission {
  /// Can manage family members and settings.
  manageFamily,

  /// Can add, edit, or delete medicines.
  manageMedicines,

  /// Can view adherence data and heatmaps.
  viewAdherence,

  /// Can receive alerts for missed doses.
  receiveAlerts,
}

/// Represents the role of a family member.
enum MemberRole {
  /// Administrator and creator of the family.
  owner,

  /// Can manage medicines and receive alerts.
  caregiver,

  /// Can manage medicines and view adherence.
  parent,

  /// Can only view adherence.
  child,
}

/// Extension for checking permissions associated with a role.
extension MemberRoleX on MemberRole {
  /// Returns the list of permissions granted to this role.
  List<FamilyPermission> get permissions {
    switch (this) {
      case MemberRole.owner:
        return const [
          FamilyPermission.manageFamily,
          FamilyPermission.manageMedicines,
          FamilyPermission.viewAdherence,
          FamilyPermission.receiveAlerts,
        ];
      case MemberRole.caregiver:
        return const [
          FamilyPermission.manageMedicines,
          FamilyPermission.viewAdherence,
          FamilyPermission.receiveAlerts,
        ];
      case MemberRole.parent:
        return const [
          FamilyPermission.manageMedicines,
          FamilyPermission.viewAdherence,
          FamilyPermission.receiveAlerts,
        ];
      case MemberRole.child:
        return const [
          FamilyPermission.viewAdherence,
        ];
    }
  }
}

/// Represents a member of a family.
@freezed
class FamilyMemberEntity with _$FamilyMemberEntity {
  /// Creates a [FamilyMemberEntity].
  const factory FamilyMemberEntity({
    /// Unique identifier for the member record.
    required String id,

    /// The associated user ID.
    required String userId,

    /// The associated family ID.
    required String familyId,

    /// The role of the member.
    @Default(MemberRole.caregiver) MemberRole role,
  }) = _FamilyMemberEntity;

  /// Creates a [FamilyMemberEntity] from a JSON object.
  factory FamilyMemberEntity.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberEntityFromJson(json);
}
