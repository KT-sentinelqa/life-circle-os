import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';

void main() {
  test('appClockProvider provides SystemClock by default', () {
    final container = ProviderContainer();
    final clock = container.read(appClockProvider);
    expect(clock, isA<SystemClock>());
  });
}
