# glow_domain

Domain layer with entities and business rules for Glow Social Operating System.

## Description

This package contains:
- **Entities**: All domain entities (User, World, Channel, Post, etc.)
- **Policies**: Business rules and domain policies

**Dependencies**: Only depends on `glow_core` for base types.

## Architecture Rules

- Pure Dart only (no Flutter imports)
- No dependencies on data or presentation layers
- Contains only business logic
- Entities are immutable
