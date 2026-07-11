import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/value_objects/odometer.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/value_objects/document_reference.dart';

@immutable
class ServiceRecord {
  ServiceRecord({
    required this.recordedAt,
    required this.odometer,
    required this.description,
    this.invoiceReference,
  }) : recordId = const Uuid().v4();

  final String recordId;
  final DateTime recordedAt;
  final Odometer odometer;
  final String description;
  final DocumentReference? invoiceReference;
}
