import 'package:flutter/foundation.dart';

@immutable
class HouseholdProfile {
  const HouseholdProfile({
    required this.householdId,
    required this.name,
    required this.ownerId,
    this.primaryEmail,
    this.primaryPhone,
  });

  final String householdId;
  final String name;
  final String ownerId;
  final String? primaryEmail;
  final String? primaryPhone;

  HouseholdProfile copyWith({
    String? name,
    String? ownerId,
    String? primaryEmail,
    String? primaryPhone,
  }) {
    return HouseholdProfile(
      householdId: householdId,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
      primaryEmail: primaryEmail ?? this.primaryEmail,
      primaryPhone: primaryPhone ?? this.primaryPhone,
    );
  }
}
