#!/bin/bash

set -e

echo "======================================="
echo " LifeCircle OS Workspace Fix"
echo "======================================="

cd "/Users/krishnatiwari/Life Circle OS"

echo ""
echo "1. Stopping stale Flutter locks..."
pkill -f dart || true
pkill -f flutter || true

echo ""
echo "2. Cleaning workspace artifacts..."
find . -name "pubspec.lock" -delete
find . -name ".dart_tool" -type d -prune -exec rm -rf {} +
find . -name "build" -type d -prune -exec rm -rf {} +

echo ""
echo "3. Updating melos version..."
sed -i '' 's/melos: \^8\.1\.0/melos: ^7.0.0/g' pubspec.yaml || true

echo ""
echo "4. Updating Riverpod lint versions..."
find . -name "pubspec.yaml" -exec \
sed -i '' 's/riverpod_lint: \^2\.3\.10/riverpod_lint: ^2.6.3/g' {} \;

echo ""
echo "5. Adding custom_lint if missing..."
grep -q "custom_lint:" apps/mobile/pubspec.yaml \
|| sed -i '' '/riverpod_lint:/a\
  custom_lint: ^0.7.0
' apps/mobile/pubspec.yaml

echo ""
echo "6. Repairing Flutter cache (this may take several minutes)..."
flutter pub cache repair

echo ""
echo "7. Installing root dependencies..."
flutter pub get

echo ""
echo "8. Installing Melos locally..."
dart pub get

echo ""
echo "9. Bootstrapping workspace..."
dart run melos bootstrap

echo ""
echo "10. Running analyzer..."
dart run melos run analyze

echo ""
echo "11. Running tests..."
dart run melos run test

echo ""
echo "======================================="
echo "ALL DONE"
echo "======================================="
