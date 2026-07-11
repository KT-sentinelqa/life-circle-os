import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/locale.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/currency.dart';
import 'package:lifecircle_mobile/src/features/household/domain/value_objects/measurement_system.dart';

@immutable
class HouseholdPreferences {
  const HouseholdPreferences({
    required this.locale,
    required this.currency,
    required this.measurementSystem,
  });

  final LocaleVO locale;
  final Currency currency;
  final MeasurementSystem measurementSystem;

  HouseholdPreferences copyWith({
    LocaleVO? locale,
    Currency? currency,
    MeasurementSystem? measurementSystem,
  }) {
    return HouseholdPreferences(
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      measurementSystem: measurementSystem ?? this.measurementSystem,
    );
  }
}
