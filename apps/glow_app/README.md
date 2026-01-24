# glow_app

Main Flutter application for Glow Social Operating System.

## Overview

Glow is a platform for creating immersive digital **Spaces** with identity. This app is the primary client for:

- Browsing the **Global** feed
- Joining and exploring **Spaces** (immersive communities)
- Navigating **Channels** (composite areas within Spaces)
- Creating **Entries** (block-based content, NOT posts)
- Managing multi-layered identity (Global profile, Space identity, Channel masks)

## Content Architecture

### **Global**

Top-level feed and social layer:

- Global feed (For You, Popular, Recent, Featured)
- Global chats (DMs, groups)
- User entries + Space entries

### **Spaces**

Immersive communities with unique identity:

- Channels (composite: text chat + voice + entries)
- Space chats (DMs, private groups)
- Space-specific identity

### **Channels**

Composite immersive areas containing:

- Text chat
- Voice chat
- Entries (block-based content)
- Channel masks (per-channel identity)

### **Entries**

Block-based content (NOT posts):

- In Global feed
- In Channels
- Created by users or Space staff

## Requirements

- Flutter 3.19+
- Dart 3.3+
- Melos (`dart pub global activate melos`)

## Setup

```bash
# From the repo root
melos bootstrap

# Run code generation
cd apps/glow_app
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## Terminology (STRICT)

✅ **Use**: Global, Spaces, Channels, Entries, Masks
❌ **NEVER**: posts, servers, communities (for Spaces), groups (for Spaces)

## Useful Commands

```bash
# Analyze
melos run analyze

# Tests
melos run test

# Format
melos run format

# Code generation
cd apps/glow_app
dart run build_runner build --delete-conflicting-outputs
```

## Architecture

Follows **Clean Architecture** with strict layer separation:

- Domain layer: Business logic (pure Dart)
- Data layer: Repositories, data sources (pure Dart)
- Presentation layer: UI, state management (Flutter)

See `docs/ARCHITECTURE.md` for details.
