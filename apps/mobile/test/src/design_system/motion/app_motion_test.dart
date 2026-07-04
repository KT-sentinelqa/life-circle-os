import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/motion/app_motion.dart';

void main() {
  group('AppMotion Tests', () {
    test('Motion constants have exact duration and curve values', () {
      expect(AppMotion.fast, const Duration(milliseconds: 150));
      expect(AppMotion.normal, const Duration(milliseconds: 250));
      expect(AppMotion.slow, const Duration(milliseconds: 350));
      expect(AppMotion.standard, Curves.easeInOutCubic);
      expect(AppMotion.decelerate, Curves.easeOutCubic);
      expect(AppMotion.accelerate, Curves.easeInCubic);
    });
  });
}
