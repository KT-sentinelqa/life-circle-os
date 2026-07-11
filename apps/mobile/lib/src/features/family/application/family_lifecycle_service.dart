import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_domain.dart';
import 'package:lifecircle_mobile/src/features/authorization/application/authorization_service.dart';
import 'package:lifecircle_mobile/src/features/authorization/domain/entities/authorization_context.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

class FamilyLifecycleService {
  const FamilyLifecycleService({
    required this.authService,
    required this.outboxRepository,
  });

  final AuthorizationService authService;
  final OutboxRepository outboxRepository;

  /// Creates a new FamilyAggregate and sets the creator as the Owner.
  Future<FamilyAggregate> createFamily(String name, AuthorizationContext context) async {
    final familyId = const Uuid().v4();
    
    final family = FamilyAggregate(
      familyId: familyId,
      name: name,
      ownerId: context.userId,
      state: FamilyLifecycleState.active,
      createdAt: DateTime.now().toUtc(),
      version: 1,
    );

    // Enqueue offline-first mutation
    await _enqueueMutation(
      entityId: family.familyId,
      entityType: 'Family',
      mutationType: MutationType.create,
      payload: {
        'familyId': family.familyId,
        'name': family.name,
        'ownerId': family.ownerId,
        'state': family.state.name,
      },
    );

    return family;
  }

  /// Transfers ownership of the family to a new user. Requires strict authorization.
  Future<void> transferOwnership(
    FamilyAggregate currentFamily,
    String newOwnerId,
    AuthorizationContext context,
  ) async {
    // 1. Foundation Integration: Verify RBAC/Step-Up Auth (SEC-002)
    final isAuthorized = authService.isAuthorized(
      context: context,
      action: ActionType.update,
      resource: ResourceType.familySettings,
    );

    if (!isAuthorized) {
      throw Exception('Unauthorized: Step-up authentication or proper role required.');
    }

    if (currentFamily.ownerId != context.userId) {
      throw Exception('Unauthorized: Only the current owner can transfer ownership.');
    }

    // 2. Perform Mutation
    final updatedFamily = FamilyAggregate(
      familyId: currentFamily.familyId,
      name: currentFamily.name,
      ownerId: newOwnerId,
      state: currentFamily.state,
      createdAt: currentFamily.createdAt,
      version: currentFamily.version + 1,
    );

    // 3. Enqueue offline-first
    await _enqueueMutation(
      entityId: updatedFamily.familyId,
      entityType: 'Family',
      mutationType: MutationType.update,
      payload: {
        'ownerId': updatedFamily.ownerId,
        'version': updatedFamily.version,
      },
    );
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
      sequenceNumber: DateTime.now().millisecondsSinceEpoch, // Mocked sequence generator
      idempotencyKey: const Uuid().v4(),
      status: SyncOperationStatus.pending,
      retryCount: 0,
      attempt: 0,
    );

    await outboxRepository.enqueue(op);
  }
}
