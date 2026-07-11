import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/trust_level.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/verification_status.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/contact_method.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/entities/trusted_contact.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/entities/emergency_profile.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/aggregates/trust_network_aggregate.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/events/trust_events.dart';

void main() {
  group('Phase 3B Sprint 5: Trust Aggregate', () {
    test('Adding duplicate contact throws Exception', () {
      final init = TrustNetworkAggregate.initialize(householdId: 'hh_1', ownerId: 'mem_1');
      
      final contact = TrustedContact(
        memberId: 'mem_2',
        name: 'Wife',
        level: TrustLevel.standard,
        status: VerificationStatus.pending,
        contactMethods: [const ContactMethod(type: 'phone', value: '1234567890')],
      );

      final result1 = init.aggregate.addContact(ownerName: 'Krishna', contact: contact);

      expect(
        () => result1.aggregate.addContact(ownerName: 'Krishna', contact: contact),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('Duplicate Contact'))),
      );
    });

    test('Activating emergency profile with no contacts throws Exception', () {
      final init = TrustNetworkAggregate.initialize(householdId: 'hh_1', ownerId: 'mem_1');

      expect(
        () => init.aggregate.activateEmergencyProfile('Krishna'),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('least one primary emergency contact'))),
      );
    });

    test('Activating emergency profile with unverified primary contact throws Exception', () {
      final init = TrustNetworkAggregate.initialize(householdId: 'hh_1', ownerId: 'mem_1');
      
      final contact = TrustedContact(
        memberId: 'mem_2',
        name: 'Brother',
        level: TrustLevel.high,
        status: VerificationStatus.pending, // UNVERIFIED!
        contactMethods: [],
      );

      final state1 = init.aggregate.addContact(ownerName: 'Krishna', contact: contact).aggregate;
      
      // Manually push into emergency profile for test
      final state2 = state1.copyWith(
        emergencyProfile: EmergencyProfile(
          primaryContactIds: [contact.contactId],
          medicalConstraints: '',
          isActive: false,
        )
      );

      expect(
        () => state2.activateEmergencyProfile('Krishna'),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('is not verified'))),
      );
    });

    test('Successfully activating emergency profile yields EmergencyProfileActivated event', () {
      final init = TrustNetworkAggregate.initialize(householdId: 'hh_1', ownerId: 'mem_1');
      
      final contact = TrustedContact(
        memberId: 'mem_2',
        name: 'Brother',
        level: TrustLevel.high,
        status: VerificationStatus.verified, // VERIFIED
        contactMethods: [],
      );

      final state1 = init.aggregate.addContact(ownerName: 'Krishna', contact: contact).aggregate;
      
      final state2 = state1.copyWith(
        emergencyProfile: EmergencyProfile(
          primaryContactIds: [contact.contactId],
          medicalConstraints: '',
          isActive: false,
        )
      );

      final result = state2.activateEmergencyProfile('Krishna');

      expect(result.aggregate.emergencyProfile.isActive, isTrue);
      expect(result.events.length, 1);
      expect(result.events.first, isA<EmergencyProfileActivated>());
    });
  });
}
