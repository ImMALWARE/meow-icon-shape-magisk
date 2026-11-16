#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
OUT=${1:-${OUT_APK:-$ROOT/dist/MeowIconShapeOverlay.apk}}
BUILD=$ROOT/build/apk
SDK=${ANDROID_HOME:-${ANDROID_SDK_ROOT:-/usr/local/lib/android/sdk}}
BT=$(find "$SDK/build-tools" -mindepth 1 -maxdepth 1 -type d | sort -V | tail -n1)
JAR=$(find "$SDK/platforms" -mindepth 2 -maxdepth 2 -name android.jar | sort -V | tail -n1)

rm -rf "$BUILD"
mkdir -p "$BUILD/res" "$(dirname "$OUT")"

"$BT/aapt2" compile --dir "$ROOT/src/main/res" -o "$BUILD/res"
"$BT/aapt2" link -I "$JAR" --manifest "$ROOT/src/main/AndroidManifest.xml" \
  --auto-add-overlay -o "$BUILD/unaligned.apk" "$BUILD"/res/*.flat
"$BT/zipalign" -p -f 4 "$BUILD/unaligned.apk" "$BUILD/aligned.apk"
"$BT/apksigner" sign --ks "$KEYSTORE" --ks-pass env:KEYSTORE_PASS \
  --min-sdk-version 29 --out "$OUT" "$BUILD/aligned.apk"
"$BT/apksigner" verify "$OUT"
