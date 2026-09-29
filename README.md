# Chord Progression Notes for Mac

macOS build files for **Chord Progression Notes**, a desktop chord progression and lyrics editor with lead-sheet preview.

This repository contains a macOS build script for creating the macOS installer/package from the Chord Progression Notes source.

## Important

This repository does **not** contain a ready-to-install macOS application.

You must first run the included build script on a Mac to generate the macOS installer/package.

After the build is complete, install Chord Progression Notes from the generated `.dmg` or `.zip` package.

## Requirements

To build the macOS version, you need:

- macOS
- Node.js
- npm
- Internet connection for downloading build dependencies
- Several GB of free disk space

Node.js is required only for building the application.

You can download Node.js from:

https://nodejs.org/

If Homebrew is already installed, the build script may also attempt to install Node.js automatically.

## Build Instructions

1. Download this repository or the `.command` build file.

2. Open Terminal.

3. If necessary, make the build file executable:

```bash
chmod +x BUILD_Chord_Progression_Notes_v1.1.7_mac.command
```

4. Run the build script:

```bash
./BUILD_Chord_Progression_Notes_v1.1.7_mac.command
```

Alternatively, you may be able to run the `.command` file directly from Finder.

If macOS blocks the file, right-click the file and choose **Open**.

## Build Process

The build script will:

- Check the macOS environment
- Check for Node.js and npm
- Extract the embedded Chord Progression Notes source
- Install the required npm dependencies
- Run electron-builder
- Build macOS packages
- Copy the generated files to the Desktop

The build is intended to generate packages for:

- Intel Mac (`x64`)
- Apple Silicon Mac (`arm64`)

Expected output files include:

```text
Chord-Progression-Notes-1.1.7-x64.dmg
Chord-Progression-Notes-1.1.7-arm64.dmg
Chord-Progression-Notes-1.1.7-x64.zip
Chord-Progression-Notes-1.1.7-arm64.zip
```

## Installation

After the build finishes:

1. Open the generated `.dmg` file.
2. Install or copy **Chord Progression Notes** to your Applications folder.
3. Launch the application from the Applications folder.

For the ZIP version:

1. Extract the ZIP file.
2. Move the application to the Applications folder.
3. Launch the application.

## Gatekeeper / Security Warning

The generated macOS application is currently not signed or notarized with an Apple Developer ID.

Because of this, macOS Gatekeeper may display a security warning when opening the application.

Depending on your macOS version, you may need to:

1. Right-click the application.
2. Select **Open**.
3. Confirm that you want to open the application.

For normal public macOS distribution, Apple Developer ID signing and notarization are recommended.

## Testing Status

**The macOS version has not yet been tested on actual Mac hardware.**

The macOS build script was created based on the existing Windows/Electron project structure, but the developer currently does not have access to a physical Mac for verification.

Therefore:

- Successful compilation on all Mac environments is not guaranteed.
- Intel Mac compatibility has not been verified on real hardware.
- Apple Silicon compatibility has not been verified on real hardware.
- Application behavior after installation has not yet been fully tested.
- Gatekeeper behavior may differ depending on the macOS version and security settings.

Testing reports, bug reports, and pull requests from Mac users are welcome.

## Supported Architectures

The build configuration currently targets:

- Intel Mac — `x64`
- Apple Silicon — `arm64`

Apple Silicon includes Macs using Apple M-series processors.

## About Chord Progression Notes

Chord Progression Notes is a desktop application for writing and previewing chord progressions together with lyrics.

Supported formats include:

- ChordPro
- Chord Over Lyrics
- MusicXML
- ABC notation

The application provides a lead-sheet style preview for chord and lyric data.

## Windows Version

The Windows version is available here:

https://github.com/yoh-nak/Chord-Progression-Notes-for-Windows

## Related Project

Max for Live version:

https://github.com/yoh-nak

## Author

Yohsuke Nakano

GitHub:

https://github.com/yoh-nak

## Disclaimer

This macOS build is currently experimental.

Please understand that the macOS version has not yet been verified on physical Mac hardware before using or distributing the generated application.
