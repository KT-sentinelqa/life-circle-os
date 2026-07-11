import 'package:flutter/foundation.dart';

enum FamilyLifecycleState {
  active,
  suspended,
  archived,
}

enum MemberRole {
  owner,
  admin,
  member,
  dependent,
}

enum MemberStatus {
  active,
  invited,
  suspended,
}

enum InvitationStatus {
  pending,
  accepted,
  expired,
  revoked,
}

@immutable
class FamilyAggregate {
  const FamilyAggregate({
    required this.familyId,
    required this.name,
    required this.ownerId,
    required this.state,
    required this.createdAt,
    required this.version,
  });

  final String familyId;
  final String name;
  final String ownerId;
  final FamilyLifecycleState state;
  final DateTime createdAt;
  final int version; // For optimistic concurrency
}

@immutable
class FamilyMember {
  const FamilyMember({
    required this.memberId,
    required this.familyId,
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  final String memberId;
  final String familyId;
  final String userId;
  final MemberRole role;
  final MemberStatus status;
  final DateTime joinedAt;
}

@immutable
class FamilyInvitation {
  const FamilyInvitation({
    required this.invitationId,
    required this.familyId,
    required this.inviterId,
    required this.inviteeEmail,
    required this.intendedRole,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
  });

  final String invitationId;
  final String familyId;
  final String inviterId;
  final String inviteeEmail;
  final MemberRole intendedRole;
  final InvitationStatus status;
  final DateTime expiresAt;
  final DateTime createdAt;

  bool get isExpired => DateTime.now().toUtc().isAfter(expiresAt);
}
