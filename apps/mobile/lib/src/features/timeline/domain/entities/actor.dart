import 'package:flutter/foundation.dart';

@immutable
class Actor {
  const Actor({
    required this.memberId,
    required this.name,
    this.isSystem = false,
  });

  final String memberId;
  final String name;
  final bool isSystem;
}
