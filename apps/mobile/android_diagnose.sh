#!/bin/bash

set +e

cd "/Users/krishnatiwari/Life Circle OS/apps/mobile" || exit 1

OUTPUT_FILE="android_diagnosis.txt"
rm -f "$OUTPUT_FILE"

echo "========================================" | tee -a "$OUTPUT_FILE"
echo "LIFECIRCLE OS - ANDROID DIAGNOSTICS" | tee -a "$OUTPUT_FILE"
echo "========================================" | tee -a "$OUTPUT_FILE"

echo -e "\n===== GIT STATUS =====" | tee -a "$OUTPUT_FILE"
git status >> "$OUTPUT_FILE" 2>&1

echo -e "\n===== ANDROID MANIFEST FILES =====" | tee -a "$OUTPUT_FILE"
find android -name "AndroidManifest.xml" >> "$OUTPUT_FILE" 2>&1

echo -e "\n===== MAIN SOURCE FILES =====" | tee -a "$OUTPUT_FILE"
find android/app/src/main -type f >> "$OUTPUT_FILE" 2>&1

echo -e "\n===== MAIN DIRECTORY TREE =====" | tee -a "$OUTPUT_FILE"
ls -R android/app/src/main >> "$OUTPUT_FILE" 2>&1

echo -e "\n===== V1 EMBEDDING PATTERNS =====" | tee -a "$OUTPUT_FILE"
grep -R -n -E \
'io\.flutter\.app|PluginRegistry\.Registrar|registerWith|FlutterApplication|flutterEmbedding|flutterEmbedding="1"' \
android >> "$OUTPUT_FILE" 2>&1 || true

echo -e "\n===== ALL registerWith REFERENCES =====" | tee -a "$OUTPUT_FILE"
grep -R -n "registerWith" . >> "$OUTPUT_FILE" 2>&1 || true

echo -e "\n===== FLUTTER checkForDeprecation() =====" | tee -a "$OUTPUT_FILE"
sed -n '940,1040p' \
"$HOME/fvm/versions/3.44.4/packages/flutter_tools/lib/src/project.dart" \
>> "$OUTPUT_FILE" 2>&1

echo -e "\n===== BUILD VERBOSE =====" | tee -a "$OUTPUT_FILE"
fvm flutter build apk --release -v >> "$OUTPUT_FILE" 2>&1 || true

echo
echo "========================================"
echo "Diagnostics complete."
echo "Output file:"
echo "$(pwd)/android_diagnosis.txt"
echo "========================================"
