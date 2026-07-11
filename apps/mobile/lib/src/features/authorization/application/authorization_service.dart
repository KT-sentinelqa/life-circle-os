import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/authorization/application/policy_engine.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_context.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_decision.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/family_role.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/resource_type.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/device_trust.dart';

/// Provider exposing the [AuthorizationService].
final authorizationServiceProvider = Provider<AuthorizationService>((ref) {
  return AuthorizationService(ref, const PolicyEngine());
});

/// The canonical entry point for all authorization decisions in the application.
class AuthorizationService {
  const AuthorizationService(this._ref, this._policyEngine);

  final Ref _ref;
  final PolicyEngine _policyEngine;

  /// Determines if the current user can perform [action] on [resource].
  AuthorizationDecision canAccess({
    required ResourceType resource,
    PermissionAction action = PermissionAction.read,
    bool isOwnerOfResource = false,
    bool isEmergencyActive = false,
  }) {
    // 1. Resolve Identity
    final user = _ref.read(authProvider).valueOrNull;

    if (user == null) {
      return const AuthorizationDecision(
        status: AuthorizationDecisionStatus.denySessionExpired,
        reason: 'User is not authenticated.',
      );
    }

    // Temporary mapping until Session/User is refactored (SEC-001.5 Architecture Debt)
    // Assume adult by default if no role is explicitly set on user (which we haven't added yet, 
    // but in a real app this would map to user.familyRole).
    const role = FamilyRole.adult; // Hardcoded default for prototype

    // 2. Build Context
    final context = AuthorizationContext(
      userId: user.id,
      sessionId: 'session_mock', // To be implemented in Session Management
      deviceTrust: DeviceTrustResult(
        trustLevel: DeviceTrustLevel.verified, // To be implemented in Device Trust Service
        riskLevel: DeviceRiskLevel.low,
        biometricState: BiometricState.verified,
        attestationState: AppAttestationState.verified,
        hasSecureHardware: true,
        isSessionExpired: false,
        requiresReAuthentication: false,
        confidenceScore: 100,
        lastVerificationUtc: DateTime.now().toUtc(),
        evaluationTimestamp: DateTime.now().toUtc(),
        signalVersion: '1.0',
        trustVersion: '1.0',
        evidenceIds: [],
        evaluationDuration: const Duration(milliseconds: 1),
        policyVersion: '1.0',
      ),
      familyId: user.familyId ?? '',
      role: role,
      resource: resource,
      action: action,
      isOwnerOfResource: isOwnerOfResource,
      isEmergencyActive: isEmergencyActive,
      timestamp: DateTime.now(),
    );

    // 3. Evaluate Policy
    return _policyEngine.evaluate(context);
  }
}
