import 'package:flutter/foundation.dart';

@immutable
class AIAssistantPreferences {
  const AIAssistantPreferences({
    required this.assistantEnabled,
    required this.allowContextIngestion,
  });

  final bool assistantEnabled;
  final bool allowContextIngestion;

  AIAssistantPreferences copyWith({
    bool? assistantEnabled,
    bool? allowContextIngestion,
  }) {
    return AIAssistantPreferences(
      assistantEnabled: assistantEnabled ?? this.assistantEnabled,
      allowContextIngestion: allowContextIngestion ?? this.allowContextIngestion,
    );
  }
}
