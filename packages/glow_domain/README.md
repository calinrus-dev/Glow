# glow_domain

Domain layer with entities and business rules for Glow Social Operating System.

## Description

This package contains the **core business logic** for Glow's content architecture:

### Entities
- **Global**: User profiles, global entries, global chats (DMs, groups)
- **Spaces**: Immersive communities with unique identity
- **Channels**: Composite areas (text chat + voice + entries) within Spaces
- **Entries**: Block-based content (NOT posts) - exists in Global, Channels, and user contexts
- **Identity**: Multi-layered identity system (Global profile, Space identity, Channel masks)
- **Chat**: Text messages, voice messages, DMs, group chats

### Business Rules
- Content visibility policies
- Identity and permission rules
- Space and channel governance
- Entry creation and validation

**Dependencies**: Only depends on `glow_core` for base types.

## Architecture Rules

- ✅ Pure Dart only (no Flutter imports)
- ✅ No dependencies on data or presentation layers
- ✅ Contains only business logic
- ✅ Entities are immutable (using Freezed)
- ✅ Use Value Objects for domain constraints
- ❌ NEVER import from data or presentation layers
