import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_domain.dart';
import 'package:lifecircle_mobile/src/features/family/application/family_lifecycle_service.dart';
import 'package:lifecircle_mobile/src/features/family/application/invitation_flow_service.dart';
import 'package:lifecircle_mobile/src/features/authorization/application/authorization_service.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_context.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_domain.dart';

class MockOutboxRepository implements OutboxRepository {
  final List<SyncOperation> queue = [];
  
  @override
  Future<void> enqueue(SyncOperation op) async {
    queue.add(op);
  }

  @override
  Future<void> acknowledge(List<String> operationIds) async {}
  @override
  Future<SyncCheckpoint?> getCheckpoint() async => null;
  @override
  Future<List<SyncOperation>> getPendingBatch(int limit) async => [];
  @override
  Future<void> handleFailure(String operationId, String errorReason, DateTime nextRetryAt) async {}
  @override
  Future<void> markInFlight(List<String> operationIds) async {}
  @override
  Future<void> recoverStuckOperations(Duration timeout) async {}
  @override
  Future<void> updateCheckpoint(SyncCheckpoint checkpoint) async {}
}

class MockAuthService implements AuthorizationService {
  bool shouldAuthorize = true;

  @override
  bool isAuthorized({
    required AuthorizationContext context,
    required ActionType action,
    required ResourceType resource,
  }) {
    return shouldAuthorize;
  }
}

void main() {
  group('Phase 3A: Core Family Domain', () {
    late MockAuthService authService;
    late MockOutboxRepository outboxRepository;
    late FamilyLifecycleService lifecycleService;
    late InvitationFlowService invitationService;

    final dummyContext = AuthorizationContext(
      userId: 'user_1',
      familyId: 'fam_1',
      roles: {'admin'},
      ipHash: 'mock',
      deviceId: 'dev_1',
      trustLevel: 100,
    );

    setUp(() {
      authService = MockAuthService();
      outboxRepository = MockOutboxRepository();
      lifecycleService = FamilyLifecycleService(authService: authService, outboxRepository: outboxRepository);
      invitationService = InvitationFlowService(authService: authService, outboxRepository: outboxRepository);
    });

    test('Family creation pushes to Outbox', () async {
      final family = await lifecycleService.createFamily('Tiwari Family', dummyContext);
      
      expect(family.ownerId, 'user_1');
      expect(family.name, 'Tiwari Family');
      expect(outboxRepository.queue.length, 1);
      expect(outboxRepository.queue.first.mutationType, MutationType.create);
      expect(outboxRepository.queue.first.entityType, 'Family');
    });

    test('Unauthorized transferOwnership throws Exception', () async {
      authService.shouldAuthorize = false;

      final family = FamilyAggregate(
        familyId: 'fam_1',
        name: 'Tiwari Family',
        ownerId: 'user_1',
        state: FamilyLifecycleState.active,
        createdAt: DateTime.now(),
        version: 1,
      );

      expect(
        () => lifecycleService.transferOwnership(family, 'user_2', dummyContext),
        throwsA(isA<Exception>()),
      );
    });

    test('Invitation flow requires authorization', () async {
      authService.shouldAuthorize = false;

      expect(
        () => invitationService.inviteMember('fam_1', 'guest@example.com', MemberRole.member, dummyContext),
        throwsA(isA<Exception>()),
      );
    });

    test('Expired invitation acceptance throws Exception', () async {
      final expiredInvite = FamilyInvitation(
        invitationId: 'inv_1',
        familyId: 'fam_1',
        inviterId: 'user_1',
        inviteeEmail: 'guest@example.com',
        intendedRole: MemberRole.member,
        status: InvitationStatus.pending,
        expiresAt: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      );

      expect(
        () => invitationService.acceptInvitation(expiredInvite, dummyContext),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('expired'))),
      );
    });

    test('Accepting valid invitation queues Member creation and Invitation update', () async {
      final validInvite = FamilyInvitation(
        invitationId: 'inv_2',
        familyId: 'fam_1',
        inviterId: 'user_1',
        inviteeEmail: 'guest@example.com',
        intendedRole: MemberRole.member,
        status: InvitationStatus.pending,
        expiresAt: DateTime.now().add(const Duration(days: 1)),
        createdAt: DateTime.now(),
      );

      final member = await invitationService.acceptInvitation(validInvite, dummyContext);
      
      expect(member.role, MemberRole.member);
      expect(member.status, MemberStatus.active);
      expect(outboxRepository.queue.length, 2); // 1 for Invitation update, 1 for Member create
      expect(outboxRepository.queue[0].mutationType, MutationType.update); // Invite update
      expect(outboxRepository.queue[1].mutationType, MutationType.create); // Member create
    });
  });
}
