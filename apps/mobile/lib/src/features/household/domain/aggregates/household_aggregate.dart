import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/household/domain/entities/household_profile.dart';
import 'package:lifecircle_mobile/src/features/household/domain/entities/household_settings.dart';
import 'package:lifecircle_mobile/src/features/household/domain/entities/household_preferences.dart';
import 'package:lifecircle_mobile/src/features/household/domain/entities/address.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/timezone.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/currency.dart';
import 'package:lifecircle_mobile/src/features/household/domain/events/household_events.dart';

@immutable
class HouseholdAggregate {
  const HouseholdAggregate._({
    required this.profile,
    required this.settings,
    required this.preferences,
    this.address,
    required this.isArchived,
    required this.activeMemberCount,
    required this.pendingInvitationsCount,
  });

  final HouseholdProfile profile;
  final HouseholdSettings settings;
  final HouseholdPreferences preferences;
  final Address? address;
  final bool isArchived;
  final int activeMemberCount;
  final int pendingInvitationsCount;

  // --- Aggregate Behaviors ---

  /// Factory for creating a brand new household. Enforces invariants.
  static ({HouseholdAggregate aggregate, List<HouseholdEvent> events}) create({
    required String name,
    required String ownerId,
    required HouseholdSettings settings,
    required HouseholdPreferences preferences,
  }) {
    final householdId = const Uuid().v4();

    final aggregate = HouseholdAggregate._(
      profile: HouseholdProfile(
        householdId: householdId,
        name: name,
        ownerId: ownerId,
      ),
      settings: settings,
      preferences: preferences,
      isArchived: false,
      activeMemberCount: 1, // Owner is implicit
      pendingInvitationsCount: 0,
    );

    final event = HouseholdCreated(
      householdId: householdId,
      name: name,
      ownerId: ownerId,
    );

    return (aggregate: aggregate, events: [event]);
  }

  /// Updates profile metadata.
  ({HouseholdAggregate aggregate, List<HouseholdEvent> events}) updateProfile({
    String? name,
    String? primaryEmail,
  }) {
    if (isArchived) throw Exception('Cannot mutate archived household.');

    final updatedProfile = profile.copyWith(
      name: name,
      primaryEmail: primaryEmail,
    );

    final event = HouseholdUpdated(
      householdId: profile.householdId,
      name: name,
      primaryEmail: primaryEmail,
    );

    return (
      aggregate: copyWith(profile: updatedProfile),
      events: [event],
    );
  }

  /// Archives the household. Blocked if members or invites exist.
  ({HouseholdAggregate aggregate, List<HouseholdEvent> events}) archive() {
    if (activeMemberCount > 1) {
      throw Exception('Cannot archive household with active dependents/members.');
    }
    if (pendingInvitationsCount > 0) {
      throw Exception('Cannot archive household with pending invitations.');
    }

    final event = HouseholdArchived(householdId: profile.householdId);

    return (
      aggregate: copyWith(isArchived: true),
      events: [event],
    );
  }

  /// Changes the Timezone.
  ({HouseholdAggregate aggregate, List<HouseholdEvent> events}) updateTimezone(Timezone newTimezone) {
    if (isArchived) throw Exception('Cannot mutate archived household.');

    final event = TimezoneChanged(
      householdId: profile.householdId,
      newTimezone: newTimezone.value,
    );

    return (
      aggregate: copyWith(settings: settings.copyWith(timezone: newTimezone)),
      events: [event],
    );
  }

  /// Forces a currency migration. Very strict.
  ({HouseholdAggregate aggregate, List<HouseholdEvent> events}) migrateCurrency(Currency newCurrency) {
    if (isArchived) throw Exception('Cannot mutate archived household.');

    // Invariant: Cannot easily change currency without migration
    // Here we emit a migration event rather than a simple change
    final event = CurrencyMigrated(
      householdId: profile.householdId,
      newCurrency: newCurrency.code,
    );

    return (
      aggregate: copyWith(preferences: preferences.copyWith(currency: newCurrency)),
      events: [event],
    );
  }

  // --- Helpers ---

  HouseholdAggregate copyWith({
    HouseholdProfile? profile,
    HouseholdSettings? settings,
    HouseholdPreferences? preferences,
    Address? address,
    bool? isArchived,
    int? activeMemberCount,
    int? pendingInvitationsCount,
  }) {
    return HouseholdAggregate._(
      profile: profile ?? this.profile,
      settings: settings ?? this.settings,
      preferences: preferences ?? this.preferences,
      address: address ?? this.address,
      isArchived: isArchived ?? this.isArchived,
      activeMemberCount: activeMemberCount ?? this.activeMemberCount,
      pendingInvitationsCount: pendingInvitationsCount ?? this.pendingInvitationsCount,
    );
  }
}
