import 'package:equatable/equatable.dart';

/// Value Object for Space name with validation
class SpaceName extends Equatable {
  const SpaceName._(this.value);

  final String value;

  /// Creates a SpaceName if valid, otherwise throws
  factory SpaceName(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Space name cannot be empty');
    }
    if (value.length < 2) {
      throw ArgumentError('Space name must be at least 2 characters long');
    }
    if (value.length > 50) {
      throw ArgumentError('Space name cannot exceed 50 characters');
    }
    if (!RegExp(r'^[a-zA-Z0-9\s\-_]+$').hasMatch(value)) {
      throw ArgumentError(
        'Space name can only contain letters, numbers, spaces, hyphens and underscores',
      );
    }
    return SpaceName._(value.trim());
  }

  /// Validates without throwing
  static bool isValid(String value) {
    try {
      SpaceName(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}

/// Value Object for Space slug with validation
class SpaceSlug extends Equatable {
  const SpaceSlug._(this.value);

  final String value;

  /// Creates a SpaceSlug if valid, otherwise throws
  factory SpaceSlug(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Space slug cannot be empty');
    }
    if (value.length < 2) {
      throw ArgumentError('Space slug must be at least 2 characters long');
    }
    if (value.length > 50) {
      throw ArgumentError('Space slug cannot exceed 50 characters');
    }
    if (!RegExp(r'^[a-z0-9\-]+$').hasMatch(value)) {
      throw ArgumentError(
        'Space slug can only contain lowercase letters, numbers and hyphens',
      );
    }
    if (value.startsWith('-') || value.endsWith('-')) {
      throw ArgumentError('Space slug cannot start or end with a hyphen');
    }
    if (value.contains('--')) {
      throw ArgumentError('Space slug cannot contain consecutive hyphens');
    }
    return SpaceSlug._(value);
  }

  /// Creates a slug from a space name
  factory SpaceSlug.fromName(String name) {
    final slug = name
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^a-z0-9\s\-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return SpaceSlug(slug);
  }

  /// Validates without throwing
  static bool isValid(String value) {
    try {
      SpaceSlug(value);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
