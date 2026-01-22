# glow_core

Core utilities and shared functionality for Glow Social Operating System.

## Description

This package contains:
- **Contracts**: Interfaces for cross-cutting concerns (logging, crash reporting, etc.)
- **Error Handling**: Failure types, exceptions, and error mapping
- **Types**: Result, Paged, Unit, and other common types
- **Use Cases**: Base use case pattern
- **Utils**: Validators, debouncer, throttler, and utilities

**Note:** This is a Dart-only package (no Flutter dependencies).

## Architecture Rules

- No dependencies on other packages
- Pure Dart only (no Flutter imports)
- Framework-agnostic
- Foundation for all other packages
