import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_list_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/today_reminders_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/screens/medicine_dashboard_screen.dart';

class MockTodayRemindersNotifier extends TodayRemindersNotifier {
  MockTodayRemindersNotifier(this.initialData);

  final List<ReminderEntity> initialData;

  @override
  Future<List<ReminderEntity>> build() async => initialData;

  @override
  Future<void> refresh() async {}

  @override
  Future<void> takeReminder(String id) async {}

  @override
  Future<void> skipReminder(String id) async {}

  @override
  Future<void> snoozeReminder(String id, Duration duration) async {}
}

class MockMedicineListState extends MedicineListState {
  MockMedicineListState(this.initialData);

  final List<MedicineEntity> initialData;

  @override
  Future<List<MedicineEntity>> build() async => initialData;

  @override
  Future<void> refresh() async {}
}

void main() {
  testWidgets('MedicineDashboardScreen displays Today and All Medications tabs',
      (tester) async {
    final now = DateTime.utc(2026);

    final mockReminders = [
      ReminderEntity(
        id: 'r1',
        medicineId: 'm1',
        familyId: 'f1',
        memberId: 'u1',
        scheduledTimeUtc: now.add(const Duration(hours: 1)),
        createdAt: now,
        updatedAt: now,
      ),
    ];

    final mockMedicines = [
      MedicineEntity(
        id: 'm1',
        familyId: 'f1',
        memberId: 'u1',
        name: 'Aspirin',
        dosage: '100mg',
        form: 'Pill',
        instructions: 'Take with water',
        createdAtUtc: now,
        updatedAtUtc: now,
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          todayRemindersProvider.overrideWith(
            () => MockTodayRemindersNotifier(mockReminders),
          ),
          medicineListStateProvider.overrideWith(
            () => MockMedicineListState(mockMedicines),
          ),
        ],
        child: const MaterialApp(
          home: MedicineDashboardScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('All Medications'), findsOneWidget);
    expect(find.text('Upcoming'), findsOneWidget);
    expect(find.text('Take'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Snooze'), findsOneWidget);

    await tester.tap(find.text('Take'));
    await tester.pump();
    await tester.tap(find.text('Skip'));
    await tester.pump();
    await tester.tap(find.text('Snooze'));
    await tester.pump();
  });
}
