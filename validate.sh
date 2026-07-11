#!/bin/bash
set -e

echo "Current Directory:"
pwd

cd apps/mobile

flutter doctor -v
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze || true
flutter test
flutter devices
flutter run
