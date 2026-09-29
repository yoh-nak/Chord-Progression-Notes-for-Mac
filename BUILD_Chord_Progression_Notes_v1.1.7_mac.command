#!/bin/bash
set -u

APP_NAME="Chord Progression Notes"
VERSION="1.1.7"
BUILD_BASE="$(cd "$(dirname "$0")" && pwd)"
WORK="$BUILD_BASE/ChordProgressionNotes_v1_1_7_mac_build"
B64="$WORK/source.b64"
ZIP="$WORK/source.zip"
SRC="$WORK/src/ChordProgressionNotesDesktop"
OUT="$HOME/Desktop"

echo
echo "============================================================"
echo "$APP_NAME v$VERSION - macOS Builder"
echo "Script folder : $BUILD_BASE"
echo "Work folder   : $WORK"
echo "Output folder : $OUT"
echo "============================================================"
echo

# macOS only
if [ "$(uname -s)" != "Darwin" ]; then
  echo "ERROR: This builder must be run on macOS."
  echo "Copy this .command file to a Mac and run it there."
  echo
  read -r -p "Press Enter to close..." _
  exit 1
fi

# Require roughly 5 GB free in the script's volume.
FREE_KB="$(df -Pk "$BUILD_BASE" | awk 'NR==2 {print $4}')"
if [ -z "$FREE_KB" ]; then
  echo "ERROR: Could not determine free disk space."
  read -r -p "Press Enter to close..." _
  exit 1
fi

FREE_GB=$((FREE_KB / 1024 / 1024))
echo "Free space: approximately $FREE_GB GB"
if [ "$FREE_KB" -lt 5242880 ]; then
  echo
  echo "ERROR: At least 5 GB free space is required."
  echo "Move this file to a disk with more free space and run it again."
  read -r -p "Press Enter to close..." _
  exit 1
fi

rm -rf "$WORK"
mkdir -p "$WORK" "$OUT" || {
  echo "ERROR: Could not create build folders."
  read -r -p "Press Enter to close..." _
  exit 1
}

export npm_config_cache="$WORK/npm-cache"
export ELECTRON_CACHE="$WORK/electron-cache"
export ELECTRON_BUILDER_CACHE="$WORK/electron-builder-cache"
export TMPDIR="$WORK/temp"
mkdir -p "$TMPDIR"

if ! command -v node >/dev/null 2>&1; then
  echo
  echo "Node.js LTS is required only to BUILD the macOS app."
  if command -v brew >/dev/null 2>&1; then
    echo "Homebrew was found. Installing Node.js..."
    brew install node || {
      echo "ERROR: Node.js installation failed."
      read -r -p "Press Enter to close..." _
      exit 1
    }
  else
    echo "ERROR: Node.js was not found."
    echo "Install Node.js LTS from https://nodejs.org/ and run this file again."
    echo "If macOS blocks this file, right-click it and choose Open."
    read -r -p "Press Enter to close..." _
    exit 1
  fi
fi

echo
echo "Node.js: $(node --version)"
echo "npm    : $(npm --version)"
echo

cat > "$B64" <<'CPN_SOURCE_BASE64'
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
iakWfxlTIDYHC4BMiZP/jxhSGVJK8Fb97Ua1iUQ2uI1E0mvp9BqVzGyqVRXuoy5k8lnDUbZcwi++
aQzPG0xhxRXifQEea5SddYZyKZNnagA3WVQkPyEeSjTCaIikcvCxbC9xv77QH8eTwMNcB+gS6BVH
yrQcNUkSqCrdkuG5g4GJiDOW+AMvS4guluD4L0UgscQfiA304sthEoE3UPhlVDM+9L79h8ja5tNS
Vkkdt8ByRKVg4/RKtODSjSXc+6XPm2RMzs9iXhbNkZPGswxs3CiNQ5jLqY/yHIExndkLQAxGlY7G
zwqm4xJLPxXL7FPh72wSXW6squK7SbUEmTdiW1OEmzCRDSjoXo+Egy7rm4R/07yEdnr5DFdy5kYU
HY02dMQSBD9tTyse8B+2+adiD9vsI+9t+n9z/V9QSwECFAMUAAAACABiLj1d3n88j64AAAAMAQAA
LgAAAAAAAAAAAAAApIEAAAAAQ2hvcmRQcm9ncmVzc2lvbk5vdGVzRGVza3RvcC9idWlsZC13aW5k
b3dzLmJhdFBLAQIUAxQAAAAIAGIuPV2I16yh6AAAAF8BAAAxAAAAAAAAAAAAAACkgfoAAABDaG9y
ZFByb2dyZXNzaW9uTm90ZXNEZXNrdG9wL2J1aWxkLXN0b3JlLWFwcHguYmF0UEsBAhQDFAAAAAgA
dC49XckuYk64AgAAOAcAACkAAAAAAAAAAAAAAKSBMQIAAENob3JkUHJvZ3Jlc3Npb25Ob3Rlc0Rl
c2t0b3AvcGFja2FnZS5qc29uUEsBAhQDFAAAAAgAdC49XYEMjKicCAAAHhIAACoAAAAAAAAAAAAA
AKSBMAUAAENob3JkUHJvZ3Jlc3Npb25Ob3Rlc0Rlc2t0b3AvUkVBRE1FX0pBLnR4dFBLAQIUAxQA
AAAIAGIuPV1Rf68IaQEAAGMDAAArAAAAAAAAAAAAAACkgRQOAABDaG9yZFByb2dyZXNzaW9uTm90
ZXNEZXNrdG9wL3NyYy9wcmVsb2FkLmpzUEsBAhQDFAAAAAgAYi49XbJCxTUqCAAA3BgAACgAAAAA
AAAAAAAAAKSBxg8AAENob3JkUHJvZ3Jlc3Npb25Ob3Rlc0Rlc2t0b3Avc3JjL21haW4uanNQSwEC
FAMUAAAACAB0Lj1dUWA5jUslAACxawAAKwAAAAAAAAAAAAAApIE2GAAAQ2hvcmRQcm9ncmVzc2lv
bk5vdGVzRGVza3RvcC9zcmMvaW5kZXguaHRtbFBLBQYAAAAABwAHAHICAADKPQAAAAA=
CPN_SOURCE_BASE64

# macOS base64 uses -D for decode.
tr -d '\r\n ' < "$B64" | /usr/bin/base64 -D > "$ZIP"
if [ $? -ne 0 ]; then
  echo "ERROR: Could not decode embedded source archive."
  read -r -p "Press Enter to close..." _
  exit 1
fi

mkdir -p "$WORK/src"
ditto -x -k "$ZIP" "$WORK/src"
if [ $? -ne 0 ] || [ ! -d "$SRC" ]; then
  echo "ERROR: Could not extract embedded source archive."
  read -r -p "Press Enter to close..." _
  exit 1
fi

cd "$SRC" || exit 1

# Add macOS build settings without changing the application source code.
node <<'NODE_PATCH'
const fs = require('fs');
const p = 'package.json';
const j = JSON.parse(fs.readFileSync(p, 'utf8'));

j.scripts = j.scripts || {};
j.scripts['dist:mac'] = 'electron-builder --mac dmg zip --x64 --arm64';

j.build = j.build || {};
j.build.mac = {
  target: [
    { target: 'dmg', arch: ['x64', 'arm64'] },
    { target: 'zip', arch: ['x64', 'arm64'] }
  ],
  category: 'public.app-category.music',
  artifactName: 'Chord-Progression-Notes-${version}-${arch}.${ext}'
};

fs.writeFileSync(p, JSON.stringify(j, null, 2) + '\n');
NODE_PATCH

if [ $? -ne 0 ]; then
  echo "ERROR: Could not prepare package.json for macOS."
  read -r -p "Press Enter to close..." _
  exit 1
fi

echo
echo "Installing build dependencies..."
npm install
if [ $? -ne 0 ]; then
  echo
  echo "============================================================"
  echo "BUILD FAILED during npm install."
  echo "Temporary files were left here:"
  echo "$WORK"
  echo "============================================================"
  read -r -p "Press Enter to close..." _
  exit 1
fi

echo
echo "Building macOS packages for Intel (x64) and Apple Silicon (arm64)..."
npm run dist:mac
if [ $? -ne 0 ]; then
  echo
  echo "============================================================"
  echo "BUILD FAILED during electron-builder."
  echo "Temporary files were left here:"
  echo "$WORK"
  echo "============================================================"
  read -r -p "Press Enter to close..." _
  exit 1
fi

FOUND=0
for FILE in dist/Chord-Progression-Notes-1.1.7-x64.dmg \
            dist/Chord-Progression-Notes-1.1.7-arm64.dmg \
            dist/Chord-Progression-Notes-1.1.7-x64.zip \
            dist/Chord-Progression-Notes-1.1.7-arm64.zip; do
  if [ -f "$FILE" ]; then
    cp -f "$FILE" "$OUT/"
    FOUND=1
  fi
done

if [ "$FOUND" -ne 1 ]; then
  echo
  echo "ERROR: Build completed but expected output files were not found."
  echo "Check: $SRC/dist"
  read -r -p "Press Enter to close..." _
  exit 1
fi

echo
echo "============================================================"
echo "SUCCESS"
echo "macOS packages were copied to:"
echo "$OUT"
echo
echo "Expected files:"
echo "  Chord-Progression-Notes-1.1.7-x64.dmg"
echo "  Chord-Progression-Notes-1.1.7-arm64.dmg"
echo "  Chord-Progression-Notes-1.1.7-x64.zip"
echo "  Chord-Progression-Notes-1.1.7-arm64.zip"
echo
echo "x64   = Intel Mac"
echo "arm64 = Apple Silicon (M1/M2/M3/M4/M5...)"
echo
echo "NOTE:"
echo "This script builds the app, but public distribution on macOS normally"
echo "requires Apple Developer ID signing and notarization to avoid Gatekeeper warnings."
echo "============================================================"
echo

rm -rf "$WORK"

read -r -p "Press Enter to close..." _
exit 0
