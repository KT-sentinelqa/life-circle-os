import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Represents an authenticated user in the system.
@freezed
class User with _$User {
  /// Creates a [User].
  const factory User({
    /// Unique identifier for the user.
    required String id,

    /// User's full name.
    required String name,

    /// User's email address.
    required String email,

    /// Optional ID of the user's family.
    String? familyId,
  }) = _User;

  /// Creates a [User] from a JSON object.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
