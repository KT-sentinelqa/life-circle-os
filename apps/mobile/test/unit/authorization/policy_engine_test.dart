import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/authorization/application/policy_engine.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_context.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_decision.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/family_role.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/resource_type.dart';
import 'package:lifecircle_mobile/src/features/device_trust/domain/trust_evidence.dart';

void main() {
  group('Policy Engine SEC-002', () {
    late PolicyEngine engine;

    setUp(() {
      engine = const PolicyEngine();
    });

    AuthorizationContext _buildContext({
      required FamilyRole role,
      required ResourceType resource,
      PermissionAction action = PermissionAction.write,
      bool isOwnerOfResource = false,
      bool isEmergencyActive = false,
      bool isDeviceTrusted = true,
      bool isSessionValid = true,
    }) {
      return AuthorizationContext(
        userId: 'test_user',
        sessionId: 'test_session',
        trustEvidence: TrustEvidence(
          deviceId: 'device_123',
          deviceTrustLevel: isDeviceTrusted ? 'verified' : 'blocked',
          attestationStatus: isDeviceTrusted ? AttestationStatus.hardwareVerified : AttestationStatus.failed,
          assertionStatus: AssertionStatus.valid,
          isHardwareBacked: true,
          isSessionExpired: !isSessionValid,
          requiresReAuthentication: !isSessionValid,
          fraudSignals: isDeviceTrusted ? [] : ['rooted'],
          riskScore: isDeviceTrusted ? 10.0 : 90.0,
          policyVersion: '1.0',
          evaluationTimestampUtc: DateTime.now().toUtc(),
        ),
        familyId: 'family_123',
        role: role,
        resource: resource,
        action: action,
        isOwnerOfResource: isOwnerOfResource,
        isEmergencyActive: isEmergencyActive,
        timestamp: DateTime.now(),
      );
    }

    test('Owner edits medicine -> PASS', () {
      final context = _buildContext(
        role: FamilyRole.owner,
        resource: ResourceType.medicines,
        action: PermissionAction.write,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isTrue);
      expect(decision.status, AuthorizationDecisionStatus.allow);
    });

    test('Parent edits child medicine -> PASS', () {
      final context = _buildContext(
        role: FamilyRole.parent,
        resource: ResourceType.medicines,
        action: PermissionAction.write,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isTrue);
    });

    test('Child edits owner medicine -> FAIL', () {
      final context = _buildContext(
        role: FamilyRole.child,
        resource: ResourceType.medicines,
        action: PermissionAction.write,
        isOwnerOfResource: false,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isFalse);
      expect(decision.status, AuthorizationDecisionStatus.denyPermission);
    });

    test('Caregiver edits finance -> FAIL', () {
      final context = _buildContext(
        role: FamilyRole.caregiver,
        resource: ResourceType.financialData,
        action: PermissionAction.write,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isFalse);
      expect(decision.status, AuthorizationDecisionStatus.denyPermission);
    });

    test('Emergency delegate accesses emergency contacts -> PASS', () {
      final context = _buildContext(
        role: FamilyRole.emergencyDelegate,
        resource: ResourceType.emergencyContacts,
        action: PermissionAction.read,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isTrue);
    });

    test('Emergency delegate accesses medicines in normal state -> FAIL (Break Glass Required)', () {
      final context = _buildContext(
        role: FamilyRole.emergencyDelegate,
        resource: ResourceType.medicines,
        action: PermissionAction.read,
        isEmergencyActive: false,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isFalse);
      expect(decision.status, AuthorizationDecisionStatus.denyBreakGlassRequired);
    });

    test('Emergency delegate accesses medicines during emergency -> PASS (Audit)', () {
      final context = _buildContext(
        role: FamilyRole.emergencyDelegate,
        resource: ResourceType.medicines,
        action: PermissionAction.write,
        isEmergencyActive: true,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isTrue);
      expect(decision.status, AuthorizationDecisionStatus.allowWithAudit);
    });

    test('Untrusted device -> FAIL', () {
      final context = _buildContext(
        role: FamilyRole.owner,
        resource: ResourceType.medicines,
        action: PermissionAction.write,
        isDeviceTrusted: false,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isFalse);
      expect(decision.status, AuthorizationDecisionStatus.denyDeviceUntrusted);
    });

    test('Expired session -> FAIL', () {
      final context = _buildContext(
        role: FamilyRole.owner,
        resource: ResourceType.medicines,
        action: PermissionAction.write,
        isSessionValid: false,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isFalse);
      expect(decision.status, AuthorizationDecisionStatus.denySessionExpired);
    });

    test('Adult assigns responsibility -> PASS', () {
      final context = _buildContext(
        role: FamilyRole.adult,
        resource: ResourceType.responsibilities,
        action: PermissionAction.write,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isTrue);
    });

    test('Child edits own responsibility -> PASS', () {
      final context = _buildContext(
        role: FamilyRole.child,
        resource: ResourceType.responsibilities,
        action: PermissionAction.write,
        isOwnerOfResource: true,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isTrue);
    });

    test('Child edits other responsibility -> FAIL', () {
      final context = _buildContext(
        role: FamilyRole.child,
        resource: ResourceType.responsibilities,
        action: PermissionAction.write,
        isOwnerOfResource: false,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isFalse);
    });

    test('Parent edits financial data -> PASS', () {
      final context = _buildContext(
        role: FamilyRole.parent,
        resource: ResourceType.financialData,
        action: PermissionAction.write,
      );
      final decision = engine.evaluate(context);
      expect(decision.isGranted, isTrue);
    });
  });
}
