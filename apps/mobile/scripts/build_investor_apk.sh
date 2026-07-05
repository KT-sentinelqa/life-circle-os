#!/bin/bash

# LifeCircle OS - Investor APK Build Script
# This script compiles a release APK meant for distribution to investors and demo devices.

set -e

echo "🚀 Starting LifeCircle OS Investor Build..."

# 1. Clean the workspace
echo "🧹 Cleaning workspace..."
fvm flutter clean

# 2. Get dependencies
echo "📦 Fetching dependencies..."
fvm flutter pub get

# 3. Generate code (Isar, Riverpod, etc)
echo "⚙️ Generating Isar & Riverpod files..."
fvm dart run build_runner build -d

# 4. Verify quality gates before building
echo "🛡️ Verifying Quality Gates..."
fvm flutter analyze
fvm flutter test

# 5. Build the APK
echo "🏗️ Building Release APK..."
fvm flutter build apk --release

echo "✅ Build Complete!"
echo "📂 The APK is located at: build/app/outputs/flutter-apk/app-release.apk"
