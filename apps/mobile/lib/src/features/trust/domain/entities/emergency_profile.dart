import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/entities/trusted_contact.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/emergency_priority.dart';

@immutable
class EmergencyProfile {
  const EmergencyProfile({
    required this.primaryContactIds,
    required this.medicalConstraints,
    required this.isActive,
  });

  final List<String> primaryContactIds; // References to TrustedContacts
  final String medicalConstraints;
  final bool isActive;

  EmergencyProfile copyWith({
    List<String>? primaryContactIds,
    bool? isActive,
  }) {
    return EmergencyProfile(
      primaryContactIds: primaryContactIds ?? this.primaryContactIds,
      medicalConstraints: medicalConstraints,
      isActive: isActive ?? this.isActive,
    );
  }
}
