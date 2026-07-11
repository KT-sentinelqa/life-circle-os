import 'package:flutter/foundation.dart';

@immutable
class AutomationPreferences {
  const AutomationPreferences({
    required this.globalEnable,
  });

  final bool globalEnable;

  AutomationPreferences copyWith({
    bool? globalEnable,
  }) {
    return AutomationPreferences(
      globalEnable: globalEnable ?? this.globalEnable,
    );
  }
}
