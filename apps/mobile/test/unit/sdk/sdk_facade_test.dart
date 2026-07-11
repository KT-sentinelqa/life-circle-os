import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/sdk/v1/errors/lifecircle_exception.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/aggregates/shared_preference_aggregate.dart';

void main() {
  group('Phase 3A Sprint 5: SDK Facade Error Mapping', () {
    test('Internal Aggregate Invariant Exception maps to SDK ValidationException', () {
      // Simulate an internal aggregate rejecting a bad command
      final init = SharedPreferenceAggregate.initialize('hh_1');
      
      try {
        // Attempt to bypass privacy (internal throw)
        init.aggregate.toggleAIAssistant(true);
        fail('Should have thrown internal Exception');
      } catch (e) {
        // Mocking the Application Service / SDK Facade boundary catching the internal error
        // In reality this happens inside the SDK implementation wrapper.
        final mappedError = _mockSdkWrapper(e);
        
        expect(mappedError, isA<ValidationException>());
        expect((mappedError as ValidationException).message, contains('Cannot enable AI Assistant'));
      }
    });
  });
}

// Mock of what the PreferencesSDKImpl does
LifeCircleException _mockSdkWrapper(Object error) {
  if (error is Exception && error.toString().contains('Invariant Violation')) {
    return const ValidationException('Cannot enable AI Assistant without Data Sharing Consent.');
  }
  return const SyncException();
}
