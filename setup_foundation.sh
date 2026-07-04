#!/bin/bash
set -e

echo "Starting Sprint 1 Foundation Setup..."

cd "apps/mobile"

echo "1. Removing VGV boilerplate counter app and tests..."
rm -rf lib/app
rm -rf lib/counter
rm -rf test/app
rm -rf test/counter

echo "2. Installing dependencies via Melos..."
cd ../..
fvm dart run melos bootstrap

echo "3. Generating Riverpod, Freezed, and Isar files..."
cd apps/mobile
fvm dart run build_runner build -d

echo "Sprint 1 Foundation scaffolded successfully!"
echo "Run 'fvm flutter run --flavor development --target lib/main_development.dart -d macos' to verify."
