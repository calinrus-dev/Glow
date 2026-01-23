# Architecture Documentation - Glow

## Overview

Glow follows **Clean Architecture** principles with strict layer separation, ensuring maintainability, testability, and scalability.

```
┌─────────────────────────────────────────────────────────┐
│                      Presentation                        │
│  (UI, State Management, Navigation, User Interaction)   │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                        Domain                            │
│     (Entities, Use Cases, Business Logic, Policies)     │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                         Data                             │
│   (Repositories, Data Sources, Network, Local Storage)  │
└─────────────────────────────────────────────────────────┘
```

---

## Core Principles

### 1. **Dependency Rule**
Dependencies point **inward only**. Outer layers can depend on inner layers, never the reverse.

- ✅ Presentation → Domain → Data
- ❌ Domain → Data
- ❌ Data → Presentation

### 2. **Layer Independence**
Each layer has clear responsibilities and can be tested in isolation.

### 3. **Business Logic Isolation**
Business rules live in the **domain layer**, independent of frameworks, UI, or external services.

### 4. **Inversion of Control**
Use abstractions (interfaces/abstract classes) to decouple layers.

---

## Layer Breakdown

### **1. Domain Layer** (`glow_domain`)

**Purpose:** Contains business logic, entities, and contracts.

**Responsibilities:**
- Define core entities (User, Entorno, Canal, Lienzo)
- Business use cases (CreateEntorno, JoinCanal, PublishLienzo)
- Repository interfaces (abstract contracts)
- Business rules and policies
- Domain-specific exceptions and failures

**Dependencies:** None (pure Dart, no external dependencies)

**Structure:**
```
glow_domain/
├── entities/
│   ├── entorno.dart
│   ├── canal.dart
│   ├── lienzo.dart
│   └── user.dart
├── use_cases/
│   ├── entornos/
│   │   ├── create_entorno_use_case.dart
│   │   ├── get_entornos_use_case.dart
│   │   └── join_entorno_use_case.dart
│   └── canales/
│       └── ...
├── repositories/
│   ├── entorno_repository.dart  # Interface
│   ├── canal_repository.dart
│   └── user_repository.dart
└── failures/
    └── domain_failure.dart
```

**Example:**
```dart
// Entity
class Entorno {
  final String id;
  final String name;
  final String description;
  final EntornoTheme theme;
  
  Entorno({required this.id, required this.name, ...});
}

// Use Case
class CreateEntornoUseCase {
  final EntornoRepository _repository;
  
  CreateEntornoUseCase(this._repository);
  
  Future<Either<Failure, Entorno>> execute(CreateEntornoParams params) async {
    // Business logic here
    return _repository.createEntorno(params);
  }
}

// Repository Interface
abstract class EntornoRepository {
  Future<Either<Failure, Entorno>> createEntorno(CreateEntornoParams params);
  Future<Either<Failure, List<Entorno>>> getEntornos();
}
```

---

### **2. Data Layer** (`glow_data`, `glow_api`, `glow_auth`, `glow_realtime`)

**Purpose:** Implements data access and external integrations.

**Responsibilities:**
- Implement repository interfaces from domain
- Network communication (REST APIs, GraphQL)
- Local storage (shared_preferences)
- Authentication and session management
- Realtime connections (Supabase Realtime)
- Data mapping (DTO ↔ Entity)

**Dependencies:** Domain layer, external SDKs (Supabase, Dio)

**Structure:**
```
glow_data/
├── repositories/
│   ├── entorno_repository_impl.dart  # Implements EntornoRepository
│   └── canal_repository_impl.dart
├── data_sources/
│   ├── remote/
│   │   ├── entorno_remote_data_source.dart
│   │   └── canal_remote_data_source.dart
│   └── local/
│       └── preferences_data_source.dart
├── models/
│   ├── entorno_dto.dart  # Data Transfer Object
│   └── canal_dto.dart
└── mappers/
    └── entorno_mapper.dart  # DTO ↔ Entity conversion
```

**Example:**
```dart
// Repository Implementation
class EntornoRepositoryImpl implements EntornoRepository {
  final EntornoRemoteDataSource _remoteDataSource;
  final EntornoMapper _mapper;
  
  @override
  Future<Either<Failure, Entorno>> createEntorno(CreateEntornoParams params) async {
    try {
      final dto = await _remoteDataSource.createEntorno(params);
      final entity = _mapper.toEntity(dto);
      return Right(entity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

// Data Source
class EntornoRemoteDataSource {
  final Dio _dio;
  
  Future<EntornoDto> createEntorno(CreateEntornoParams params) async {
    final response = await _dio.post('/entornos', data: params.toJson());
    return EntornoDto.fromJson(response.data);
  }
}

// DTO (Data Transfer Object)
@freezed
class EntornoDto with _$EntornoDto {
  factory EntornoDto({
    required String id,
    required String name,
    // ... matches API response structure
  }) = _EntornoDto;
  
  factory EntornoDto.fromJson(Map<String, dynamic> json) => _$EntornoDtoFromJson(json);
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
features/entornos/
└── presentation/
    ├── providers/
    │   └── entornos_provider.dart  # Riverpod StateNotifier
    ├── screens/
    │   ├── entornos_list_screen.dart
    │   └── entorno_detail_screen.dart
    └── widgets/
        ├── entorno_card.dart
        └── entorno_header.dart
```

**Example:**
```dart
// Riverpod Provider
@riverpod
class EntornosNotifier extends _$EntornosNotifier {
  @override
  FutureOr<List<Entorno>> build() async {
    final useCase = ref.read(getEntornosUseCaseProvider);
    final result = await useCase.execute();
    
    return result.fold(
      (failure) => throw failure,
      (entornos) => entornos,
    );
  }
  
  Future<void> createEntorno(CreateEntornoParams params) async {
    final useCase = ref.read(createEntornoUseCaseProvider);
    final result = await useCase.execute(params);
    
    result.fold(
      (failure) => /* Handle error */,
      (entorno) => ref.invalidateSelf(),
    );
  }
}

// Widget
class EntornosListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entornosAsync = ref.watch(entornosNotifierProvider);
    
    return entornosAsync.when(
      data: (entornos) => ListView.builder(...),
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
- Lienzo canvas UI
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
Future<Either<Failure, Entorno>> getEntorno(String id) async {
  try {
    final dto = await _remoteDataSource.getEntorno(id);
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
test('CreateEntornoUseCase returns success', () async {
  // Arrange
  when(() => mockRepository.createEntorno(any()))
      .thenAnswer((_) async => Right(mockEntorno));
  
  // Act
  final result = await useCase.execute(params);
  
  // Assert
  expect(result.isRight(), true);
  verify(() => mockRepository.createEntorno(params)).called(1);
});
```

### **Widget Tests** (Presentation)
- Test UI behavior
- Mock providers
- Verify widget tree

```dart
testWidgets('EntornoCard displays entorno name', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        entornosProvider.overrideWith(() => mockEntornos),
      ],
      child: EntornoCard(entorno: testEntorno),
    ),
  );
  
  expect(find.text(testEntorno.name), findsOneWidget);
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
CreateEntornoUseCase createEntornoUseCase(CreateEntornoUseCaseRef ref) {
  final repository = ref.watch(entornoRepositoryProvider);
  return CreateEntornoUseCase(repository);
}

// Repository Provider
@riverpod
EntornoRepository entornoRepository(EntornoRepositoryProvider ref) {
  final remoteDataSource = ref.watch(entornoRemoteDataSourceProvider);
  final mapper = ref.watch(entornoMapperProvider);
  return EntornoRepositoryImpl(remoteDataSource, mapper);
}

// Data Source Provider
@riverpod
EntornoRemoteDataSource entornoRemoteDataSource(EntornoRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return EntornoRemoteDataSource(dio);
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
          path: 'entornos/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return EntornoDetailScreen(id: id);
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
class EntornoDetail extends _$EntornoDetail {
  @override
  Future<Entorno> build(String id) async {
    final useCase = ref.read(getEntornoUseCaseProvider);
    final result = await useCase.execute(id);
    
    return result.fold(
      (failure) => throw failure,
      (entorno) => entorno,
    );
  }
}

// In widget
final entornoAsync = ref.watch(entornoDetailProvider(id));

entornoAsync.when(
  data: (entorno) => EntornoView(entorno),
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
