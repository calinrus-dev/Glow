# glow_data

Data layer with repositories, datasources, and models for Glow.

## Description

This package implements the **data access layer** for Glow's content architecture:

### Data Sources
- **Remote Datasources**: Supabase API clients for:
  - Spaces (communities)
  - Entries (block-based content, NOT posts)
  - Channels (composite immersive areas)
  - Chats (global DMs/groups, Space DMs/groups)
  - Identity (global profiles, Space identities, channel masks)
  
- **Local Datasources**: Isar database clients for offline-first storage

### Repositories
Implementations of domain repository contracts:
- `SpacesRepository` - Manage Spaces (was "worlds")
- `EntriesRepository` - Manage Entries (was "posts")
- `ChannelsRepository` - Manage composite Channels
- `ChatsRepository` - Global and Space-level messaging
- `IdentityRepository` - Multi-layered identity system

### Sync & Offline
- Offline-first synchronization
- Conflict resolution
- Sync queue management

**Dependencies**: Depends on `glow_core` and `glow_domain`.

## Architecture Rules

- ✅ Pure Dart only (NO Flutter imports - use `supabase` not `supabase_flutter`)
- ✅ Implements repository contracts from domain
- ✅ DTOs ↔ Entity mapping via mappers
- ✅ Offline-first with sync manager
- ❌ NEVER use Flutter dependencies
- ❌ NEVER skip repository abstraction
