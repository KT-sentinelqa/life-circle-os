import 'package:flutter/foundation.dart';

@immutable
class Address {
  const Address({
    required this.street1,
    this.street2,
    required this.city,
    required this.stateRegion,
    required this.postalCode,
    required this.countryCode,
  });

  final String street1;
  final String? street2;
  final String city;
  final String stateRegion;
  final String postalCode;
  final String countryCode;
}
