import 'package:flutter/foundation.dart';

@immutable
class FamilyDTO {
  const FamilyDTO({
    required this.familyId,
    required this.name,
    required this.ownerId,
    required this.memberIds,
  });

  final String familyId;
  final String name;
  final String ownerId;
  final List<String> memberIds;

  Map<String, dynamic> toJson() => {
    'familyId': familyId,
    'name': name,
    'ownerId': ownerId,
    'memberIds': memberIds,
  };
}
