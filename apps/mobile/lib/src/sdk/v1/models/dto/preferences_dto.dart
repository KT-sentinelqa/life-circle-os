import 'package:flutter/foundation.dart';

@immutable
class PreferencesDTO {
  const PreferencesDTO({
    required this.dataSharingConsent,
    required this.aiAssistantEnabled,
    required this.globalPushEnabled,
  });

  final bool dataSharingConsent;
  final bool aiAssistantEnabled;
  final bool globalPushEnabled;

  Map<String, dynamic> toJson() => {
    'dataSharingConsent': dataSharingConsent,
    'aiAssistantEnabled': aiAssistantEnabled,
    'globalPushEnabled': globalPushEnabled,
  };
}
