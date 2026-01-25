# Copilot Instructions for Glow

> **Communities are worlds. Content is architecture. UI is alive.**

---

## Language Policy (CRITICAL)

**ALL code, comments, UI strings, variable names, documentation, and technical content MUST be in ENGLISH.**

- ✅ Code comments: English only
- ✅ Variable/function names: English only
- ✅ UI strings: English only (even if user speaks Spanish)
- ✅ Git commit messages: English only
- ✅ Technical documentation: English only
- ✅ Error messages: English only

**Exception**: You may respond to the user in Spanish if they communicate in Spanish, BUT the code/product remains in English.

**Example**:

```dart
// ✅ CORRECT
final String userName = 'John Doe';
// Get user profile from cache
final profile = await repository.getUserProfile();

// ❌ WRONG
final String nombreUsuario = 'John Doe';
// Obtener perfil de usuario del caché
final perfil = await repositorio.obtenerPerfilUsuario();
```

---

## Project Context

**Glow** is a next-generation social platform for creating immersive digital worlds with identity, context, and living visual systems. NOT a traditional social network.

**Core Concept**: Glow is a system of immersive digital places where communities are worlds, content is architecture, and UI is alive.

**Current Stage**: MVP development - Core UI and routing complete, offline-first storage (Isar) integrated, ready for Supabase backend integration and sync implementation.

---

## Content Architecture (CRITICAL - READ FIRST)

### Conceptual Model

**Glow is NOT a classic social network.**
It is a **system of digital places with identity, context, and layers**.
The central axis is not profiles or posts, but **where you are**.

### Global Level (Top Layer)

**Global** is the top layer of Glow. It always exists.

**What Global Is:**

- Entry point to the app
- Neutral context
- User's base identity

**What Global Contains:**

**Global Feed** - Entry feed with multiple views:

- **For You** → personalized recommendations
- **Popular** → trends across all Spaces
- **Recent** → chronological
- **Featured** → editorial curation

**Entry Sources**:

- Individual users
- Spaces (staff or featured publications)

**Global Chats** - Chats outside any Space:

- **DMs** (1-on-1) - No Space aesthetics
- **Group Chats** - Private, don't inherit Space rules or identities

**Global Profile** - User's root identity:

- Primary username
- Global avatar
- Global bio
- General settings
- Privacy preferences
- **The identity that always exists and is used when there's no context**

### Spaces (Environments / Places)

**A Space is a world unit within Glow.**

❌ NOT a group
❌ NOT a server
❌ NOT a simple container
✅ **An immersive environment with its own rules**

**What Defines a Space:**

- Own visual theme (colors, atmosphere)
- Internal norms
- Culture
- Channels
- Roles
- Governance

**Examples:**

- MotoGP Space
- Indie Cinema Space
- Open Source Dev Space

**What a Space Contains:**

**Space Identity** (Identity per Space):

- Each user has a **different identity per Space**:
  - Different display name
  - Different avatar
  - Different bio
  - Different visibility
- 👉 Prevents context collapse
- 👉 You can be professional in one Space and casual in another

**Space Chats** - Chats within the Space context:

- DMs between Space members
- Private Group Chats within the Space
- ⚠️ Follow Space rules
- ⚠️ Use Space identity, not global

**Channels** - Immersive areas within the Space (see below)

### Channels (Areas Within a Space)

**A Channel is a composite zone, not just a chat.**

A Channel can have **simultaneously**:

- 💬 **Real-time Chat** - Instant messaging
- 🎙️ **Voice** - Audio communication
- 🧱 **Persistent Entries** - Durable content
- 🎭 **Masks** - Channel-specific identity

👉 **NOT "chat rooms"**
👉 **Hybrid living spaces**

**Channel Mask** (Identity per Channel) - Finest identity level:

- Temporary nickname
- Specific avatar
- Contextual role or mask

**Example:**

- In a serious channel → professional identity
- In a casual channel → meme nickname

### Entries (Content)

**In Glow there are NO posts. There are Entries.**

**What an Entry Is:**

- A **blank canvas**
- **Block-based** (Notion-like)
- No rigid template

**Can contain:**

- Rich text
- Images
- Embeds
- Layouts
- Visual blocks
- (Future) dynamic smart blocks

**Where Entries Can Exist:**

- 🌍 **Global** - Appear in Global feed
- 🪐 **Space** - Space content
- 🧩 **Channel** - Belong to specific channel
- 👤 **User** (profile) - Personal entries

**An Entry can:**

- Stay in its context
- **Be promoted** (e.g., Space → Global)

### Identity System (Multi-Layered) - KEY SYSTEM

**Glow has multi-level identity:**

**1️⃣ Global Profile**

- Base identity
- Visible everywhere
- Minimal

**2️⃣ Space Identity**

- Identity per Space
- Context control
- Deep personalization

**3️⃣ Channel Mask**

- Ephemeral or specific identity
- Maximum freedom

👉 **Identity depends on where you are, not who you are globally.**

**Context Table:**

| Context | Chat Type  | Identity Used  |
| ------- | ---------- | -------------- |
| Global  | DM / Group | Global Profile |
| Space   | DM / Group | Space Identity |
| Channel | Chat       | Channel Mask   |

---

## Visual System — Glow (Living UI)

**Glow** is a living UI system, not static theming.

### Core Visual Modes

**Legacy Mode**

- Static UI
- No animations
- No glow
- Battery-friendly
- Low-end device support

**Glow Mode** (Default)

- Soft glow
- Gentle pulses
- Glassmorphism
- Depth
- Subtle motion

**Glow Up** (Premium)

- Multi-color glow
- Advanced gradients
- Pulses, flow, flicker
- Animated chat bubbles
- Profile frames
- Entry effects

### Visual Scope

Glow applies to:

- UI components
- Entries
- Smart Blocks
- Separators
- Chat bubbles
- Profile frames
- Navigation elements

### Performance Philosophy

Glow is:

- **Synchronized** - All motion follows a global clock
- **Selective** - Only necessary elements animate
- **Non-blocking** - Does not interfere with interaction
- **GPU-friendly** - Hardware-accelerated when possible

---

## Theme System & Cascading Styles

Glow uses a **hierarchical cascade system**.

### Style Priority Order

1. **Object-specific** (entry, block, bubble)
2. **User theme** (if premium)
3. **Channel theme**
4. **Space theme**
5. **Global default theme**

### Synchronization

All visual motion:

- Follows a **global clock**
- Stays **rhythmically consistent**
- Avoids **chaotic animation**

---

## Terminology (STRICT - ALWAYS ENFORCE)

### Primary Concepts

- **Global** - Top-level feed and social layer
- **Spaces** - Immersive communities with unique visual identity
- **Channels** - Composite immersive areas (chats + entries) within Spaces
- **Entries** - Block-based content pieces (NOT "posts")
- **Masks** - Per-channel identity customization (nicknames, etc.)
- **Smart Blocks** - Building units of Entries

### Content Types

- **Entry** - Block-based content (like Notion pages)
- **Chat Message** - Real-time text message
- **Voice Message** - Audio communication

### NEVER Use These Terms

❌ "posts" → Use **Entries**
❌ "groups" (for spaces) → Use **Spaces**
❌ "servers" → Use **Spaces**
❌ "communities" (when referring to Spaces) → Use **Spaces**
❌ "messages" (for entries) → Use **Entries**
❌ "channels" (for DMs) → Use **DMs** or **Group Chats**

---

## Architecture

### Clean Architecture - STRICT Layer Separation

```
┌─────────────────────────────────────┐
│        Presentation Layer           │  ← UI, State, Widgets
│  (Flutter, Riverpod, Pages, Blocs)  │
└──────────────┬──────────────────────┘
               │ calls ↓
┌──────────────▼──────────────────────┐
│         Domain Layer                │  ← Business Logic
│  (Entities, UseCases, Repositories) │  ← Pure Dart, NO Flutter deps
└──────────────┬──────────────────────┘
               │ implements ↓
┌──────────────▼──────────────────────┐
│          Data Layer                 │  ← Implementation
│  (DTOs, DataSources, Repo Impls)   │
└──────────────┬──────────────────────┘
               │ uses ↓
┌──────────────▼──────────────────────┐
│      External/Infrastructure        │  ← APIs, DB, Storage
│   (Supabase, Dio, Isar, Packages)  │
└─────────────────────────────────────┘
```

### Dependency Rule (CRITICAL)

**Dependencies ONLY flow inward (downward in diagram)**

✅ Presentation → Domain → Data → External
❌ NEVER: Domain → Data
❌ NEVER: Domain → Presentation
❌ NEVER: Data ← External direct access from Presentation

**Communication Pattern**: ALWAYS bottom-up, NEVER lateral

- Presentation calls UseCases
- UseCases call Repositories (interfaces)
- Data implements Repositories
- Data calls DataSources
- DataSources call External APIs

### Package Structure

```
packages/
├── glow_core/          # Shared primitives (Result, Failure, Logger, etc.)
├── glow_domain/        # Business entities (User, Space, Channel, Entry)
├── glow_data/          # Repository implementations, DTOs, DataSources
├── glow_api/           # HTTP client, API DTOs, endpoints
├── glow_auth/          # Authentication logic (tokens, sessions)
├── glow_realtime/      # WebSocket, presence, sync
├── glow_blocks_engine/ # Content blocks system (Notion-like)
├── glow_blocks_flutter/# Flutter widgets for blocks
├── glow_observability/ # Logging, analytics, crash reporting
└── glow_ui/            # Design system (atoms, molecules, organisms)
```

---

## UI Architecture (Atomic Design)

### Component Hierarchy

```
Organisms (Complex, composed)
    ↑ composed of
Molecules (Multi-element, reusable)
    ↑ composed of
Atoms (Single-element, basic)
```

### Atoms (`packages/glow_ui/lib/src/atoms/`)

Single-responsibility, indivisible UI elements.

**Examples**:

- `buttons.dart` - GlowButton, GlowIconButton, GlowTextButton
- `inputs.dart` - GlowTextField, GlowPasswordField, GlowSearchField
- `icons.dart` - GlowIcon with glow effects
- `avatars.dart` - GlowAvatar (circle, square, with border)

**Rules**:

- ✅ No business logic
- ✅ Accept callbacks only
- ✅ Stateless OR simple animation state
- ❌ NO data fetching
- ❌ NO providers/dependency injection

### Molecules (`packages/glow_ui/lib/src/molecules/`)

Composed of multiple atoms, reusable patterns.

**Examples**:

- `cards.dart` - GlowCard, GlowHoverCard (like SpaceCard)
- `list_items.dart` - GlowListTile, GlowChannelItem
- `dialogs.dart` - GlowDialog, GlowBottomSheet

**Rules**:

- ✅ Combine atoms
- ✅ Handle internal UI state (hover, expansion, etc.)
- ✅ Accept data models via props
- ❌ NO providers (except theme)
- ❌ NO navigation logic

### Organisms (`packages/glow_ui/lib/src/organisms/`)

Complex components, may use providers, handle business logic.

**Examples**:

- `navigation.dart` - AppShell, BottomNav, NavigationRail
- `app_bar.dart` - GlowAppBar, GlowSliverAppBar

**Rules**:

- ✅ Can use Riverpod providers
- ✅ Can trigger navigation
- ✅ Can fetch data
- ✅ Compose molecules and atoms
- ❌ Still respect single responsibility

### Layouts (`packages/glow_ui/lib/src/layouts/`)

Page-level structure, responsive behavior.

**Examples**:

- `app_shell.dart` - Main app navigation shell
- `responsive.dart` - Breakpoint helpers
- `scaffold.dart` - Custom scaffold variants

---

## State Management (Riverpod)

### Global App State

**Location**: `apps/glow_app/lib/shared/state/`

```dart
// app_state.dart
@freezed
class AppState with _$AppState {
  const factory AppState.initializing() = _Initializing;
  const factory AppState.unauthenticated() = _Unauthenticated;
  const factory AppState.authenticated() = _Authenticated;
}

// app_state_notifier.dart
@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() => const AppState.initializing();

  Future<void> initialize() async {
    // Check auth, load config
    state = const AppState.authenticated(); // Mock for now
  }
}
```

### Provider Patterns

**Feature State** (per feature):

```dart
@riverpod
class SpacesController extends _$SpacesController {
  @override
  Future<List<Space>> build() async {
    // Load spaces from repository
  }
}
```

**Use Cases** (business logic):

```dart
@riverpod
GetSpacesUseCase getSpacesUseCase(GetSpacesUseCaseRef ref) {
  return GetSpacesUseCase(ref.watch(spacesRepositoryProvider));
}
```

**Repositories** (data access):

```dart
@riverpod
SpacesRepository spacesRepository(SpacesRepositoryRef ref) {
  return SpacesRepositoryImpl(
    remoteDataSource: ref.watch(spacesRemoteDataSourceProvider),
    localDataSource: ref.watch(spacesLocalDataSourceProvider),
  );
}
```

---

## Navigation (go_router)

### Route Structure

**Location**: `apps/glow_app/lib/router/`

```dart
// app_routes.dart - Route constants
class AppRoutes {
  static const splash = '/';
  static const auth = '/auth';
  static const home = '/home';
  static const environment = '/environment/:name';
}

// app_router.dart - Route configuration
@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final appState = ref.watch(appStateNotifierProvider);

  return GoRouter(
    refreshListenable: appState, // Re-evaluate on state change
    redirect: (context, state) {
      // Route guards based on AppState
    },
    routes: [
      GoRoute(path: AppRoutes.splash, ...),
      GoRoute(path: AppRoutes.home, ...),
    ],
  );
}
```

### Navigation Guards

Based on `AppState`:

- `initializing` → Force to splash
- `unauthenticated` → Force to auth
- `authenticated` → Allow app routes

---

## Theme System

### Color Palette (`packages/glow_ui/lib/src/theme/colors.dart`)

```dart
class GlowColors {
  // Background
  static const backgroundDark = Color(0xFF0A0A0F);
  static const backgroundElevated = Color(0xFF121218);

  // Glow colors (main brand)
  static const primaryGlow = Color(0xFF7C3AED);   // Purple
  static const secondaryGlow = Color(0xFFEC4899); // Pink
  static const accentGlow = Color(0xFF06B6D4);    // Cyan

  // Subtle variants (for shadows, borders)
  static const primaryGlowSubtle = Color(0x337C3AED);   // 20% opacity
  static const secondaryGlowSubtle = Color(0x33EC4899);
  static const accentGlowSubtle = Color(0x3306B6D4);

  // Text
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB3B3B3);
  static const textTertiary = Color(0xFF666666);

  // Borders
  static const border = Color(0xFF2A2A2F);
  static const borderFocus = Color(0xFF7C3AED);
}
```

### Typography (`packages/glow_ui/lib/src/theme/typography.dart`)

- Font Family: Inter (system fallback currently, InterDisplay planned)
- Weights: 400 (regular), 500 (medium), 600 (semibold), 700 (bold)

### Spacing (`packages/glow_ui/lib/src/theme/spacing.dart`)

```dart
class GlowSpacing {
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}
```

---

## Data Flow Pattern

### Example: Loading Spaces

```dart
// 1. PRESENTATION - User opens Home page
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacesAsync = ref.watch(spacesControllerProvider);

    return spacesAsync.when(
      data: (spaces) => SpacesGrid(spaces: spaces),
      loading: () => LoadingSpinner(),
      error: (e, s) => ErrorView(error: e),
    );
  }
}

// 2. CONTROLLER - Manages state
@riverpod
class SpacesController extends _$SpacesController {
  @override
  Future<List<Space>> build() async {
    final useCase = ref.watch(getSpacesUseCaseProvider);
    final result = await useCase.execute();

    return result.fold(
      (failure) => throw failure,
      (spaces) => spaces,
    );
  }
}

// 3. USE CASE - Business logic
class GetSpacesUseCase {
  final SpacesRepository repository;

  Future<Either<Failure, List<Space>>> execute() async {
    return repository.getSpaces();
  }
}

// 4. REPOSITORY (interface in domain/)
abstract class SpacesRepository {
  Future<Either<Failure, List<Space>>> getSpaces();
}

// 5. REPOSITORY IMPL (in data/)
class SpacesRepositoryImpl implements SpacesRepository {
  final SpacesRemoteDataSource remoteDS;
  final SpacesLocalDataSource localDS;

  @override
  Future<Either<Failure, List<Space>>> getSpaces() async {
    try {
      final dto = await remoteDS.fetchSpaces();
      final entities = dto.map((d) => d.toEntity()).toList();
      await localDS.cacheSpaces(entities);
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

// 6. DATA SOURCE (in data/)
class SpacesRemoteDataSource {
  final ApiClient client;

  Future<List<SpaceDTO>> fetchSpaces() async {
    final response = await client.get('/spaces');
    return (response.data as List)
        .map((json) => SpaceDTO.fromJson(json))
        .toList();
  }
}
```

**Key Principle**: Each layer only talks to the layer directly below it. NO skipping layers.

---

## Project Tools & Workflows (USE THESE)

### Available Tools

**Monorepo Management**:

- `melos bootstrap` - Install dependencies for all packages
- `melos clean` - Clean all packages
- `melos analyze` - Run analyzer on all packages (ZERO warnings policy)
- `melos test` - Run tests across all packages
- `melos format` - Format all code

**Code Generation**:

- `dart run build_runner build --delete-conflicting-outputs` - Generate code (Isar schemas, Riverpod providers, Freezed models)
- `dart run build_runner watch` - Watch mode for continuous generation
- `dart run build_runner clean` - Clean generated files

**Mason (Scaffolding)**:

- `mason make feature` - Generate new feature structure
- `mason make entity` - Generate domain entity
- `mason make repository` - Generate repository interface + implementation
- `mason make usecase` - Generate use case

**Git**:

- Use **Conventional Commits** format:
  - `feat:` - New feature
  - `fix:` - Bug fix
  - `docs:` - Documentation
  - `refactor:` - Code refactoring
  - `test:` - Adding/updating tests
  - `chore:` - Maintenance

### Development Workflows

**When Creating a New Feature**:

1. Use Mason: `mason make feature --name {feature_name}`
2. Define entities in `glow_domain`
3. Create use cases in `glow_domain`
4. Implement repository interface in `glow_domain`
5. Implement repository in `glow_data`
6. Create data sources (local + remote) in `glow_data`
7. Create DTOs and Isar models in `glow_data`
8. Implement UI in feature's presentation layer
9. Run `dart run build_runner build` to generate code
10. Run `melos analyze` - Must show ZERO warnings
11. Write tests
12. Commit with conventional commit format

**When Adding Offline-First Support**:

1. Create Isar model in `glow_data/lib/src/models/isar/`
2. Add `@collection` annotation
3. Define schema with sync metadata:
   - `isPendingSync: bool`
   - `syncOperation: String?`
   - `syncError: String?`
   - `syncRetryCount: int`
4. Run `dart run build_runner build` to generate schema
5. Update `IsarService` to include new schema
6. Implement local data source using Isar
7. Update repository to offline-first pattern:
   - Read from local first
   - Sync in background
   - Queue writes with pending flag
8. Add sync status UI indicators

**When Working on UI**:

1. Check if component exists in `glow_ui` package
2. Follow Atomic Design:
   - Create atoms for basic elements
   - Compose molecules from atoms
   - Build organisms for complex features
3. Use existing design tokens (colors, spacing, typography)
4. Apply Glow visual effects only when appropriate
5. Test responsive behavior (mobile, tablet, desktop)
6. Ensure zero analyzer warnings

### Code Review Checklist

Before committing:

- [ ] Code is in **ENGLISH** (comments, variables, UI strings)
- [ ] Uses correct **terminology** (Spaces, Entries, Channels, NOT posts/groups/servers)
- [ ] Follows **Clean Architecture** (proper layer separation)
- [ ] Implements **offline-first pattern** (if data layer)
- [ ] Includes **tests** (unit tests for business logic)
- [ ] Has **zero analyzer warnings** (`melos analyze`)
- [ ] Uses **Conventional Commits** format
- [ ] Updated **documentation** if needed

---

## Code Generation

### Tools Used

- `freezed` - Immutable models
- `json_serializable` - JSON serialization
- `riverpod_generator` - Provider generation

### Manual Generation Required

**IMPORTANT**: build_runner has conflicts. Generate code manually:

```bash
# Per package
cd packages/glow_domain
dart run build_runner build --delete-conflicting-outputs

# App
- [x] Isar dependencies added (offline-first)

### 🚧 In Progress

- [ ] Isar setup and initialization
- [ ] Offline-first repository pattern
- [ ] Sync manager implementation
- [ ] Supabase integration
- [ ] Real authentication
- [ ] Channels list in EnvironmentPage

### 📋 Pending

- [ ] Entry content blocks UI
- [ ] Blocks engine integration
- [ ] Real-time sync with offline queue
- [ ] Conflict resolution
- [ ] Unit tests
- [ ] Integration tests
- [ ] CI/CD pipeline execution

## Offline-First Strategy

**See:** `docs/OFFLINE_FIRST_STRATEGY.md`

**Principles:**
- ✅ Isar as local cache and offline storage
- ✅ Supabase as remote source of truth
- ✅ Sync queue for pending operations
- ✅ UI shows sync status (pending ⏳, synced ✅, error ❌)
- ✅ App functions 100% offline for viewing/creating content
- ✅ Automatic sync when back online

**Data Flow:**
```

User Action
↓
Save to Isar (local) immediately
↓
Queue for sync (SyncOperationIsarModel)
↓
Sync to Supabase when online
↓
UI shows sync status

````

**Implementation Status:**
- ✅ Isar models created (SpaceIsarModel, SyncOperationIsarModel)
- ✅ IsarService singleton implemented
- ✅ Offline-first strategy documented
- ⚠️ Pending: Schema generation with build_runner
- ⚠️ Pending: Local data sources implementation
- ⚠️ Pending: SyncManager implementation
- ⚠️ Pending: Repository pattern updates

---

## Project Status

### ✅ Completed

- [x] Technical foundation with Clean Architecture
- [x] Monorepo configured (Melos + Mason)
- [x] Core package structure (10 packages)
- [x] State management (Riverpod 2.5+)
- [x] Backend integration planning (Supabase)
- [x] Offline-first storage (Isar models)
- [x] Design system foundation (atomic design)
- [x] Routing with guards (go_router)
- [x] Home page with tabs
- [x] Spaces grid (mock data, 6 spaces)
- [x] SpaceCard with hover effects
- [x] EnvironmentPage (Space detail view)
- [x] Mock authentication flow
- [x] Zero analyzer warnings (before Isar)
- [x] Complete documentation overhaul

### 🚧 In Progress

- [ ] Isar schema generation (build_runner)
- [ ] Supabase integration
- [ ] Real authentication
- [ ] Channels list in EnvironmentPage

### 📋 Pending

- [ ] Entry content blocks UI
- [ ] Blocks engine integration
- [ ] Real-time sync with Supabase
- [ ] SyncManager implementation
- [ ] Local data sources (Isar)
- [ ] Offline-first repositories
- [ ] UI sync status indicators
- [ ] Unit tests
- [ ] Integration tests
- [ ] CI/CD pipeline execution

---

## Coding Standards

### File Naming

```dart
// Features
lib/features/{feature}/
  ├── data/
  │   ├── datasources/
  │   │   ├── {feature}_local_ds.dart
  │   │   └── {feature}_remote_ds.dart
  │   ├── models/
  │   │   └── {feature}_dto.dart
  │   └── repositories/
  │       └── {feature}_repository_impl.dart
  ├── domain/
  │   ├── entities/
  │   │   └── {feature}_entity.dart
  │   ├── repositories/
  │   │   └── {feature}_repository.dart
  │   └── usecases/
  │       └── get_{feature}_usecase.dart
  └── presentation/
      ├── pages/
      │   └── {feature}_page.dart
      ├── widgets/
      │   └── {feature}_card.dart
      └── providers/
          └── {feature}_controller.dart
````

### Imports Order

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. External packages
import 'package:riverpod/riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 4. Internal packages (glow_*)
import 'package:glow_core/glow_core.dart';
import 'package:glow_domain/glow_domain.dart';

// 5. Relative imports (same package)
import '../models/user_dto.dart';
import 'auth_local_ds.dart';
```

### Error Handling

```dart
// ALWAYS use Either<Failure, T>
Future<Either<Failure, User>> getUser(String id) async {
  try {
    final dto = await dataSource.fetchUser(id);
    return Right(dto.toEntity());
  } on NetworkException catch (e) {
    return Left(NetworkFailure(e.message));
  } on CacheException catch (e) {
    return Left(CacheFailure(e.message));
  } catch (e) {
    return Left(UnknownFailure(e.toString()));
  }
}
```

### Riverpod Providers

```dart
// Use code generation
@riverpod
class FeatureController extends _$FeatureController {
  @override
  FutureOr<FeatureState> build() {
    // Implementation
  }
}

// NOT manual providers unless necessary
// final featureProvider = StateNotifierProvider<...>(...); // Avoid
```

### Freezed Models

```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    String? avatar,
    @Default([]) List<String> spaces,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

---

## DO (Best Practices)

### Architecture

- ✅ Follow Clean Architecture strictly
- ✅ Respect the Dependency Rule (dependencies flow inward)
- ✅ Keep domain layer pure Dart (no Flutter deps)
- ✅ Use dependency injection (Riverpod)
- ✅ Separate concerns (one class = one responsibility)

### Code Quality

- ✅ Use `Either<Failure, T>` for all operations that can fail
- ✅ Write tests for business logic (UseCases, Repositories)
- ✅ Use `freezed` for immutable models
- ✅ Use `riverpod_generator` for providers
- ✅ Handle all error cases explicitly
- ✅ Add TODOs with issue references: `// TODO(#123): Implement offline sync`

### UI

- ✅ Follow Atomic Design (atoms → molecules → organisms)
- ✅ Keep widgets small and focused
- ✅ Extract reusable components to `glow_ui` package
- ✅ Use const constructors whenever possible
- ✅ Prefer composition over inheritance

### Communication

- ✅ Bottom-up communication only (Presentation → Domain → Data)
- ✅ Use callbacks for upward events
- ✅ Use providers for downward data
- ❌ NEVER lateral communication between features

### Git

- ✅ Use Conventional Commits: `feat:`, `fix:`, `docs:`, `refactor:`, `test:`
- ✅ Keep commits atomic (one logical change)
- ✅ Write descriptive commit messages

---

## DON'T (Anti-patterns)

### Architecture Violations

- ❌ Mix presentation and business logic
- ❌ Put Flutter imports in domain layer
- ❌ Skip repository abstraction (direct API calls from UI)
- ❌ Break the Dependency Rule
- ❌ Create God objects (classes doing too much)
- ❌ Lateral communication between features

### Code Smells

- ❌ Use magic numbers/strings (create constants)
- ❌ Duplicate code (DRY principle)
- ❌ Ignore errors (always handle failures)
- ❌ Use `dynamic` unless absolutely necessary
- ❌ Ignore analyzer warnings

### Testing

- ❌ Skip tests for critical flows (auth, payments, data sync)
- ❌ Test implementation details (test behavior, not internals)
- ❌ Write brittle tests (use mocks properly)

### UI

- ❌ Put business logic in widgets
- ❌ Create deeply nested widget trees (extract methods/widgets)
- ❌ Hardcode values (use theme, spacing constants)
- ❌ Ignore responsive design

---

## Mock Data (Current State)

### Spaces

Located: `apps/glow_app/lib/features/home/data/mock_spaces.dart`

```dart
class MockSpace {
  final String name;
  final String description;
  final List<Color> gradientColors;
  final IconData icon;

  static final List<MockSpace> mockSpaces = [
    MockSpace(
      name: 'MotoGP',
      description: 'Discuss races, riders, and motorcycle technology',
      gradientColors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
      icon: Icons.sports_motorsports,
    ),
    // ... 5 more spaces
  ];
}
```

---

## Aesthetic Guidelines

### Visual Identity

- **Mood**: Dark, atmospheric, immersive, mysterious yet welcoming
- **Colors**: Deep blacks, subtle grays, vibrant glow accents
- **Effects**: Subtle glow on interactive elements, smooth animations
- **Typography**: Clean, modern, high contrast

### Animation Principles

- Duration: 200-300ms for micro-interactions
- Easing: `Curves.easeInOut` for most, `Curves.elasticOut` for emphasis
- Hover states: Subtle scale (1.02x), glow increase, border color change

### Component Behavior

- Cards: Hover → glow shadow, border color change
- Buttons: Hover → subtle lift, glow increase
- Inputs: Focus → border glow, label float
- Navigation: Smooth transitions, persistent state

---

## Development Workflow

### Daily Routine

1. Check `flutter analyze` before committing
2. Run tests: `melos test`
3. Format code: `melos format`
4. Update context doc: `.github/context/YYYY-MM-DD.md`
5. Commit with conventional commit message

### Hot Reload

- Press `r` for hot reload (preserves state)
- Press `R` for hot restart (resets state)
- Press `q` to quit

### Building

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
flutter build ipa --release

# Windows
flutter build windows --release
```

---

## Communication Pattern (CRITICAL)

### Function/Component Communication

**Rule**: ALWAYS bottom-up, NEVER lateral

```
┌─────────────┐
│  Component  │
│      A      │ ────✅ Calls callback upward
└─────────────┘
       ↑
       │ Event flows UP
       │
┌─────────────┐
│   Parent    │ ────✅ Passes data downward
└─────────────┘
       │
       │ Data flows DOWN
       ↓
┌─────────────┐
│  Component  │
│      B      │ ────❌ NEVER calls Component A directly
└─────────────┘
```

**Examples**:

✅ **Correct** - Bottom-up:

```dart
// Child emits event via callback
SpaceCard(
  onTap: () => onSpaceSelected(space), // ← Event goes UP
);

// Parent handles event
void onSpaceSelected(Space space) {
  context.push('/environment/${space.name}');
}
```

❌ **Wrong** - Lateral:

```dart
// Component A directly calling Component B
class SpaceCard extends StatelessWidget {
  void _onTap() {
    OtherFeature.doSomething(); // ❌ NEVER do this
  }
}
```

✅ **Correct** - Provider-based:

```dart
// Child reads from provider
final spaces = ref.watch(spacesControllerProvider);

// Child emits event via provider method
ref.read(spacesControllerProvider.notifier).selectSpace(space);
```

---

## Summary - Critical Rules

### Language

- ✅ ALL code in ENGLISH (comments, variables, UI, docs)
- ✅ Respond to user in their language, but code stays in ENGLISH
- ❌ NO Spanish or other languages in product

### Terminology (Enforce Strictly)

- ✅ Spaces (NOT servers/groups/communities)
- ✅ Entries (NOT posts)
- ✅ Channels (composite areas, NOT just chats)
- ✅ Masks (per-channel identity)
- ✅ Smart Blocks (building units)

### Architecture

- ✅ Clean Architecture - strict layer separation
- ✅ Dependencies flow inward only
- ✅ Domain layer is pure Dart
- ✅ Use Either<Failure, T> for operations that can fail
- ✅ Offline-first pattern for all data operations

### Tools & Workflows

- ✅ Use Melos for monorepo management
- ✅ Use Mason for code scaffolding
- ✅ Use build_runner for code generation
- ✅ Conventional Commits format
- ✅ Zero analyzer warnings policy

### Communication

- ✅ Bottom-up only (events go UP, data goes DOWN)
- ❌ NEVER lateral communication between features
- ✅ Use callbacks for upward events
- ✅ Use providers for downward data

### Quality Standards

- ✅ Write tests for business logic
- ✅ Follow Atomic Design for UI
- ✅ Use const constructors
- ✅ Document complex logic
- ✅ Zero warnings on commit

---

## License

**Proprietary**. Not open source. All rights reserved.

---

## Context History

See `.github/context/` for daily context files documenting each session's work.
