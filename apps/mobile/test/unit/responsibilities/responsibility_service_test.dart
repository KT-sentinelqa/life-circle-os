import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/utils/trusted_clock.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/application/responsibility_service.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_status.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/infrastructure/repositories/responsibility_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ResponsibilityRepository, TrustedClock])
import 'responsibility_service_test.mocks.dart';

void main() {
  late ResponsibilityService service;
  late MockResponsibilityRepository mockRepo;
  late MockTrustedClock mockClock;

  setUp(() {
    mockRepo = MockResponsibilityRepository();
    mockClock = MockTrustedClock();
    when(mockClock.now()).thenReturn(DateTime.now());
    service = ResponsibilityService(mockRepo, mockClock);
  });

  test('Should NOT escalate if SLA is not breached', () async {
    final resp = FamilyResponsibility()
      ..uuid = '123'
      ..status = ResponsibilityStatus.pending
      ..dueDate = DateTime.now()
          .subtract(const Duration(minutes: 10)) // Missed by 10 mins
      ..escalationDelayMinutes = 30 // But SLA gives 30 mins
      ..confidenceScore = 100;

    when(mockRepo.getResponsibilityByUuid('123')).thenAnswer((_) async => resp);

    await service.escalateIfBreached('123');

    expect(resp.status, ResponsibilityStatus.pending);
    expect(resp.confidenceScore, 100);
    verifyNever(mockRepo.saveResponsibility(any));
  });

  test('Should escalate and decrease confidence score if SLA breached',
      () async {
    final resp = FamilyResponsibility()
      ..uuid = '123'
      ..status = ResponsibilityStatus.pending
      ..dueDate = DateTime.now()
          .subtract(const Duration(minutes: 40)) // Missed by 40 mins
      ..escalationDelayMinutes = 30 // SLA breached
      ..confidenceScore = 100;

    when(mockRepo.getResponsibilityByUuid('123')).thenAnswer((_) async => resp);

    await service.escalateIfBreached('123');

    expect(resp.status, ResponsibilityStatus.escalated);
    expect(resp.confidenceScore, 90);
    verify(mockRepo.saveResponsibility(resp)).called(1);
  });
}
