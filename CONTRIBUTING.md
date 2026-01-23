# Contributing Guide - Glow

## Before Contributing

Glow is a **collaborative but not open source** project. This means:

- **The code is not free** to redistribute, fork, or use commercially without authorization.
- **We accept contributions** from people aligned with the project's vision.
- **Significant contributions may translate into future participation** under clear agreements as the project matures.

This approach allows us to build Glow with quality, clear direction, and sustainability, while remaining open to serious and committed collaborators.

---

## Who Can Contribute?

Anyone who:

- **Shares Glow's vision** as a platform to inhabit digital communities.
- **Has experience** in development (Flutter, Dart, backend), product design, UX/UI, or related areas.
- **Seeks to create real impact**, not just add commits.
- **Understands this is a product with commercial purposes**, not an academic or personal project.

---

## Content Architecture (CRITICAL - Use Correct Terminology)

Glow has a specific content architecture. **ALWAYS use these terms**:

### ✅ Correct Terms
- **Global** - Top-level feed and social layer
- **Spaces** - Immersive communities (NOT "servers", "groups", or "communities")
- **Channels** - Composite areas (chats + entries) within Spaces
- **Entries** - Block-based content (NOT "posts")
- **Masks** - Per-channel identity customization

### ❌ NEVER Use
- "posts" → Use **Entries**
- "groups" (for Spaces) → Use **Spaces**
- "servers" → Use **Spaces**
- "communities" (when referring to Spaces) → Use **Spaces**
- "messages" (for entries) → Use **Entries**

---

## Types of Accepted Contributions

### 1. **Code**
   - Feature implementation (Global feed, Spaces, Channels, Entries)
   - Architecture improvements
   - Performance optimization
   - Tests (unit, integration, widget)

### 2. **Design**
   - Design system
   - User experience
   - Visual identity for Spaces
   - Iconography and visual resources

### 3. **Product**
   - Flow definition
   - Functional specifications
   - Feature documentation
   - User research

### 4. **Infrastructure**
   - CI/CD
   - Monitoring and observability
   - Backend and APIs
   - Realtime systems

---

## Contribution Process

### 1. **Before Starting**
   - **Contact first.** Don't submit PRs without prior agreement.
   - Open an **issue or discussion** explaining what you want to do and why.
   - Wait for confirmation before starting development.

### 2. **During Development**
   - Follow the defined architecture (Clean Architecture).
   - Respect project code conventions.
   - Keep tests up to date.
   - Document significant changes.

### 3. **When Submitting a PR**
   - Describe **what** you changed and **why**.
   - Ensure all tests pass.
   - Verify code follows configured linters.
   - Include screenshots if UI is affected.

### 4. **Review**
   - The team will review your code.
   - Expect feedback, iterations, or rejections.
   - **Not all contributions will be accepted**, even if the code is correct.

---

## What Makes This PR Valuable?

Good PRs include:

- **Clear description** of the problem being solved
- **Context** on why this change matters
- **Examples** or screenshots if applicable
- **Tests** covering the new functionality
- **Documentation** if required

Bad PRs are:

- Features no one requested
- Code without tests
- Breaking changes without justification
- Style changes without value
- Quick fixes without understanding context

---

## How Was This Tested?

Before submitting, verify:

- All unit tests pass (`melos run test`)
- No lint errors (`melos run analyze`)
- Code compiles without warnings
- If UI, test on multiple devices/platforms
- If backend, test with real data

---

## Checklist

Before submitting a PR, confirm:

- [ ] Code follows the project's style guide
- [ ] Tests have been added/updated
- [ ] Documentation has been updated if necessary
- [ ] All tests pass locally
- [ ] No lint errors
- [ ] The PR has a clear and descriptive title
- [ ] Related issues are referenced (if applicable)

---

## Code Standards

### Architecture
- **Clean Architecture:** strict layer separation (domain, data, presentation)
- **Dependency rule:** dependencies point inward
- **Use cases:** one use case per business operation
- **Repositories:** abstract data sources

### Naming Conventions
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

### Code Style
- Use `Either<Failure, T>` for operations that may fail
- Riverpod providers with code generation
- Freezed for immutable models
- Repository pattern for data access
- Document public methods and complex classes

### Important Terminology
- **Spaces** - Communities within Glow
- **Channels** - Functional areas within Spaces
- **Canvases** - Content creation spaces

**Never use:** "posts", "groups", "servers", "communities" (use Spaces instead)

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
