/// Defines who has visibility and access to a medicine.
enum VisibilityPolicy {
  /// Only the owner and the assigned member can see it.
  private,

  /// Owner, assigned member, and specifically assigned caregivers can see it.
  caregivers,

  /// Everyone in the family can see it.
  family,
}
