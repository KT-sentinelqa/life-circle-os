import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class PreferenceEvent {
  PreferenceEvent({
    required this.householdId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  final String eventId;
  final String householdId;
  final DateTime timestamp;
}

class PrivacyPolicyUpdated extends PreferenceEvent {
  PrivacyPolicyUpdated({
    required super.householdId,
    required this.dataSharingConsent,
    required this.telemetryEnabled,
  });

  final bool dataSharingConsent;
  final bool telemetryEnabled;
}

class AIAssistantToggled extends PreferenceEvent {
  AIAssistantToggled({
    required super.householdId,
    required this.assistantEnabled,
  });

  final bool assistantEnabled;
}

class AutomationsSuspended extends PreferenceEvent {
  AutomationsSuspended({required super.householdId});
}
