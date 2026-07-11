import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/trust_level.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/verification_status.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/entities/trusted_contact.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/entities/emergency_profile.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/events/trust_events.dart';

@immutable
class TrustNetworkAggregate {
  const TrustNetworkAggregate._({
    required this.networkId,
    required this.householdId,
    required this.ownerId,
    required this.contacts,
    required this.emergencyProfile,
  });

  final String networkId;
  final String householdId;
  final String ownerId;
  final List<TrustedContact> contacts;
  final EmergencyProfile emergencyProfile;

  static ({TrustNetworkAggregate aggregate, List<TrustEvent> events}) initialize({
    required String householdId,
    required String ownerId,
  }) {
    final aggregate = TrustNetworkAggregate._(
      networkId: const Uuid().v4(),
      householdId: householdId,
      ownerId: ownerId,
      contacts: const [],
      emergencyProfile: const EmergencyProfile(
        primaryContactIds: [],
        medicalConstraints: '',
        isActive: false,
      ),
    );
    return (aggregate: aggregate, events: []);
  }

  ({TrustNetworkAggregate aggregate, List<TrustEvent> events}) addContact({
    required String ownerName,
    required TrustedContact contact,
  }) {
    if (contacts.any((c) => c.memberId == contact.memberId)) {
      throw Exception('Duplicate Contact: This member is already in the trust network.');
    }

    final event = TrustedContactAdded(
      networkId: networkId,
      householdId: householdId,
      ownerId: ownerId,
      ownerName: ownerName,
      contactName: contact.name,
    );

    return (
      aggregate: copyWith(
        contacts: List.unmodifiable([...contacts, contact]),
      ),
      events: [event],
    );
  }

  ({TrustNetworkAggregate aggregate, List<TrustEvent> events}) activateEmergencyProfile(String ownerName) {
    if (emergencyProfile.primaryContactIds.isEmpty) {
      throw Exception('Activation Failed: Must have at least one primary emergency contact.');
    }

    for (final id in emergencyProfile.primaryContactIds) {
      final contact = contacts.firstWhere((c) => c.contactId == id);
      if (contact.status != VerificationStatus.verified) {
        throw Exception('Activation Failed: Primary contact ${contact.name} is not verified.');
      }
    }

    final event = EmergencyProfileActivated(
      networkId: networkId,
      householdId: householdId,
      ownerId: ownerId,
      ownerName: ownerName,
    );

    return (
      aggregate: copyWith(
        emergencyProfile: emergencyProfile.copyWith(isActive: true),
      ),
      events: [event],
    );
  }

  TrustNetworkAggregate copyWith({
    List<TrustedContact>? contacts,
    EmergencyProfile? emergencyProfile,
  }) {
    return TrustNetworkAggregate._(
      networkId: networkId,
      householdId: householdId,
      ownerId: ownerId,
      contacts: contacts ?? this.contacts,
      emergencyProfile: emergencyProfile ?? this.emergencyProfile,
    );
  }
}
