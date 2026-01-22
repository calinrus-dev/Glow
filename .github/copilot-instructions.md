# Copilot Instructions for Glow

## Project Context
Glow: Social platform for creating immersive digital spaces with identity. Not a traditional social network.

## Terminology (STRICT)
- **Entornos** (Spaces) - Communities within Glow
- **Canales** (Channels) - Functional areas within Entornos
- **Lienzos** (Canvases) - Content creation spaces (NOT "posts")

NEVER use: "posts", "groups", "servers", "communities" (use Entornos instead)

## Architecture
- **Clean Architecture** - Strict layer separation
- **Dependency Rule** - Dependencies point inward
- **Packages:** core, domain, data, api, auth, realtime, blocks_engine, blocks_flutter, observability, ui

## Stack
```yaml
Framework: Flutter 3.19+
State: Riverpod + Freezed
Backend: Supabase
HTTP: Dio
Navigation: GoRouter
Monorepo: Melos
```

## Code Style
- Use `Either<Failure, T>` for operations
- Riverpod providers with code generation
- Freezed for immutable models
- Repository pattern for data access
- Use cases for business logic

## Naming Conventions
```dart
// Features
lib/features/{feature}/
  - data/
  - domain/
  - presentation/

// Files
{name}_repository.dart
{name}_use_case.dart
{name}_provider.dart
{name}_state.dart
```

## DO
- Follow SOLID principles
- Write unit tests
- Use Conventional Commits
- Respect layer boundaries
- Keep TODOs with issue references

## DON'T
- Mix presentation with business logic
- Skip tests for critical flows
- Use magic numbers/strings
- Create God objects
- Break dependency rule

## Aesthetic
Dark, glow/neon, atmospheric, immersive. Code should reflect quality and care.

## License
Proprietary. Not open source.
