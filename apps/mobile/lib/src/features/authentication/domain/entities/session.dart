import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

/// Represents a secure local authentication session.
@freezed
class Session with _$Session {
  /// Creates a new [Session].
  const factory Session({
    /// The JWT access token.
    required String accessToken,
    
    /// The JWT refresh token.
    required String refreshToken,
    
    /// The expiry date of the access token.
    required DateTime expiry,
  }) = _Session;

  /// Creates a [Session] from a JSON object.
  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);
}
