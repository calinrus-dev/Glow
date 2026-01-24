# Architecture Documentation - Glow

> **Communities are worlds. Content is architecture. UI is alive.**

---

## Overview

Glow follows **Clean Architecture** principles with strict layer separation, ensuring maintainability, testability, and scalability.

This architecture supports Glow's complex content structure:

- **Global** - Universal lobby and cross-space convergence zone
- **Spaces** - Fully self-contained thematic worlds with unique identity
- **Channels** - Composite micro-worlds (chats + entries + voice) within Spaces
- **Entries** - Living, block-based content (Smart Blocks system)

```
┌──────────────────────────────────────────────────────────┐
│                      Presentation                         │
│   (UI, State Management, Navigation, User Interaction)   │
└──────────────────────┬───────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────┐
│                        Domain                             │
│      (Entities, Use Cases, Business Logic, Policies)     │
└──────────────────────┬───────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────┐
│                         Data                              │
│    (Repositories, Data Sources, Network, Local Storage)  │
└──────────────────────┬───────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────┐
│                    Infrastructure                         │
│          (Supabase, Isar, APIs, External Services)       │
└──────────────────────────────────────────────────────────┘
```

---

## Core Principles

### 1. **Dependency Rule**

Dependencies point **inward only**. Outer layers can depend on inner layers, never the reverse.

- ✅ Presentation → Domain → Data → Infrastructure
- ❌ Domain → Data
- ❌ Data → Presentation
- ❌ Domain → Infrastructure

### 2. **Layer Independence**

Each layer has clear responsibilities and can be tested in isolation.

### 3. **Business Logic Isolation**

Business rules live in the **domain layer**, independent of frameworks, UI, or external services.

**Domain layer is pure Dart** - no Flutter imports, no external dependencies.

### 4. **Inversion of Control**

Use abstractions (interfaces/abstract classes) to decouple layers.

Example: Repositories are **interfaces in Domain**, **implementations in Data**.

---

---

## Layer Breakdown

### **1. Domain Layer** (`glow_domain`)

**Purpose:** Contains business logic, entities, and contracts.

**Responsibilities:**

- Define core entities (User, Space, Channel, Canvas)
- Business use cases (CreateSpace, JoinChannel, PublishCanvas)
- Repository interfaces (abstract contracts)
- Business rules and policies
- Domain-specific exceptions and failures

**Dependencies:** None (pure Dart, no external dependencies)

**Structure:**

```
glow_domain/
**Structure:**

```
glow_domain/
├── entities/
│   ├── space.dart           # Space entity
│   ├── channel.dart         # Channel entity
│   ├── entry.dart           # Entry (block-based content) entity
│   ├── user.dart            # User entity
│   ├── identity.dart        # Multi-layered identity (Global/Space/Channel)
│   └── block.dart           # Smart Block entity
├── use_cases/
│   ├── spaces/
│   │   ├── create_space_use_case.dart
│   │   ├── get_spaces_use_case.dart
│   │   ├── join_space_use_case.dart
│   │   └── customize_space_theme_use_case.dart
│   ├── channels/
│   │   ├── create_channel_use_case.dart
│   │   ├── get_channels_use_case.dart
│   │   └── set_channel_mask_use_case.dart
│   ├── entries/
│   │   ├── create_entry_use_case.dart
│   │   ├── get_entries_use_case.dart
│   │   └── promote_entry_use_case.dart
│   └── identity/
│       ├── get_space_identity_use_case.dart
│       └── update_space_identity_use_case.dart
├── repositories/
│   ├── space_repository.dart       # Interface
│   ├── channel_repository.dart     # Interface
│   ├── entry_repository.dart       # Interface
│   └── user_repository.dart        # Interface
└── failures/
    └── domain_failure.dart
```

**Example:**

```dart
// Entity (Domain)
@freezed
class Space with _$Space {
  const factory Space({
    required String id,
    required String name,
    required String slug,
    String? description,
    String? iconUrl,
    String? coverUrl,
    required SpaceVisibility visibility,
    required String ownerId,
    required DateTime createdAt,
    DateTime? updatedAt,
    // ... additional properties
  }) = _Space;
}

// Use Case (Domain)
class GetSpacesUseCase {
  final SpacesRepository repository;

  GetSpacesUseCase(this.repository);

  Future<Either<Failure, List<Space>>> execute() async {
    return repository.getSpaces();
  }
}

// Repository Interface (Domain)
abstract class SpacesRepository {
  Future<Either<Failure, List<Space>>> getSpaces();
  Future<Either<Failure, Space>> createSpace(CreateSpaceParams params);
  Future<Either<Failure, Space>> getSpaceById(String id);
}
```

---

### **2. Data Layer** (`glow_data`, `glow_api`, `glow_auth`, `glow_realtime`)

**Purpose:** Implements data access and external integrations with **offline-first** support.

**Responsibilities:**

- Implement repository interfaces from domain
- Network communication (REST APIs, Supabase)
- **Local storage (Isar - offline-first cache)**
- **Sync queue management** (pending operations)
- Authentication and session management
- Realtime connections (Supabase Realtime)
- Data mapping (DTO ↔ Entity, Isar ↔ Entity)
- **Conflict resolution**

**Dependencies:** Domain layer, external SDKs (Supabase, Dio, Isar)

**Structure:**

```
glow_data/
├── repositories/
│   ├── spaces_repository_impl.dart      # Implements SpacesRepository
│   ├── entries_repository_impl.dart     # Offline-first pattern
│   └── channels_repository_impl.dart
├── datasources/
│   ├── remote/
│   │   ├── spaces_remote_data_source.dart
│   │   ├── entries_remote_data_source.dart
│   │   └── channels_remote_data_source.dart
│   └── local/
│       ├── spaces_local_data_source.dart   # Isar operations
│       ├── entries_local_data_source.dart
│       └── sync_queue_data_source.dart      # Manages pending syncs
├── models/
│   ├── dto/
│   │   ├── space_dto.dart         # API response/request models
│   │   └── entry_dto.dart
│   └── isar/
│       ├── space_isar_model.dart  # Isar collection model
│       ├── entry_isar_model.dart
│       └── sync_operation_isar_model.dart  # Sync queue
├── local/
│   └── isar_service.dart          # Isar initialization
└── mappers/
    ├── space_mapper.dart           # DTO ↔ Entity
    └── space_isar_mapper.dart      # Isar ↔ Entity
```

**Example (Offline-First Pattern):**

```dart
// Repository Implementation with Offline-First
class SpacesRepositoryImpl implements SpacesRepository {
  final SpacesRemoteDataSource remoteDataSource;
  final SpacesLocalDataSource localDataSource;
  final SyncQueueDataSource syncQueue;

  @override
  Future<Either<Failure, List<Space>>> getSpaces() async {
    try {
      // 1. Return local data immediately
      final localSpaces = await localDataSource.getSpaces();
      
      // 2. Sync in background (don't await)
      _syncSpacesInBackground();
      
      return Right(localSpaces);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Space>> createSpace(CreateSpaceParams params) async {
    try {
      // 1. Create locally with pending sync flag
      final localSpace = await localDataSource.createSpace(params, isPending: true);
      
      // 2. Queue for sync
      await syncQueue.enqueue(
        SyncOperation.create(
          entityType: 'space',
          entityId: localSpace.id,
          payload: params.toJson(),
        ),
      );
      
      // 3. Attempt sync immediately (fire-and-forget)
      _trySyncNow();
      
      return Right(localSpace);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> _syncSpacesInBackground() async {
    try {
      final remoteSpaces = await remoteDataSource.fetchSpaces();
      await localDataSource.saveSpaces(remoteSpaces);
    } catch (_) {
      // Fail silently, will retry later
    }
  }
}
```
    }
  }
}

// Data Source
class SpaceRemoteDataSource {
  final Dio _dio;

  Future<SpaceDto> createSpace(CreateSpaceParams params) async {
    final response = await _dio.post('/spaces', data: params.toJson());
    return SpaceDto.fromJson(response.data);
  }
}

// DTO (Data Transfer Object)
@freezed
class SpaceDto with _$SpaceDto {
  factory SpaceDto({
    required String id,
    required String name,
    // ... matches API response structure
  }) = _SpaceDto;

  factory SpaceDto.fromJson(Map<String, dynamic> json) => _$SpaceDtoFromJson(json);
}
```

---

### **3. Presentation Layer** (`glow_app/lib/features/*/presentation`)

**Purpose:** UI, user interaction, and state management.

**Responsibilities:**

- Widget tree and UI components
- State management (Riverpod)
- Navigation (GoRouter)
- User input handling
- Display business data

**Dependencies:** Domain layer (use cases), UI layer (design system)

**Structure:**

```
features/spaces/
└── presentation/
    ├── providers/
  │   └── spaces_provider.dart  # Riverpod StateNotifier
    ├── screens/
  │   ├── spaces_list_screen.dart
  │   └── space_detail_screen.dart
    └── widgets/
    ├── space_card.dart
    └── space_header.dart
```

**Example:**

```dart
// Riverpod Provider
@riverpod
class SpacesNotifier extends _$SpacesNotifier {
  @override
  FutureOr<List<Space>> build() async {
    final useCase = ref.read(getSpacesUseCaseProvider);
    final result = await useCase.execute();

    return result.fold(
      (failure) => throw failure,
      (spaces) => spaces,
    );
  }

  Future<void> createSpace(CreateSpaceParams params) async {
    final useCase = ref.read(createSpaceUseCaseProvider);
    final result = await useCase.execute(params);

    result.fold(
      (failure) => /* Handle error */,
      (space) => ref.invalidateSelf(),
    );
  }
}

// Widget
class SpacesListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacesAsync = ref.watch(spacesNotifierProvider);

    return spacesAsync.when(
      data: (spaces) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (error, _) => ErrorWidget(error),
    );
  }
}
```

---

## Package Organization

### **Core Packages**

#### `glow_core`

- Base contracts (`Logger`, `Result`, `Failure`)
- Utilities (extensions, constants)
- No business logic

#### `glow_domain`

- Business entities
- Use cases
- Repository interfaces
- Domain failures

#### `glow_data`

- Repository implementations
- DTOs and mappers
- Data source coordination

---

### **Infrastructure Packages**

#### `glow_api`

- Dio HTTP client configuration
- API interceptors
- Network error handling

#### `glow_auth`

- Supabase Auth integration
- Session management
- Token refresh logic

#### `glow_realtime`

- Supabase Realtime channels
- Event streaming
- Presence management

#### `glow_observability`

- Logging (structured logs)
- Error tracking (Sentry)
- Analytics (Firebase Analytics)

---

### **UI Packages**

#### `glow_ui`

- Design system (colors, typography, spacing)
- Reusable components (buttons, cards, inputs)
- Theme configuration
- Glow aesthetic (dark, neon, atmospheric)

#### `glow_blocks_engine`

- Block-based content engine (core logic)
- Block types (text, image, video, embed)
- Serialization/deserialization
- Block validation

#### `glow_blocks_flutter`

- Block rendering widgets
- Canvas UI
- Block editing interactions
- Visual block builders

---

## Data Flow

### **Reading Data (Query)**

```
User Interaction
       ↓
Widget (Presentation)
       ↓
Riverpod Provider calls Use Case
       ↓
Use Case (Domain)
       ↓
Repository Interface (Domain)
       ↓
Repository Implementation (Data)
       ↓
Data Source (Remote/Local)
       ↓
External Service (Supabase, API)
       ↓
DTO returned
       ↓
Mapper converts DTO → Entity
       ↓
Entity returned to Use Case
       ↓
Use Case returns Either<Failure, Entity>
       ↓
Provider updates state
       ↓
Widget rebuilds with new data
```

### **Writing Data (Command)**

```
User Action
       ↓
Widget calls Provider method
       ↓
Provider calls Use Case
       ↓
Use Case validates + calls Repository
       ↓
Repository Implementation
       ↓
Remote Data Source sends API request
       ↓
Server processes and responds
       ↓
Response mapped to Entity
       ↓
Either<Failure, Entity> returned
       ↓
Provider handles success/error
       ↓
UI updates
```

---

## Error Handling

### **Failure Hierarchy**

```dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

// Domain Failures
class ValidationFailure extends Failure { ... }
class BusinessRuleFailure extends Failure { ... }

// Data Failures
class ServerFailure extends Failure { ... }
class NetworkFailure extends Failure { ... }
class CacheFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
```

### **Usage with Either**

```dart
Future<Either<Failure, Space>> getSpace(String id) async {
  try {
    final dto = await _remoteDataSource.getSpace(id);
    return Right(_mapper.toEntity(dto));
  } on DioException catch (e) {
    return Left(NetworkFailure(e.message));
  } on FormatException {
    return Left(ServerFailure('Invalid data format'));
  }
}
```

---

## Testing Strategy

### **Unit Tests** (Domain)

- Test use cases in isolation
- Mock repositories
- Verify business logic

```dart
test('CreateSpaceUseCase returns success', () async {
  // Arrange
  when(() => mockRepository.createSpace(any()))
      .thenAnswer((_) async => Right(mockSpace));

  // Act
  final result = await useCase.execute(params);

  // Assert
  expect(result.isRight(), true);
  verify(() => mockRepository.createSpace(params)).called(1);
});
```

### **Widget Tests** (Presentation)

- Test UI behavior
- Mock providers
- Verify widget tree

```dart
testWidgets('SpaceCard displays space name', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        spacesProvider.overrideWith(() => mockSpaces),
      ],
      child: SpaceCard(space: testSpace),
    ),
  );

  expect(find.text(testSpace.name), findsOneWidget);
});
```

### **Integration Tests** (Data)

- Test repository implementations
- Mock HTTP clients
- Verify data flow

---

## Dependency Injection

**Riverpod Providers** handle DI throughout the app.

```dart
// Use Case Provider
@riverpod
CreateSpaceUseCase createSpaceUseCase(CreateSpaceUseCaseRef ref) {
  final repository = ref.watch(spaceRepositoryProvider);
  return CreateSpaceUseCase(repository);
}

// Repository Provider
@riverpod
SpaceRepository spaceRepository(SpaceRepositoryProvider ref) {
  final remoteDataSource = ref.watch(spaceRemoteDataSourceProvider);
  final mapper = ref.watch(spaceMapperProvider);
  return SpaceRepositoryImpl(remoteDataSource, mapper);
}

// Data Source Provider
@riverpod
SpaceRemoteDataSource spaceRemoteDataSource(SpaceRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return SpaceRemoteDataSource(dio);
}
```

---

## Navigation

**GoRouter** with declarative routing.

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: 'spaces/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return SpaceDetailScreen(id: id);
          },
        ),
      ],
    ),
  ],
);
```

---

## State Management Patterns

### **Async State with Riverpod**

```dart
@riverpod
class SpaceDetail extends _$SpaceDetail {
  @override
  Future<Space> build(String id) async {
    final useCase = ref.read(getSpaceUseCaseProvider);
    final result = await useCase.execute(id);

    return result.fold(
      (failure) => throw failure,
      (space) => space,
    );
  }
}

// In widget
final spaceAsync = ref.watch(spaceDetailProvider(id));

spaceAsync.when(
  data: (space) => SpaceView(space),
  loading: () => LoadingIndicator(),
  error: (error, stack) => ErrorView(error),
);
```

---

## Best Practices

1. **Keep domain pure** - No external dependencies in `glow_domain`
2. **Use Either for operations** - Explicit error handling
3. **Single Responsibility** - One use case per business operation
4. **Immutable data** - Use Freezed for entities and DTOs
5. **Test coverage** - Unit tests for domain, widget tests for UI
6. **Dependency inversion** - Code against interfaces, not implementations
7. **Fail fast** - Validate early, handle errors explicitly

---

## Future Considerations

- **Offline-first architecture** - Local caching with sync
- **Event sourcing** - For audit trails and undo/redo
- **CQRS** - Separate read/write models for complex features
- **Microservices** - If backend scales beyond Supabase

---

**This architecture ensures Glow remains maintainable, testable, and scalable as features grow.**
