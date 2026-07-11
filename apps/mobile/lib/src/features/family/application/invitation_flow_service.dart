import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_domain.dart';
import 'package:lifecircle_mobile/src/features/authorization/application/authorization_service.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_context.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

class InvitationFlowService {
  const InvitationFlowService({
    required this.authService,
    required this.outboxRepository,
  });

  final AuthorizationService authService;
  final OutboxRepository outboxRepository;

  /// Invites a new member to the family. Requires Admin or Owner roles.
  Future<FamilyInvitation> inviteMember(
    String familyId,
    String inviteeEmail,
    MemberRole intendedRole,
    AuthorizationContext context,
  ) async {
    // 1. Foundation Integration: Verify RBAC (SEC-002)
    final isAuthorized = authService.isAuthorized(
      context: context,
      action: ActionType.update,
      resource: ResourceType.familySettings, // Overloading resource type for MVP
    );

    if (!isAuthorized) {
      throw Exception('Unauthorized: Must be an Admin or Owner to invite members.');
    }

    // 2. Create Domain Entity
    final invitation = FamilyInvitation(
      invitationId: const Uuid().v4(),
      familyId: familyId,
      inviterId: context.userId,
      inviteeEmail: inviteeEmail,
      intendedRole: intendedRole,
      status: InvitationStatus.pending,
      expiresAt: DateTime.now().toUtc().add(const Duration(days: 7)),
      createdAt: DateTime.now().toUtc(),
    );

    // 3. Enqueue to Outbox (Offline-First)
    await _enqueueMutation(
      entityId: invitation.invitationId,
      entityType: 'Invitation',
      mutationType: MutationType.create,
      payload: {
        'familyId': invitation.familyId,
        'inviteeEmail': invitation.inviteeEmail,
        'intendedRole': invitation.intendedRole.name,
        'status': invitation.status.name,
      },
    );

    return invitation;
  }

  /// Accepts an active invitation and generates a new FamilyMember.
  Future<FamilyMember> acceptInvitation(
    FamilyInvitation invitation,
    AuthorizationContext context,
  ) async {
    if (invitation.isExpired) {
      throw Exception('Invitation has expired.');
    }
    if (invitation.status != InvitationStatus.pending) {
      throw Exception('Invitation is no longer valid.');
    }

    // Update Invitation Status
    await _enqueueMutation(
      entityId: invitation.invitationId,
      entityType: 'Invitation',
      mutationType: MutationType.update,
      payload: {
        'status': InvitationStatus.accepted.name,
      },
    );

    // Create Member Domain Entity
    final member = FamilyMember(
      memberId: const Uuid().v4(),
      familyId: invitation.familyId,
      userId: context.userId,
      role: invitation.intendedRole,
      status: MemberStatus.active,
      joinedAt: DateTime.now().toUtc(),
    );

    // Enqueue Member Creation
    await _enqueueMutation(
      entityId: member.memberId,
      entityType: 'FamilyMember',
      mutationType: MutationType.create,
      payload: {
        'familyId': member.familyId,
        'userId': member.userId,
        'role': member.role.name,
        'status': member.status.name,
      },
    );

    return member;
  }

  Future<void> _enqueueMutation({
    required String entityId,
    required String entityType,
    required MutationType mutationType,
    required Map<String, dynamic> payload,
  }) async {
    final op = SyncOperation(
      operationId: const Uuid().v4(),
      entityId: entityId,
      entityType: entityType,
      mutationType: mutationType,
      payload: jsonEncode(payload),
      timestamp: DateTime.now().toUtc(),
      sequenceNumber: DateTime.now().millisecondsSinceEpoch,
      idempotencyKey: const Uuid().v4(),
      status: SyncOperationStatus.pending,
      retryCount: 0,
      attempt: 0,
    );

    await outboxRepository.enqueue(op);
  }
}
