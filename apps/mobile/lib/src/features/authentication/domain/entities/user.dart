import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/auth_stage.dart';

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

    /// User's email address (optional if registered via phone).
    String? email,

    /// User's phone number (optional if registered via email).
    String? phoneNumber,

    /// Optional ID of the user's family.
    String? familyId,

    /// The user's current stage in the authentication pipeline.
    @Default(AuthStage.completed) AuthStage authStage,
  }) = _User;

  /// Creates a [User] from a JSON object.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
