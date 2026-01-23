# glow_auth

Authentication and session management for Glow.

## Overview

Handles authentication flows, session persistence, and token management across Glow's multi-layered identity system:
- Global authentication (main account)
- Space-level identity (per-Space profiles)
- Channel masks (per-channel customization)

## Features

### **Session Management**
- Session creation and persistence
- Automatic token refresh
- Multi-device session handling
- Session invalidation

### **Security**
- Password hashing (bcrypt/argon2)
- Token validation (JWT)
- Secure storage integration
- OAuth provider support (Google, GitHub, etc.)

### **Identity Context**
- Global identity tracking
- Space-specific identity switching
- Channel mask application

**Note:** Pure Dart package (no Flutter dependencies).

## Dependencies

- `glow_core` - Base types
- `crypto` - Cryptographic operations
- `jwt_decoder` - JWT handling

## Usage

```dart
import 'package:glow_auth/glow_auth.dart';

// Authenticate
final session = await authService.signIn(
  email: 'user@example.com',
  password: 'password',
);

// Get current identity context
final identity = authService.getCurrentIdentity();
```
