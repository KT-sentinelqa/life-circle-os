import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Represents an authenticated user within LifeCircle OS.
///
/// In V1, a user belongs to exactly one family, establishing the
/// Family aggregate root relationship immediately after onboarding.
@freezed
abstract class User with _$User {
  /// Creates a new [User].
  const factory User({
    /// The unique identifier for the user.
    required String id,
    
    /// The user's full name.
    required String name,
    
    /// The user's email address.
    required String email,
    
    /// The ID of the family the user belongs to, if any.
    String? familyId,
  }) = _User;

  /// Creates a [User] from a JSON object.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
