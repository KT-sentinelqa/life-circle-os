import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/household/domain/aggregates/household_aggregate.dart';
import 'package:lifecircle_mobile/src/features/household/domain/entities/household_settings.dart';
import 'package:lifecircle_mobile/src/features/household/domain/entities/household_preferences.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/timezone.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/locale.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/currency.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/measurement_system.dart';
import 'package:lifecircle_mobile/src/features/household/domain/events/household_events.dart';

void main() {
  group('Phase 3A Sprint 2: Household Aggregate', () {
    late HouseholdSettings defaultSettings;
    late HouseholdPreferences defaultPreferences;

    setUp(() {
      defaultSettings = const HouseholdSettings(
        timezone: Timezone('America/New_York'),
        allowGuestInvites: false,
      );
      defaultPreferences = const HouseholdPreferences(
        locale: LocaleVO('en', 'US'),
        currency: Currency('USD'),
        measurementSystem: MeasurementSystem(MeasurementSystemType.imperial),
      );
    });

    test('Creating household yields HouseholdCreated event', () {
      final result = HouseholdAggregate.create(
        name: 'Tiwari Household',
        ownerId: 'user_1',
        settings: defaultSettings,
        preferences: defaultPreferences,
      );

      expect(result.aggregate.profile.name, 'Tiwari Household');
      expect(result.aggregate.isArchived, isFalse);
      expect(result.events.length, 1);
      expect(result.events.first, isA<HouseholdCreated>());
    });

    test('Cannot archive household with active dependents or invitations', () {
      // Fake a state with multiple members
      final result = HouseholdAggregate.create(
        name: 'Tiwari Household',
        ownerId: 'user_1',
        settings: defaultSettings,
        preferences: defaultPreferences,
      );

      final aggregateWithMembers = result.aggregate.copyWith(activeMemberCount: 2);

      expect(
        () => aggregateWithMembers.archive(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('dependents/members'))),
      );

      final aggregateWithInvites = result.aggregate.copyWith(pendingInvitationsCount: 1);

      expect(
        () => aggregateWithInvites.archive(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('pending invitations'))),
      );
    });

    test('Valid archive yields HouseholdArchived event', () {
      final result = HouseholdAggregate.create(
        name: 'Tiwari Household',
        ownerId: 'user_1',
        settings: defaultSettings,
        preferences: defaultPreferences,
      );

      final archiveResult = result.aggregate.archive();

      expect(archiveResult.aggregate.isArchived, isTrue);
      expect(archiveResult.events.length, 1);
      expect(archiveResult.events.first, isA<HouseholdArchived>());
    });

    test('Updating timezone yields TimezoneChanged event', () {
      final result = HouseholdAggregate.create(
        name: 'Tiwari Household',
        ownerId: 'user_1',
        settings: defaultSettings,
        preferences: defaultPreferences,
      );

      final updateResult = result.aggregate.updateTimezone(const Timezone('Europe/London'));

      expect(updateResult.aggregate.settings.timezone.value, 'Europe/London');
      expect(updateResult.events.length, 1);
      expect(updateResult.events.first, isA<TimezoneChanged>());
    });

    test('Migrating currency yields CurrencyMigrated event', () {
      final result = HouseholdAggregate.create(
        name: 'Tiwari Household',
        ownerId: 'user_1',
        settings: defaultSettings,
        preferences: defaultPreferences,
      );

      final migrateResult = result.aggregate.migrateCurrency(const Currency('EUR'));

      expect(migrateResult.aggregate.preferences.currency.code, 'EUR');
      expect(migrateResult.events.length, 1);
      expect(migrateResult.events.first, isA<CurrencyMigrated>());
    });

    test('Cannot mutate archived household', () {
      final result = HouseholdAggregate.create(
        name: 'Tiwari Household',
        ownerId: 'user_1',
        settings: defaultSettings,
        preferences: defaultPreferences,
      );

      final archivedAggregate = result.aggregate.archive().aggregate;

      expect(
        () => archivedAggregate.updateProfile(name: 'New Name'),
        throwsA(isA<Exception>()),
      );
      
      expect(
        () => archivedAggregate.updateTimezone(const Timezone('Asia/Kolkata')),
        throwsA(isA<Exception>()),
      );
    });
  });
}
