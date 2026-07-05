#!/bin/bash
set -e

ISAR_BUILD="$HOME/.pub-cache/hosted/pub.dev/isar_flutter_libs-3.1.0+1/android/build.gradle"

echo "===== PATCHING ISAR ANDROID CONFIG ====="

cp "$ISAR_BUILD" "${ISAR_BUILD}.bak"

sed -i '' 's/compileSdkVersion 30/compileSdkVersion 36/g' "$ISAR_BUILD"
sed -i '' 's/minSdkVersion 16/minSdkVersion 21/g' "$ISAR_BUILD"
sed -i '' 's/targetSdkVersion 30/targetSdkVersion 36/g' "$ISAR_BUILD"

echo
echo "===== VERIFY ====="
grep -n "compileSdkVersion" "$ISAR_BUILD"
grep -n "targetSdkVersion" "$ISAR_BUILD"
grep -n "minSdkVersion" "$ISAR_BUILD"
grep -n "namespace" "$ISAR_BUILD"

echo
echo "===== ANALYZE ====="
fvm flutter analyze

echo
echo "===== TEST ====="
fvm flutter test

echo
echo "===== BUILD ====="
fvm flutter build apk --release
