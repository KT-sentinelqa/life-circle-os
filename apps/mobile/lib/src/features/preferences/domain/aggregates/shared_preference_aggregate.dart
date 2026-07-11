import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/entities/privacy_preferences.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/entities/ai_assistant_preferences.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/entities/notification_preferences.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/entities/automation_preferences.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/events/preference_events.dart';

@immutable
class SharedPreferenceAggregate {
  const SharedPreferenceAggregate._({
    required this.householdId,
    required this.privacy,
    required this.aiAssistant,
    required this.notifications,
    required this.automations,
  });

  final String householdId;
  final PrivacyPreferences privacy;
  final AIAssistantPreferences aiAssistant;
  final NotificationPreferences notifications;
  final AutomationPreferences automations;

  // --- Aggregate Behaviors ---

  static ({SharedPreferenceAggregate aggregate, List<PreferenceEvent> events}) initialize(String householdId) {
    final aggregate = SharedPreferenceAggregate._(
      householdId: householdId,
      privacy: const PrivacyPreferences(dataSharingConsent: false, telemetryEnabled: false),
      aiAssistant: const AIAssistantPreferences(assistantEnabled: false, allowContextIngestion: false),
      notifications: const NotificationPreferences(globalPushEnabled: true, quietHoursEnabled: false),
      automations: const AutomationPreferences(globalEnable: false),
    );
    // Silent initialization, no events needed until mutated.
    return (aggregate: aggregate, events: []);
  }

  ({SharedPreferenceAggregate aggregate, List<PreferenceEvent> events}) updatePrivacy({
    required bool dataSharingConsent,
    required bool telemetryEnabled,
  }) {
    final newPrivacy = privacy.copyWith(
      dataSharingConsent: dataSharingConsent,
      telemetryEnabled: telemetryEnabled,
    );

    var newAiAssistant = aiAssistant;
    final List<PreferenceEvent> events = [
      PrivacyPolicyUpdated(
        householdId: householdId,
        dataSharingConsent: dataSharingConsent,
        telemetryEnabled: telemetryEnabled,
      )
    ];

    // INVARIANT: Disabling data sharing MUST instantly disable AI Assistant.
    if (!dataSharingConsent && aiAssistant.assistantEnabled) {
      newAiAssistant = aiAssistant.copyWith(assistantEnabled: false, allowContextIngestion: false);
      events.add(AIAssistantToggled(householdId: householdId, assistantEnabled: false));
    }

    return (
      aggregate: copyWith(privacy: newPrivacy, aiAssistant: newAiAssistant),
      events: events,
    );
  }

  ({SharedPreferenceAggregate aggregate, List<PreferenceEvent> events}) toggleAIAssistant(bool enable) {
    if (enable && !privacy.dataSharingConsent) {
      throw Exception('Invariant Violation: Cannot enable AI Assistant without Data Sharing Consent.');
    }

    final event = AIAssistantToggled(
      householdId: householdId,
      assistantEnabled: enable,
    );

    return (
      aggregate: copyWith(aiAssistant: aiAssistant.copyWith(assistantEnabled: enable)),
      events: [event],
    );
  }

  ({SharedPreferenceAggregate aggregate, List<PreferenceEvent> events}) toggleAutomations(bool enable) {
    final List<PreferenceEvent> events = [];
    if (!enable && automations.globalEnable) {
      events.add(AutomationsSuspended(householdId: householdId));
    }

    return (
      aggregate: copyWith(automations: automations.copyWith(globalEnable: enable)),
      events: events,
    );
  }

  // --- Helpers ---

  SharedPreferenceAggregate copyWith({
    PrivacyPreferences? privacy,
    AIAssistantPreferences? aiAssistant,
    NotificationPreferences? notifications,
    AutomationPreferences? automations,
  }) {
    return SharedPreferenceAggregate._(
      householdId: householdId,
      privacy: privacy ?? this.privacy,
      aiAssistant: aiAssistant ?? this.aiAssistant,
      notifications: notifications ?? this.notifications,
      automations: automations ?? this.automations,
    );
  }
}
