import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/radius/app_radius.dart';

void main() {
  group('AppRadius Tests', () {
    test('Radius constants have exact pixel values', () {
      expect(AppRadius.sm, const BorderRadius.all(Radius.circular(4)));
      expect(AppRadius.md, const BorderRadius.all(Radius.circular(8)));
      expect(AppRadius.lg, const BorderRadius.all(Radius.circular(16)));
      expect(AppRadius.xl, const BorderRadius.all(Radius.circular(24)));
      expect(AppRadius.pill, const BorderRadius.all(Radius.circular(9999)));
    });
  });
}
