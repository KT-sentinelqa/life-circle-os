/// Centralized registry for Hero animation tags.
/// Prevents inline strings and ensures consistent motion across the app.
abstract final class HeroTags {
  /// Hero tag for the family avatar/logo.
  static const String familyAvatar = 'family-avatar';

  /// Hero tag for the global health score.
  static const String healthScore = 'health-score';

  /// Hero tag prefix for a medicine card.
  /// Append the medicine ID to make it unique: `'$medicineCardPrefix-$id'`.
  static const String medicineCardPrefix = 'medicine-card';
}
