import 'package:isar/isar.dart';

part 'session.g.dart';

@collection
class Session {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String sessionId;

  late String userId;

  /// Hardware-backed device ID
  late String deviceId;

  /// The access token (JWT), expires every 15 minutes.
  late String accessToken;
  late DateTime accessExpiresAt;

  /// The opaque refresh token, expires in 30 days.
  /// Note: The actual raw refresh token might be stored in Keychain,
  /// this is the reference/ID for it.
  late String refreshTokenReference;
  late DateTime refreshExpiresAt;

  late DateTime createdAt;
  late DateTime lastActiveAt;
}
