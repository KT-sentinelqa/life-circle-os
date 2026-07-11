import 'package:lifecircle_mobile/src/features/authorization/domain/entities/family_role.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/resource_type.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

enum PermissionAction {
  read,
  write,
}

class AuthorizationContext {
  const AuthorizationContext({
    required this.userId,
    required this.sessionId,
    required this.trustEvidence,
    required this.familyId,
    required this.role,
    required this.resource,
    required this.action,
    required this.isOwnerOfResource,
    required this.isEmergencyActive,
    required this.timestamp,
  });

  final String userId;
  final String sessionId;
  final TrustEvidence trustEvidence;
  final String familyId;
  final FamilyRole role;
  final ResourceType resource;
  final PermissionAction action;
  final bool isOwnerOfResource;
  final bool isEmergencyActive;
  final DateTime timestamp;
}
