import 'package:flutter/foundation.dart';

@immutable
class LocaleVO {
  const LocaleVO(this.languageCode, [this.countryCode]) 
      : assert(languageCode.length >= 2);
  final String languageCode; // e.g., 'en'
  final String? countryCode; // e.g., 'US'
}
