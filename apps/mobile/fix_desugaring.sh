#!/bin/bash
set -e

APP_BUILD="android/app/build.gradle.kts"

echo "===== BACKUP ====="
cp "$APP_BUILD" "${APP_BUILD}.bak"

echo "===== ADD DESUGARING DEPENDENCY ====="

if ! grep -q "desugar_jdk_libs" "$APP_BUILD"; then
  python3 <<'PY'
from pathlib import Path

p = Path("android/app/build.gradle.kts")
text = p.read_text()

dependency = '''
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
'''

if "coreLibraryDesugaring" not in text:
    text += "\n" + dependency + "\n"

if "isCoreLibraryDesugaringEnabled = true" not in text:
    text = text.replace(
        "compileOptions {",
        """compileOptions {
        isCoreLibraryDesugaringEnabled = true"""
    )

p.write_text(text)
PY
fi

echo
echo "===== VERIFY ====="
grep -n "isCoreLibraryDesugaringEnabled" "$APP_BUILD"
grep -n "desugar_jdk_libs" "$APP_BUILD"

echo
echo "===== ANALYZE ====="
fvm flutter analyze

echo
echo "===== TEST ====="
fvm flutter test

echo
echo "===== BUILD ====="
fvm flutter build apk --release
