import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/network/config/environment.dart';

void main() {
  test('Environment returns correct file names', () {
    expect(Environment.dev.fileName, '.env.dev');
    expect(Environment.staging.fileName, '.env.staging');
    expect(Environment.prod.fileName, '.env.prod');
  });
}
