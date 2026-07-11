import 'package:lifecircle_mobile/src/sdk/v1/models/dto/preferences_dto.dart';

abstract class PreferencesSDK {
  /// Grants or revokes platform-wide data sharing consent.
  Future<void> updatePrivacyConsent(String householdId, bool granted);

  /// Attempts to enable the AI Assistant. Will throw [ValidationException] if Privacy Consent is missing.
  Future<void> toggleAiAssistant(String householdId, bool enabled);

  /// Fetches the current preferences state.
  Future<PreferencesDTO> getPreferences(String householdId);
}
