import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lifecircle_mobile/src/features/emergency/application/emergency_providers.dart';
import 'package:lifecircle_mobile/src/features/emergency/domain/models/emergency_contact.dart';
import 'package:lifecircle_mobile/src/features/emergency/presentation/screens/emergency_screen.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  // Mock data for deterministic tests
  final mockContacts = [
    EmergencyContact()
      ..uuid = 'test-contact-1'
      ..householdId = 'household-default'
      ..name = 'Dr. Sharma'
      ..role = 'Cardiologist'
      ..phone = '+91 98765 43210'
      ..createdAt = DateTime(2026)
      ..updatedAt = DateTime(2026),
  ];

  testGoldens('EmergencyScreen - Data State (Light & Dark)', (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(
        devices: [
          Device.phone,
          Device.iphone11,
        ],
      )
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            emergencyContactsStreamProvider('household-default')
                .overrideWith((ref) => Stream.value(mockContacts)),
          ],
          child: MaterialApp(
            theme: ThemeData.light(), // Assuming you have LCTheme.light()
            home: EmergencyScreen(
              householdId: 'household-default',
              onAddContact: () {},
            ),
          ),
        ),
        name: 'Light Mode - Has Contacts',
      )
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            emergencyContactsStreamProvider('household-default')
                .overrideWith((ref) => Stream.value(mockContacts)),
          ],
          child: MaterialApp(
            theme: ThemeData.dark(), // Assuming you have LCTheme.dark()
            home: EmergencyScreen(
              householdId: 'household-default',
              onAddContact: () {},
            ),
          ),
        ),
        name: 'Dark Mode - Has Contacts',
      );

    await tester.pumpDeviceBuilder(builder);
    // Note: To actually generate the images, you must run `flutter test --update-goldens`
    await screenMatchesGolden(tester, 'emergency_screen_data');
  });

  testGoldens(
      'EmergencyScreen - Empty State (Accessibility/Dynamic Type scaling)',
      (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [Device.phone])
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            emergencyContactsStreamProvider('household-default')
                .overrideWith((ref) => Stream.value([])),
          ],
          child: MaterialApp(
            theme: ThemeData.light(),
            home: MediaQuery(
              // Simulate 150% Dynamic Type scaling (ADR-040)
              data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
              child: EmergencyScreen(
                householdId: 'household-default',
                onAddContact: () {},
              ),
            ),
          ),
        ),
        name: 'Empty State - 150% Text Scale',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'emergency_screen_empty_scaled');
  });
}
