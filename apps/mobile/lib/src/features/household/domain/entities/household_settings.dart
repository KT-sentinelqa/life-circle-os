import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/timezone.dart';

@immutable
class HouseholdSettings {
  const HouseholdSettings({
    required this.timezone,
    required this.allowGuestInvites,
  });

  final Timezone timezone;
  final bool allowGuestInvites;

  HouseholdSettings copyWith({
    Timezone? timezone,
    bool? allowGuestInvites,
  }) {
    return HouseholdSettings(
      timezone: timezone ?? this.timezone,
      allowGuestInvites: allowGuestInvites ?? this.allowGuestInvites,
    );
  }
}
