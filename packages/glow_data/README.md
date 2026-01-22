# glow_data

Data layer with repositories, datasources, and models for Glow.

## Description

This package contains:
- **Remote Datasources**: API clients for Supabase
- **Local Datasources**: Isar database clients
- **Sync**: Offline-first synchronization logic
- **Repositories**: Implementation of domain repository contracts
- **Models**: DTOs and data models

**Dependencies**: Depends on `glow_core` and `glow_domain`.

## Architecture Rules

- Pure Dart only (no Flutter imports)
- Implements repository contracts from domain
- Handles data mapping between DTOs and entities
- Manages offline-first sync
