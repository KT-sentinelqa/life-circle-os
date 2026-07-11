import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/utils/trusted_clock.dart';
import 'package:lifecircle_mobile/src/features/peace_of_mind/application/peace_index_service.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_category.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_status.dart';



// Helper to build a minimal FamilyResponsibility for tests
FamilyResponsibility _resp({
  required String uuid,
  required String ownerId,
  required ResponsibilityCategory category,
  required ResponsibilityStatus status,
  int confidenceScore = 100,
  DateTime? updatedAt,
  String? backupOwnerId,
}) {
  return FamilyResponsibility()
    ..uuid = uuid
    ..primaryOwnerId = ownerId
    ..backupOwnerId = backupOwnerId
    ..category = category
    ..status = status
    ..confidenceScore = confidenceScore
    ..dueDate = DateTime(2026)
    ..createdAt = DateTime(2026)
    ..updatedAt = updatedAt ?? DateTime(2026);
}

void main() {
  final fixedNow = DateTime(2026, 7, 11, 10);

  // NOTE: Until TrustedClock can be fully mocked via interface,
  // these tests validate the calculation logic directly.
  // The service is instantiated with a real TrustedClock but time-sensitive
  // tests use controlled updatedAt values.

  group('PeaceIndexService — Penalty Calculations', () {
    late PeaceIndexService service;

    setUp(() {
      // ignore: invalid_use_of_internal_member
      service = PeaceIndexService(_RealClock(fixedNow));
    });

    test('All responsibilities completed → score is 100', () {
      final responsibilities = [
        _resp(
          uuid: '1',
          ownerId: 'u1',
          category: ResponsibilityCategory.health,
          status: ResponsibilityStatus.completed,
          updatedAt: fixedNow.subtract(const Duration(hours: 25)),
        ),
      ];
      final score = service.calculateContextualIndex('u1', responsibilities);
      expect(score, 100);
    });

    test('Health escalation → -20 penalty', () {
      final r = _resp(
        uuid: '1',
        ownerId: 'u1',
        category: ResponsibilityCategory.health,
        status: ResponsibilityStatus.escalated,
      );
      expect(service.calculateContextualIndex('u1', [r]), 80);
    });

    test('Finance escalation → -10 penalty', () {
      final r = _resp(
        uuid: '2',
        ownerId: 'u1',
        category: ResponsibilityCategory.finance,
        status: ResponsibilityStatus.escalated,
      );
      expect(service.calculateContextualIndex('u1', [r]), 90);
    });

    test('Household escalation → -5 penalty', () {
      final r = _resp(
        uuid: '3',
        ownerId: 'u1',
        category: ResponsibilityCategory.household,
        status: ResponsibilityStatus.escalated,
      );
      expect(service.calculateContextualIndex('u1', [r]), 95);
    });

    test('Multiple escalations stack, floor at 0', () {
      final responsibilities = List.generate(
        6,
        (i) => _resp(
          uuid: 'h$i',
          ownerId: 'u1',
          category: ResponsibilityCategory.health,
          status: ResponsibilityStatus.escalated,
        ),
      );
      // 6 × -20 = -120 → clamped to 0
      expect(service.calculateContextualIndex('u1', responsibilities), 0);
    });

    test('24-hour cooling off: score capped at 95 when confidence was < 100',
        () {
      final r = _resp(
        uuid: '4', ownerId: 'u1',
        category: ResponsibilityCategory.health,
        status: ResponsibilityStatus.completed,
        confidenceScore: 80, // Had escalated previously
        updatedAt: fixedNow.subtract(const Duration(hours: 2)),
      );
      expect(service.calculateContextualIndex('u1', [r]), 95);
    });

    test('After 24 hours cooling off: full score restored', () {
      final r = _resp(
        uuid: '5',
        ownerId: 'u1',
        category: ResponsibilityCategory.health,
        status: ResponsibilityStatus.completed,
        confidenceScore: 80,
        updatedAt: fixedNow.subtract(const Duration(hours: 25)),
      );
      expect(service.calculateContextualIndex('u1', [r]), 100);
    });
  });

  group('PeaceIndexService — SEC-016 Contextual Privacy', () {
    late PeaceIndexService service;

    setUp(() {
      service = PeaceIndexService(_RealClock(fixedNow));
    });

    test('Child cannot see parent finance escalation', () {
      final r = _resp(
        uuid: '6',
        ownerId: 'parent',
        category: ResponsibilityCategory.finance,
        status: ResponsibilityStatus.escalated,
      );
      // child_1 is not primaryOwner or backupOwner — filtered out by SEC-016
      expect(service.calculateContextualIndex('child_1', [r]), 100);
    });

    test('Backup owner CAN see escalation and score is affected', () {
      final r = _resp(
        uuid: '7',
        ownerId: 'parent',
        backupOwnerId: 'backup_1',
        category: ResponsibilityCategory.health,
        status: ResponsibilityStatus.escalated,
      );
      expect(service.calculateContextualIndex('backup_1', [r]), 80);
    });
  });

  group('PeaceIndexService — Audit Trail', () {
    late PeaceIndexService service;

    setUp(() {
      service = PeaceIndexService(_RealClock(fixedNow));
    });

    test('Health escalation generates an audit entry', () {
      final r = _resp(
        uuid: '8',
        ownerId: 'u1',
        category: ResponsibilityCategory.health,
        status: ResponsibilityStatus.escalated,
      );
      final result = service.calculateWithAudit('u1', [r], 'household_1');
      expect(result.auditEntries.length, 1);
      expect(result.auditEntries.first.delta, -20);
      expect(
        result.auditEntries.first.reason,
        contains('Health responsibility escalated'),
      );
    });

    test('No escalations → empty audit trail', () {
      final r = _resp(
        uuid: '9',
        ownerId: 'u1',
        category: ResponsibilityCategory.health,
        status: ResponsibilityStatus.completed,
        updatedAt: fixedNow.subtract(const Duration(hours: 48)),
      );
      final result = service.calculateWithAudit('u1', [r], 'household_1');
      expect(result.auditEntries, isEmpty);
    });
  });
}

/// Thin wrapper allowing a fixed DateTime to be injected into TrustedClock.
/// Used only in tests. Production uses TrustedClock() directly.
class _RealClock extends TrustedClock {
  _RealClock(this._fixed);
  final DateTime _fixed;

  @override
  DateTime now() => _fixed;
}
