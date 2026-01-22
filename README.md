# Glow - A Social Operating System

> A next-generation social platform built with Flutter and Clean Architecture

## 🌟 Overview

Glow is a revolutionary social operating system that reimagines how people connect, communicate, and collaborate in digital spaces. Built on principles of modularity, scalability, and clean architecture.

## 🏗️ Architecture

This project follows **Clean Architecture** with strict separation of concerns:

```
├── packages/          # Reusable packages
│   ├── glow_core/           # Core utilities and contracts
│   ├── glow_domain/         # Business entities and rules
│   ├── glow_data/           # Data layer (repositories, data sources)
│   ├── glow_ui/             # Design system and UI components
│   ├── glow_blocks_engine/  # Block system core logic
│   ├── glow_blocks_flutter/ # Block UI rendering
│   ├── glow_api/            # API client
│   ├── glow_auth/           # Authentication
│   ├── glow_realtime/       # Real-time communication
│   └── glow_observability/  # Logging and monitoring
│
└── apps/             # Applications
    └── glow_app/          # Main Flutter app
```

## 🚀 Quick Start

### Prerequisites

- Flutter SDK >=3.3.0
- Dart SDK >=3.3.0
- Melos: `dart pub global activate melos`
- Mason: `dart pub global activate mason_cli`

### Setup

```bash
# 1. Clone the repository
git clone <repository-url>
cd glow

# 2. Bootstrap the monorepo
melos bootstrap

# 3. Run the app (development)
cd apps/glow_app
flutter run --flavor dev -t lib/main_dev.dart
```

### Available Commands

```bash
# Analysis and formatting
melos analyze              # Run static analysis
melos format              # Format all code
melos format:check        # Check formatting

# Testing
melos test                # Run all tests
melos test:unit           # Run unit tests only
melos test:integration    # Run integration tests
melos coverage            # Generate coverage report

# Build runner
melos build:runner        # Run code generation
melos build:runner:watch  # Watch for changes

# Clean
melos clean               # Clean all packages
melos clean:deep          # Deep clean

# Architecture verification
melos verify:arch         # Verify architecture rules
melos verify:deps         # Verify dependency rules
```

## 📦 Mason Bricks

Generate boilerplate code using Mason:

```bash
# Generate a new feature
mason make feature --name my_feature

# Generate a new package
mason make package --name my_package

# Generate a usecase
mason make usecase --name MyUsecase

# Generate an entity
mason make entity --name MyEntity

# Generate a repository
mason make repository --name MyRepository
```

## 🏛️ Architecture Rules

1. **Domain Layer** has no dependencies
2. **Data Layer** depends only on Domain
3. **UI packages** never import business logic packages
4. **Features** follow Clean Architecture (data/domain/presentation)
5. **No circular dependencies** allowed

See [ARCHITECTURE.md](docs/ARCHITECTURE.md) for detailed rules.

## 📚 Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Dependency Rules](docs/DEPENDENCY_RULES.md)
- [Contributing](docs/CONTRIBUTING.md)
- [Roadmap](docs/ROADMAP.md)
- [Supabase Schema](docs/SUPABASE_SCHEMA.md)
- [Offline First](docs/OFFLINE_FIRST.md)

## 🧪 Testing Strategy

- **Unit Tests**: Test business logic in isolation
- **Widget Tests**: Test UI components
- **Integration Tests**: Test user flows end-to-end
- **Golden Tests**: Visual regression testing for UI components

## 🛠️ Tech Stack

- **Flutter** - UI framework
- **Riverpod** - State management
- **Go Router** - Navigation
- **Isar** - Local database
- **Supabase** - Backend (Auth, Database, Storage, Realtime)
- **Freezed** - Immutable models
- **Injectable** - Dependency injection

## 📱 Supported Platforms

- ✅ iOS
- ✅ Android
- ✅ Web
- 🚧 macOS (in progress)
- 🚧 Windows (in progress)
- 🚧 Linux (in progress)

## 🤝 Contributing

Please read [CONTRIBUTING.md](docs/CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

Built with ❤️ by the Glow team
