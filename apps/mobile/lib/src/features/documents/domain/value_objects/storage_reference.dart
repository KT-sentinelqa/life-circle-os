import 'package:flutter/foundation.dart';

@immutable
class StorageReference {
  const StorageReference({
    required this.provider,
    required this.uri,
    required this.checksum,
  });

  final String provider; // e.g. 'aws_s3', 'gcs'
  final String uri;
  final String checksum;

  Map<String, dynamic> toJson() => {
    'provider': provider,
    'uri': uri,
    'checksum': checksum,
  };
}
