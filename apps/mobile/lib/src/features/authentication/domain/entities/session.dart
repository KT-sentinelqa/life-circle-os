import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

/// Represents a secure local authentication session.
@freezed
abstract class Session with _$Session {
  /// Creates a new [Session].
  const factory Session({
    required String accessToken,
    required String refreshToken,
    required DateTime expiry,
  }) = _Session;

  /// Creates a [Session] from a JSON object.
  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
}
