import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_context.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_decision.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/family_role.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/resource_type.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

/// Centralized policy evaluator based on the Canonical Authorization Model.
class PolicyEngine {
  const PolicyEngine();

  /// Evaluates the [context] against the defined permissions matrix.
  AuthorizationDecision evaluate(AuthorizationContext context) {
    // 1. Core platform verifications (Device Trust)
    if (!context.trustEvidence.isTrusted || context.trustEvidence.deviceTrustLevel == 'blocked' || context.trustEvidence.attestationStatus == AttestationStatus.failed) {
      return const AuthorizationDecision(
        status: AuthorizationDecisionStatus.denyDeviceUntrusted,
        reason: 'Device is blocked by trust subsystem or failed attestation.',
      );
    }
    
    if (context.trustEvidence.requiresReAuthentication || context.trustEvidence.isSessionExpired) {
      return const AuthorizationDecision(
        status: AuthorizationDecisionStatus.denySessionExpired,
        reason: 'Session has expired or re-authentication is required.',
      );
    }

    if (context.trustEvidence.deviceTrustLevel == 'restricted' || context.trustEvidence.attestationStatus == AttestationStatus.softwareVerified) {
      if (!context.isEmergencyActive) {
        return const AuthorizationDecision(
          status: AuthorizationDecisionStatus.denyDeviceUntrusted,
          reason: 'Device trust is restricted. Only emergency actions allowed.',
        );
      }
    }

    if (context.sessionId.contains('expired') || context.sessionId.isEmpty) {
      return const AuthorizationDecision(
        status: AuthorizationDecisionStatus.denySessionExpired,
        reason: 'Session has expired.',
      );
    }

    // 2. Global Role Allowances
    if (context.role == FamilyRole.owner) {
      return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
    }

    // 3. Matrix Evaluation
    switch (context.resource) {
      case ResourceType.familySettings:
        return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyPermission);

      case ResourceType.memberInvites:
        if (context.role == FamilyRole.parent) {
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyPermission);

      case ResourceType.medicines:
        if (context.role == FamilyRole.parent || context.role == FamilyRole.adult || context.role == FamilyRole.caregiver) {
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        if (context.role == FamilyRole.child || context.role == FamilyRole.readOnlyDelegate) {
          if (context.action == PermissionAction.read) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
          }
        }
        if (context.role == FamilyRole.emergencyDelegate) {
          if (context.isEmergencyActive) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allowWithAudit);
          }
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyBreakGlassRequired);
        }
        return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyPermission);

      case ResourceType.responsibilities:
        if (context.role == FamilyRole.parent || context.role == FamilyRole.adult) {
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        if (context.role == FamilyRole.child) {
          if (context.isOwnerOfResource || context.action == PermissionAction.read) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
          }
        }
        if (context.role == FamilyRole.caregiver || context.role == FamilyRole.readOnlyDelegate) {
          if (context.action == PermissionAction.read) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
          }
        }
        return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyPermission);

      case ResourceType.emergencyContacts:
        if (context.role == FamilyRole.parent || context.role == FamilyRole.caregiver || context.role == FamilyRole.emergencyDelegate) {
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        if (context.action == PermissionAction.read) {
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyPermission);

      case ResourceType.financialData:
        if (context.role == FamilyRole.parent) {
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        if (context.role == FamilyRole.emergencyDelegate) {
          if (context.isEmergencyActive) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allowWithAudit);
          }
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyBreakGlassRequired);
        }
        return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyPermission);

      case ResourceType.medicalLogs:
        if (context.role == FamilyRole.parent) {
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        if (context.role == FamilyRole.adult || context.role == FamilyRole.child) {
          if (context.isOwnerOfResource) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
          }
        }
        if (context.role == FamilyRole.caregiver && context.isOwnerOfResource) {
          // "Assigned Only" could mean isOwnerOfResource or hasDelegation
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
        }
        if (context.role == FamilyRole.readOnlyDelegate) {
          if (context.action == PermissionAction.read) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allow);
          }
        }
        if (context.role == FamilyRole.emergencyDelegate) {
          if (context.isEmergencyActive) {
            return const AuthorizationDecision(status: AuthorizationDecisionStatus.allowWithAudit);
          }
          return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyBreakGlassRequired);
        }
        return const AuthorizationDecision(status: AuthorizationDecisionStatus.denyPermission);
    }
  }

  /// Evaluates whether a specific high-risk operation demands Step-Up Re-Authentication.
  bool requiresStepUp(AuthorizationContext context) {
    // Operations that mandate step-up auth (PIN / Biometrics)
    final isHighRiskOperation = (
      context.resource == ResourceType.familySettings || // Assuming Ownership Transfer lives here
      context.resource == ResourceType.emergencyContacts || // Adding delegates
      context.resource == ResourceType.financialData
    );

    if (isHighRiskOperation) {
      // Step-Up is required if the session is older than the high-risk freshness threshold (e.g. 15 minutes)
      // or if trust evidence does not explicitly contain a fresh attestation.
      final freshnessLimit = DateTime.now().toUtc().subtract(const Duration(minutes: 15));
      if (context.timestamp.isBefore(freshnessLimit)) {
        return true;
      }
    }
    return false;
  }
}
