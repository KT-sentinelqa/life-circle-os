import 'package:mobile/src/features/authentication/domain/entities/user.dart';

/// Abstract contract for authentication data operations.
abstract class AuthRepository {
  /// Authenticates a user with [email] and [password].
  Future<User> login({required String email, required String password});

  /// Registers a new user with [name], [email], and [password].
  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  /// Associates the authenticated user with a [familyId].
  Future<User> createFamily({required String familyName});

  /// Logs the user out and clears the session.
  Future<void> logout();

  /// Checks if a valid session exists and returns the associated [User].
  Future<User?> checkSession();
}
