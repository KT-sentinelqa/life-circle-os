import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class HouseholdEvent {
  HouseholdEvent({
    required this.householdId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  final String eventId;
  final String householdId;
  final DateTime timestamp;
}

class HouseholdCreated extends HouseholdEvent {
  HouseholdCreated({
    required super.householdId,
    required this.name,
    required this.ownerId,
  });

  final String name;
  final String ownerId;
}

class HouseholdUpdated extends HouseholdEvent {
  HouseholdUpdated({
    required super.householdId,
    this.name,
    this.primaryEmail,
  });

  final String? name;
  final String? primaryEmail;
}

class HouseholdArchived extends HouseholdEvent {
  HouseholdArchived({required super.householdId});
}

class TimezoneChanged extends HouseholdEvent {
  TimezoneChanged({
    required super.householdId,
    required this.newTimezone,
  });

  final String newTimezone;
}

class LocaleChanged extends HouseholdEvent {
  LocaleChanged({
    required super.householdId,
    required this.newLocaleCode,
  });

  final String newLocaleCode;
}

class AddressChanged extends HouseholdEvent {
  AddressChanged({
    required super.householdId,
    required this.city,
    required this.countryCode,
  });

  final String city;
  final String countryCode;
}

class HouseholdOwnershipTransferred extends HouseholdEvent {
  HouseholdOwnershipTransferred({
    required super.householdId,
    required this.newOwnerId,
  });

  final String newOwnerId;
}

class CurrencyMigrated extends HouseholdEvent {
  CurrencyMigrated({
    required super.householdId,
    required this.newCurrency,
  });

  final String newCurrency;
}
