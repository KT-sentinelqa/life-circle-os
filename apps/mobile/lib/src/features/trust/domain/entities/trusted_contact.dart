import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/trust_level.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/verification_status.dart';
import 'package:lifecircle_mobile/src/features/trust/domain/value_objects/contact_method.dart';

@immutable
class TrustedContact {
  TrustedContact({
    required this.memberId,
    required this.name,
    required this.level,
    required this.status,
    required this.contactMethods,
  }) : contactId = const Uuid().v4();

  const TrustedContact._({
    required this.contactId,
    required this.memberId,
    required this.name,
    required this.level,
    required this.status,
    required this.contactMethods,
  });

  final String contactId;
  final String memberId; // Reference to Family Bounded Context
  final String name;
  final TrustLevel level;
  final VerificationStatus status;
  final List<ContactMethod> contactMethods;

  TrustedContact copyWith({
    TrustLevel? level,
    VerificationStatus? status,
  }) {
    return TrustedContact._(
      contactId: contactId,
      memberId: memberId,
      name: name,
      level: level ?? this.level,
      status: status ?? this.status,
      contactMethods: contactMethods,
    );
  }
}
