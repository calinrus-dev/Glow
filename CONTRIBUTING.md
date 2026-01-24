# Contributing Guide - Glow

> **Communities are worlds. Content is architecture. UI is alive.**

---

## Before Contributing

Glow is a **collaborative but not open source** project. This means:

- **The code is not free** to redistribute, fork, or use commercially without authorization.
- **We accept contributions** from people aligned with the project's vision.
- **Significant contributions may translate into future participation** under clear agreements as the project matures.

This approach allows us to build Glow with quality, clear direction, and sustainability, while remaining open to serious and committed collaborators.

---

## Who Can Contribute?

Anyone who:

- **Shares Glow's vision** as a platform to build immersive digital worlds.
- **Has experience** in development (Flutter, Dart, backend), product design, UX/UI, or related areas.
- **Seeks to create real impact**, not just add commits.
- **Understands this is a product with commercial purposes**, not an academic or personal project.
- **Respects the architecture and terminology** defined by the project.

---

## Glow Conceptual Model (CRITICAL - READ FIRST)

Glow is **NOT** a traditional social network. It is a **system of immersive digital places** with identity, context, and layers.

### Content Architecture Overview

**Global** (Universal Layer)
- Universal lobby and cross-space convergence zone
- Discovery feed (For You, Popular, Recent, Featured)
- Global chats (DMs, Groups)
- Global Profile (core identity)

**Spaces** (Thematic Worlds)
- Fully self-contained immersive communities
- Unique visual identity and aesthetics
- Internal governance and moderation
- Space-specific identity per user

**Channels** (Composite Areas)
- Micro-worlds inside Spaces
- Combine chat + entries + voice simultaneously
- Channel Masks (per-channel identity)
- Visibility control (public, restricted, private)

**Entries** (Living Content)
- Block-based content (Smart Blocks)
- NOT posts — structured documents
- Exist in Global, Spaces, Channels, or User profiles
- Can be promoted across contexts

**Identity System** (Multi-Layered)
- Global Profile → Space Identity → Channel Mask
- Contextual, not fixed
- Prevents context collapse

---

## Terminology (STRICT - ALWAYS ENFORCE)

### ✅ Correct Terms

- **Global** - Top-level universal layer
- **Spaces** - Immersive thematic worlds (NOT "servers", "groups", "communities")
- **Channels** - Composite immersive areas (NOT just "chats")
- **Entries** - Block-based content (NOT "posts")
- **Masks** - Per-channel identity customization
- **Smart Blocks** - Building units of Entries

### ❌ NEVER Use

- "posts" → Use **Entries**
- "groups" (for Spaces) → Use **Spaces**
- "servers" → Use **Spaces**
- "communities" (when referring to Spaces) → Use **Spaces**
- "messages" (for entries) → Use **Entries**
- "channels" (for DMs) → Use **DMs** or **Group Chats**

**Incorrect terminology will be rejected in PRs.**

---

## Types of Accepted Contributions

### 1. **Code**

- Feature implementation (Global feed, Spaces, Channels, Entries)
- Architecture improvements
- Performance optimization
- Tests (unit, integration, widget)

## Types of Accepted Contributions

### 1. **Code**

- Feature implementation (Global feed, Spaces, Channels, Entries, Smart Blocks)
- Architecture improvements
- Performance optimization
- Offline-first sync implementation
- Tests (unit, widget, integration)

### 2. **Design**

- Design system (atoms, molecules, organisms)
- User experience flows
- Visual identity for Spaces
- Glow visual system (effects, animations)
- Iconography and visual resources

### 3. **Product**

- Flow definition
- Functional specifications
- Feature documentation
- User research
- Content architecture refinement

### 4. **Infrastructure**

- CI/CD pipelines
- Monitoring and observability
- Backend APIs (Supabase functions)
- Realtime systems
- Offline-first strategy implementation

---

## Contribution Process

### 1. **Before Starting**

- **Contact first.** Don't submit PRs without prior agreement.
- Open an **issue or discussion** explaining what you want to do and why.
- Reference the correct terminology (Spaces, Entries, Channels, Masks).
- Wait for confirmation before starting development.

### 2. **During Development**

- Follow **Clean Architecture** strictly (see [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)).
- Respect the **Dependency Rule** (dependencies flow inward).
- Use correct **terminology** (Spaces, NOT servers; Entries, NOT posts).
- Keep tests up to date.
- Document significant changes.
- Follow **offline-first pattern** for data layer.

### 3. **When Submitting a PR**

- Describe **what** you changed and **why**.
- Reference any related issues.
- Ensure all tests pass (`melos test`).
- Verify code follows linters (`melos analyze` - **zero warnings policy**).
- Include screenshots/videos if UI is affected.
- Use **Conventional Commits** format:
  - `feat:` - New feature
  - `fix:` - Bug fix
  - `docs:` - Documentation
  - `refactor:` - Code refactoring
  - `test:` - Adding/updating tests
  - `chore:` - Maintenance

### 4. **Review**

- The team will review your code.
- Expect feedback, iterations, or rejections.
- **Not all contributions will be accepted**, even if the code is correct.
- We prioritize **aligned vision** over code volume.

---

## What Makes a PR Valuable?

### ✅ Good PRs Include:

- **Clear description** of the problem being solved
- **Context** on why this change matters to Glow's vision
- **Examples** or screenshots if applicable
- **Tests** covering the new functionality
- **Documentation** if required
- **Correct terminology** (Spaces, Entries, Channels, NOT posts, groups, servers)
- **Adherence to architecture** (Clean Architecture layers)

### ❌ Bad PRs Are:

- Features no one requested
- Code without tests
- Breaking changes without justification
- Style changes without value
- Quick fixes without understanding context
- **Using incorrect terminology** (posts, servers, groups)
- **Violating architecture layers** (e.g., putting business logic in UI)

---

## How Was This Tested?

Before submitting, verify:

- [ ] All unit tests pass (`melos test`)
- [ ] No lint errors or warnings (`melos analyze`)
- [ ] Code compiles without warnings
- [ ] If UI, tested on multiple screen sizes (mobile, tablet)
- [ ] If data layer, tested offline-first behavior
- [ ] If backend, tested with real/mock Supabase data

---

## PR Checklist

Before submitting a PR, confirm:

- [ ] Code follows **Clean Architecture** (domain/data/presentation separation)
- [ ] Uses **correct terminology** (Spaces, Entries, Channels, Masks)
- [ ] Tests have been added/updated
- [ ] Documentation has been updated if necessary
- [ ] All tests pass locally (`melos test`)
- [ ] Zero lint warnings (`melos analyze`)
- [ ] PR has a **clear and descriptive title** (Conventional Commits format)
- [ ] Related issues are referenced (if applicable)
- [ ] No breaking changes (or clearly documented if unavoidable)

---

## Code Standards

### Architecture

- **Clean Architecture:** strict layer separation
  - **Domain** - Pure Dart, business logic, entities, use cases
  - **Data** - Repository implementations, DTOs, data sources, Isar models
  - **Presentation** - UI, widgets, state management (Riverpod)
- **Dependency rule:** dependencies point **inward only**
  - ✅ Presentation → Domain → Data → Infrastructure
  - ❌ Domain → Data
  - ❌ Data → Presentation
- **Use cases:** one use case per business operation
- **Repositories:** abstract interfaces in Domain, implementations in Data

### Offline-First Pattern

All data operations must follow the **offline-first pattern**:

```dart
// Repository Implementation
@override
Future<Either<Failure, List<Space>>> getSpaces() async {
  try {
    // 1. Return local data immediately (Isar)
    final localSpaces = await localDataSource.getSpaces();
    
    // 2. Sync in background (fire-and-forget)
    _syncSpacesInBackground();
    
    return Right(localSpaces);
  } catch (e) {
    return Left(CacheFailure(e.toString()));
  }
}

@override
Future<Either<Failure, Space>> createSpace(params) async {
  // 1. Save locally with pending sync flag
  final localSpace = await localDS.createSpace(params, isPending: true);
  
  // 2. Queue for sync
  await syncQueue.enqueue(SyncOperation(...));
  
  // 3. Return immediately
  return Right(localSpace);
}
```

See [`docs/OFFLINE_FIRST_STRATEGY.md`](docs/OFFLINE_FIRST_STRATEGY.md) for details.

### Naming Conventions

```dart
// Features
lib/features/{feature}/
  ├── data/
  │   ├── datasources/
  │   ├── models/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   ├── repositories/
  │   └── usecases/
  └── presentation/
      ├── pages/
      ├── widgets/
      └── providers/

// Files
{name}_repository.dart           # Repository interface (domain)
{name}_repository_impl.dart      # Repository implementation (data)
{name}_use_case.dart             # Use case (domain)
{name}_provider.dart             # Riverpod provider (presentation)
{name}_state.dart                # State class (presentation)
{name}_dto.dart                  # Data Transfer Object (data)
{name}_isar_model.dart           # Isar collection model (data)
```

### Code Style

- Use `Either<Failure, T>` for operations that may fail
- Riverpod providers with `@riverpod` code generation
- Freezed for immutable models (`@freezed`)
- Repository pattern for data access
- Document public methods and complex classes
- Prefer `const` constructors
- Use explicit types, avoid `dynamic`

### Terminology Enforcement

In code comments, docs, and variable names:

- ✅ **Spaces** - Immersive communities
- ✅ **Entries** - Block-based content
- ✅ **Channels** - Composite areas
- ✅ **Masks** - Per-channel identity
- ❌ NEVER: posts, groups, servers, communities (for Spaces)

---

## Testing

### Required Tests

- **Unit:** business logic, use cases, repositories
- **Widget:** UI components
- **Integration:** complete flows (optional but recommended)

### Test Structure

```dart
void main() {
  group('UseCase', () {
    late UseCase useCase;
    late MockRepository mockRepository;

    setUp(() {
      mockRepository = MockRepository();
      useCase = UseCase(mockRepository);
    });

    test('should return success when...', () async {
      // Arrange
      when(() => mockRepository.method()).thenAnswer((_) async => Right(data));

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result.isRight(), true);
    });
  });
}
```

---

## Code Review

### What We Look For

- Code follows Clean Architecture
- Appropriate tests exist
- Clear and maintainable code
- Respects existing patterns
- No breaking changes without justification

### Review Process

1. Initial review within 48-72 hours
2. Feedback and requested changes
3. Iterations until acceptance
4. Merge to main

---

## Communication

### Channels

- **Issues:** for bugs, specific requests, or technical discussions
- **Discussions:** for ideas, general questions, or feedback
- **PR comments:** for specific code review

### Language

- Code, commits, and technical documentation: **English**
- User-facing content: **Spanish** (may change in the future)

---

## Recognition

Significant contributions will be:

- Credited in the repository
- Acknowledged in release notes
- Considered for future participation in the project

**Participation is not automatic**, but substantial work will be recognized.

---

## Contribution Rejection

Not all contributions will be accepted, even if well-executed. We may reject if:

- It doesn't align with the project's vision
- It introduces unnecessary complexity
- It solves a problem that doesn't exist
- There's a better alternative already planned
- It conflicts with the product roadmap

**This is not personal.** It's part of maintaining a product with clear direction.

---

## Frequently Asked Questions

### Can I fork Glow?

No. The code is proprietary. You can contribute, but not redistribute or fork.

### Can I use Glow's code in my project?

No, without explicit authorization.

### How will my contributions be recognized?

Significant contributions will be credited and may lead to participation agreements.

### Who decides what gets merged?

The core team, based on vision, quality, and project fit.

### What if I disagree with a decision?

You can express your opinion respectfully, but the final decision rests with the team.

---

## Final Principles

- **Quality over quantity**
- **Clear vision over consensus**
- **Sustainable growth over hype**
- **Real impact over metrics**

If you share these principles, we'd love to work together.

---

**Thank you for your interest in contributing to Glow.**
