# glow_api

API client and DTOs for communication with backend services.

## Overview

Provides HTTP client infrastructure and data transfer objects for Glow's backend communication.

## Features

### **Client**
- HTTP client wrapper with authentication interceptors
- Automatic token refresh
- Error handling and retry logic

### **DTOs**
Data transfer objects for API requests/responses:
- `SpaceDTO` - Space data from API
- `EntryDTO` - Entry (NOT post) data from API
- `ChannelDTO` - Channel data from API
- `UserDTO` - User profile data

**Note:** Pure Dart package (no Flutter dependencies).

## Dependencies

- `dio` - HTTP client
- `glow_core` - Base types and contracts

## Usage

```dart
import 'package:glow_api/glow_api.dart';

final client = ApiClient(
  baseUrl: 'https://api.glow.app',
  authInterceptor: AuthInterceptor(),
);

final spaces = await client.get<List<SpaceDTO>>('/spaces');
```
