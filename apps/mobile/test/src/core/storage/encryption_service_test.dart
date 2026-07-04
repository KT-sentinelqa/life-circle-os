import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/storage/encryption_service.dart';

void main() {
  group('EncryptionService', () {
    late EncryptionService encryptionService;
    late Key testKey;

    setUp(() {
      testKey = Key.fromSecureRandom(32);
      encryptionService = EncryptionService(testKey);
    });

    test('encrypts and decrypts text correctly', () {
      const plainText = 'secret_data_123';
      
      final encrypted = encryptionService.encrypt(plainText);
      expect(encrypted, isNot(equals(plainText)));
      expect(encrypted.contains(':'), isTrue);

      final decrypted = encryptionService.decrypt(encrypted);
      expect(decrypted, equals(plainText));
    });

    test('throws format exception for invalid encrypted text', () {
      expect(
        () => encryptionService.decrypt('invalid_format_no_colon'),
        throwsFormatException,
      );
    });
  });
}
