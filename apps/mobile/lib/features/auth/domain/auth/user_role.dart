/// LifeCircle OS — UserRole domain enum (mobile).
///
/// Mirrors the backend UserRole enum. Used in BLoC and UI.
library;

/// Permitted roles within a family unit.
enum UserRole {
  /// Primary decision-maker with full family management access.
  guardian,

  /// Caregiver or support person with delegated access.
  helper,

  /// Family member receiving care (elder, child).
  dependent;

  /// Human-readable display label for UI rendering.
  String get displayLabel => switch (this) {
        UserRole.guardian  => 'Guardian',
        UserRole.helper    => 'Helper',
        UserRole.dependent => 'Dependent',
      };
}
