import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';
import 'package:lifecircle_mobile/src/features/authentication/data/repositories/production_auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorageService {}
class MockDio extends Mock implements Dio {}

void main() {
  group('ProductionAuthRepository SEC-001 Validation', () {
    late ProductionAuthRepository repository;
    late MockSecureStorage mockStorage;
    late MockDio mockDio;

    setUp(() {
      mockStorage = MockSecureStorage();
      mockDio = MockDio();
      repository = ProductionAuthRepository(mockStorage, mockDio);
    });

    test('verifyOtp throws UnsupportedError and does not issue mock tokens', () async {
      // SEC-001: The production auth repository should explicitly throw until the backend contract is established.
      expect(
        () => repository.verifyOtp(identifier: 'test@lifecircle.com', otp: '123456'),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('requestOtp throws UnsupportedError', () async {
      expect(
        () => repository.requestOtp(identifier: 'test@lifecircle.com'),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('checkSession returns null when storage is empty', () async {
      when(() => mockStorage.read('current_user')).thenAnswer((_) async => null);
      when(() => mockStorage.read('current_session')).thenAnswer((_) async => null);

      final user = await repository.checkSession();
      expect(user, isNull);
      
      verify(() => mockStorage.read('current_user')).called(1);
      verify(() => mockStorage.read('current_session')).called(1);
    });

    test('logout deletes session from secure storage', () async {
      when(() => mockStorage.delete('current_user')).thenAnswer((_) async => null);
      when(() => mockStorage.delete('current_session')).thenAnswer((_) async => null);

      await repository.logout();

      verify(() => mockStorage.delete('current_user')).called(1);
      verify(() => mockStorage.delete('current_session')).called(1);
    });
  });
}
