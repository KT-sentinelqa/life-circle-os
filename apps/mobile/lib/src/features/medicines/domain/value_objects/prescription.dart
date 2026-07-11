import 'package:flutter/foundation.dart';

@immutable
class Prescription {
  const Prescription({
    required this.doctorId,
    required this.doctorName,
    required this.issuedAt,
    this.attachmentUri,
  });

  final String doctorId;
  final String doctorName;
  final DateTime issuedAt;
  final String? attachmentUri;

  Map<String, dynamic> toJson() => {
    'doctorId': doctorId,
    'doctorName': doctorName,
    'issuedAt': issuedAt.toIso8601String(),
    'attachmentUri': attachmentUri,
  };
}
