import 'package:flutter/foundation.dart';

@immutable
class PrivacyPreferences {
  const PrivacyPreferences({
    required this.dataSharingConsent,
    required this.telemetryEnabled,
  });

  final bool dataSharingConsent;
  final bool telemetryEnabled;

  PrivacyPreferences copyWith({
    bool? dataSharingConsent,
    bool? telemetryEnabled,
  }) {
    return PrivacyPreferences(
      dataSharingConsent: dataSharingConsent ?? this.dataSharingConsent,
      telemetryEnabled: telemetryEnabled ?? this.telemetryEnabled,
    );
  }
}
