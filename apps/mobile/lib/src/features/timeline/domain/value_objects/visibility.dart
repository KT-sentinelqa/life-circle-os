import 'package:flutter/foundation.dart';

enum VisibilityLevel {
  public,     // Visible to all family members
  restricted, // Visible to specific roles (e.g., Owner/Admin)
  private,    // Visible only to the actor
}

@immutable
class Visibility {
  const Visibility(this.level, [this.restrictedToRoles = const []]);

  final VisibilityLevel level;
  final List<String> restrictedToRoles;
}
