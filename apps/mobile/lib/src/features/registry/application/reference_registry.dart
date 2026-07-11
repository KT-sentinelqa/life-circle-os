abstract class ReferenceRegistry {
  /// Validates if a given household ID exists and is active.
  Future<bool> isValidHousehold(String householdId);

  /// Validates if a given member exists within the specified household.
  Future<bool> isValidMember(String householdId, String memberId);

  /// Validates if a specific document exists and is not archived.
  Future<bool> isValidDocument(String documentId);
}
