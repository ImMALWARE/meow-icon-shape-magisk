#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "$0")/.." && pwd)
APK=${1:-$ROOT/dist/MeowIconShapeOverlay.apk}
OUT=${2:-$ROOT/dist/meow-icon-shape-magisk.zip}
STAGE=$ROOT/build/module-stage

rm -rf "$STAGE" "$OUT"
mkdir -p "$STAGE/system/product/overlay" "$(dirname "$OUT")"
OUT="$(cd "$(dirname "$OUT")" && pwd)/$(basename "$OUT")"

cp -a "$ROOT"/module/. "$STAGE/"
cp "$APK" "$STAGE/system/product/overlay/MeowIconShapeOverlay.apk"

(cd "$STAGE" && zip -r9q "$OUT" .)
unzip -tq "$OUT"
