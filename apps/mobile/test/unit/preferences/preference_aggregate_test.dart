import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/aggregates/shared_preference_aggregate.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/events/preference_events.dart';

void main() {
  group('Phase 3A Sprint 4: Shared Preference Aggregate', () {
    test('Initialization sets secure defaults without events', () {
      final init = SharedPreferenceAggregate.initialize('hh_1');

      expect(init.aggregate.privacy.dataSharingConsent, isFalse);
      expect(init.aggregate.aiAssistant.assistantEnabled, isFalse);
      expect(init.aggregate.automations.globalEnable, isFalse);
      expect(init.events, isEmpty);
    });

    test('Cannot enable AI Assistant if data sharing consent is false', () {
      final init = SharedPreferenceAggregate.initialize('hh_1');

      expect(
        () => init.aggregate.toggleAIAssistant(true),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('Invariant Violation'))),
      );
    });

    test('Revoking data sharing instantly disables AI Assistant', () {
      final init = SharedPreferenceAggregate.initialize('hh_1');
      
      // First, grant consent
      final withConsent = init.aggregate.updatePrivacy(dataSharingConsent: true, telemetryEnabled: true);
      
      // Then enable AI
      final withAi = withConsent.aggregate.toggleAIAssistant(true);
      expect(withAi.aggregate.aiAssistant.assistantEnabled, isTrue);

      // Now revoke consent
      final revoked = withAi.aggregate.updatePrivacy(dataSharingConsent: false, telemetryEnabled: false);

      // Verify AI is disabled
      expect(revoked.aggregate.aiAssistant.assistantEnabled, isFalse);
      
      // Verify cascading events: PrivacyUpdated AND AIAssistantToggled(false)
      expect(revoked.events.length, 2);
      expect(revoked.events[0], isA<PrivacyPolicyUpdated>());
      expect(revoked.events[1], isA<AIAssistantToggled>());
      expect((revoked.events[1] as AIAssistantToggled).assistantEnabled, isFalse);
    });

    test('Suspending automations yields event', () {
      final init = SharedPreferenceAggregate.initialize('hh_1');
      
      // Enable it first
      final enabled = init.aggregate.toggleAutomations(true);
      expect(enabled.events, isEmpty); // Simple toggle doesn't yield suspension event

      // Disable it
      final disabled = enabled.aggregate.toggleAutomations(false);
      
      expect(disabled.aggregate.automations.globalEnable, isFalse);
      expect(disabled.events.length, 1);
      expect(disabled.events.first, isA<AutomationsSuspended>());
    });
  });
}
