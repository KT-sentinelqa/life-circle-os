import 'package:flutter_test/flutter_test.dart';
import 'package:life_circle_os/src/features/peace_of_mind/application/peace_index_service.dart';
import 'package:life_circle_os/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:life_circle_os/src/features/responsibilities/domain/models/responsibility_category.dart';
import 'package:life_circle_os/src/features/responsibilities/domain/models/responsibility_status.dart';

void main() {
  late PeaceIndexService service;

  setUp(() {
    service = PeaceIndexService();
  });

  test('Should penalize health escalation by 20 points', () {
    final resp = FamilyResponsibility()
      ..uuid = '1'
      ..primaryOwnerId = 'user_1'
      ..category = ResponsibilityCategory.health
      ..status = ResponsibilityStatus.escalated;

    final score = service.calculateContextualIndex('user_1', [resp]);
    expect(score, 80);
  });

  test('Should enforce 24-hour cooling off period (max 95 score)', () {
    final resp = FamilyResponsibility()
      ..uuid = '1'
      ..primaryOwnerId = 'user_1'
      ..category = ResponsibilityCategory.health
      ..status = ResponsibilityStatus.completed
      ..confidenceScore = 80 // It had escalated previously
      ..updatedAt = DateTime.now().subtract(const Duration(hours: 2));

    final score = service.calculateContextualIndex('user_1', [resp]);
    expect(score, 95); // Capped at 95 during cooling off
  });

  test('Should not expose parent financial escalation to child view (Contextual Privacy)', () {
    final resp = FamilyResponsibility()
      ..uuid = '1'
      ..primaryOwnerId = 'parent_1'
      ..category = ResponsibilityCategory.finance
      ..status = ResponsibilityStatus.escalated;

    // Child checks index. They are not the owner or backup of the finance task.
    final score = service.calculateContextualIndex('child_1', [resp]);
    
    // Score remains 100 because the task is filtered out by contextual aggregation
    expect(score, 100); 
  });
}
