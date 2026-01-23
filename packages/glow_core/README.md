# glow_core

Core utilities and shared functionality for Glow Social Operating System.

## Description

Foundational package providing shared primitives for all other packages.

### Contents

#### **Error Handling**
- `Failure` - Base failure type for domain errors
- `Either<L, R>` - Functional error handling (replaces try/catch)
- Exception types: `NetworkException`, `CacheException`, `ValidationException`

#### **Common Types**
- `Result<T>` - Unified result wrapper
- `Paged<T>` - Paginated data wrapper
- `Unit` - Void replacement for functional programming

#### **Base Contracts**
- `UseCase<Type, Params>` - Base use case pattern
- `Logger` - Logging abstraction
- `CrashReporter` - Crash reporting contract

#### **Utilities**
- Validators (email, username, etc.)
- Debouncer & Throttler
- Extensions (DateTime, String, etc.)

**Note:** This is a **pure Dart** package (no Flutter dependencies).

## Architecture Rules

- ✅ No dependencies on other Glow packages
- ✅ Pure Dart only (no Flutter imports)
- ✅ Framework-agnostic
- ✅ Foundation for all other packages
- ❌ NEVER add Flutter dependencies

## Usage

```dart
import 'package:glow_core/glow_core.dart';

// Error handling with Either
Future<Either<Failure, User>> getUser(String id) async {
  try {
    final user = await api.fetchUser(id);
    return Right(user);
  } catch (e) {
    return Left(NetworkFailure(e.toString()));
  }
}

// Use case pattern
class GetSpacesUseCase extends UseCase<List<Space>, NoParams> {
  @override
  Future<Either<Failure, List<Space>>> call(NoParams params) async {
    return repository.getSpaces();
  }
}
```
