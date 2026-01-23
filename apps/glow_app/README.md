# glow_app

Main Flutter application for Glow.

Glow is a platform for creating immersive digital Spaces with identity. This app is the primary client for browsing Spaces, navigating Channels, and creating Entries in Canvases.

## Requirements

- Flutter 3.19+
- Dart 3.3+
- Melos (`dart pub global activate melos`)

## Setup

```bash
# From the repo root
melos bootstrap

# Run the app
cd apps/glow_app
flutter run
```

## Key Concepts

- **Spaces**: Main communities within Glow
- **Channels**: Functional areas within a Space
- **Canvases**: Creation surfaces where Entries are built
- **Entries**: Content units created inside Canvases

## Useful Commands

```bash
# Analyze
melos run analyze

# Tests
melos run test

# Format
melos run format
```
