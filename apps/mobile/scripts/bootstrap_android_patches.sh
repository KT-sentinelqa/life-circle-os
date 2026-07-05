#!/bin/bash
# Scripts to bootstrap deterministic patches for the Android build

echo "Applying Isar namespace patch for AGP 8+..."
sed -i '' '/android {/a\
    namespace "dev.isar.isar_flutter_libs"
' ~/.pub-cache/hosted/pub.dev/isar_flutter_libs-3.1.0+1/android/build.gradle || echo "Isar namespace patch failed or already applied"

echo "Applying Isar compileSdkVersion 36 patch..."
sed -i '' 's/compileSdkVersion 30/compileSdkVersion 36/' ~/.pub-cache/hosted/pub.dev/isar_flutter_libs-3.1.0+1/android/build.gradle || echo "Isar compileSdkVersion patch failed or already applied"

echo "Android patches applied."
