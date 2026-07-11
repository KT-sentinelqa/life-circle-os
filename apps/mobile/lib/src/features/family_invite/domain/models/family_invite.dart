import 'package:isar/isar.dart';

part 'family_invite.g.dart';

@collection
class FamilyInvite {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String inviteCode;

  late String householdId;

  /// The role being offered to the invitee (e.g., 'caregiver', 'parent', 'child')
  late String proposedRole;

  late DateTime expiresAt;
  late DateTime createdAt;

  /// Has this invite been consumed?
  late bool isAccepted;
}
