import 'dart:convert';

/// Strongly typed payload attached to a scheduled notification.
class NotificationPayload {
  /// Creates a [NotificationPayload].
  const NotificationPayload({
    required this.familyId,
    required this.userId,
    required this.medicineId,
    required this.reminderId,
  });

  /// Creates a [NotificationPayload] from a JSON string.
  factory NotificationPayload.fromJsonString(String source) {
    final map = jsonDecode(source) as Map<String, dynamic>;
    return NotificationPayload(
      familyId: map['familyId'] as String,
      userId: map['userId'] as String,
      medicineId: map['medicineId'] as String,
      reminderId: map['reminderId'] as String,
    );
  }

  /// Identifies the family.
  final String familyId;

  /// Identifies the user within the family.
  final String userId;

  /// Identifies the specific medicine.
  final String medicineId;

  /// Identifies the exact reminder instance.
  final String reminderId;

  /// Serializes the payload to a JSON string for the OS notification.
  String toJsonString() {
    return jsonEncode({
      'familyId': familyId,
      'userId': userId,
      'medicineId': medicineId,
      'reminderId': reminderId,
    });
  }
}
