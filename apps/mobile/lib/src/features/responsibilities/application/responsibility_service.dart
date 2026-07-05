import 'package:uuid/uuid.dart';
import '../domain/models/family_responsibility.dart';
import '../domain/models/responsibility_status.dart';
import '../infrastructure/repositories/responsibility_repository.dart';

class ResponsibilityService {
  final ResponsibilityRepository _repository;
  final Uuid _uuid = const Uuid();

  ResponsibilityService(this._repository);

  Future<FamilyResponsibility> createResponsibility({
    required String name,
    required ResponsibilityCategory category,
    required String primaryOwnerId,
    required DateTime dueDate,
    String? backupOwnerId,
    int escalationDelayMinutes = 30,
  }) async {
    final responsibility = FamilyResponsibility()
      ..uuid = _uuid.v4()
      ..name = name
      ..category = category
      ..primaryOwnerId = primaryOwnerId
      ..backupOwnerId = backupOwnerId
      ..status = ResponsibilityStatus.pending
      ..dueDate = dueDate
      ..escalationDelayMinutes = escalationDelayMinutes
      ..confidenceScore = 100
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();

    await _repository.saveResponsibility(responsibility);
    return responsibility;
  }

  Future<void> markAsCompleted(String uuid, String userId, {String? evidenceUri}) async {
    final responsibility = await _repository.getResponsibilityByUuid(uuid);
    if (responsibility == null) throw Exception('Responsibility not found');

    if (responsibility.dueDate.isAfter(DateTime.now())) {
      throw Exception('Cannot complete a responsibility before its due date');
    }

    responsibility.status = ResponsibilityStatus.completed;
    responsibility.completionEvidenceUri = evidenceUri;
    responsibility.updatedAt = DateTime.now();

    await _repository.saveResponsibility(responsibility);
    
    // In a full implementation, this would trigger an audit log (SEC-012)
    // and sync the ResponsibilityCompleted event.
  }

  Future<void> escalateIfBreached(String uuid) async {
    final responsibility = await _repository.getResponsibilityByUuid(uuid);
    if (responsibility == null) return;

    if (responsibility.status != ResponsibilityStatus.pending && 
        responsibility.status != ResponsibilityStatus.dueSoon) {
      return; // Already completed, escalated, or skipped
    }

    final breachTime = responsibility.dueDate.add(Duration(minutes: responsibility.escalationDelayMinutes));
    if (DateTime.now().isAfter(breachTime)) {
      responsibility.status = ResponsibilityStatus.escalated;
      responsibility.confidenceScore = (responsibility.confidenceScore - 10).clamp(0, 100);
      responsibility.updatedAt = DateTime.now();
      await _repository.saveResponsibility(responsibility);
      
      // Trigger SEC-012 audit log and Exception-Based Alert Push Notification
    }
  }
}
