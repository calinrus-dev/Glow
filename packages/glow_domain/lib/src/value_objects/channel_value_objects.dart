import 'package:equatable/equatable.dart';

/// Value Object for Channel name with validation
class ChannelName extends Equatable {
  const ChannelName._(this.value);

  final String value;

  /// Creates a ChannelName if valid, otherwise throws
  factory ChannelName(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Channel name cannot be empty');
    }
    if (value.length < 2) {
      throw ArgumentError('Channel name must be at least 2 characters long');
    }
    if (value.length > 50) {
      throw ArgumentError('Channel name cannot exceed 50 characters');
    }
    if (!RegExp(r'^[a-zA-Z0-9\s\-_]+$').hasMatch(value)) {
      throw ArgumentError('Channel name can only contain letters, numbers, spaces, hyphens and underscores');
    }
    return ChannelName._(value.trim());
  }

  /// Validates without throwing
  static bool isValid(String value) {
    try {
      ChannelName(value);
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

/// Value Object for Channel slug with validation
class ChannelSlug extends Equatable {
  const ChannelSlug._(this.value);

  final String value;

  /// Creates a ChannelSlug if valid, otherwise throws
  factory ChannelSlug(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Channel slug cannot be empty');
    }
    if (value.length < 2) {
      throw ArgumentError('Channel slug must be at least 2 characters long');
    }
    if (value.length > 50) {
      throw ArgumentError('Channel slug cannot exceed 50 characters');
    }
    if (!RegExp(r'^[a-z0-9\-]+$').hasMatch(value)) {
      throw ArgumentError('Channel slug can only contain lowercase letters, numbers and hyphens');
    }
    if (value.startsWith('-') || value.endsWith('-')) {
      throw ArgumentError('Channel slug cannot start or end with a hyphen');
    }
    if (value.contains('--')) {
      throw ArgumentError('Channel slug cannot contain consecutive hyphens');
    }
    return ChannelSlug._(value);
  }

  /// Creates a slug from a channel name
  factory ChannelSlug.fromName(String name) {
    final slug = name
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[^a-z0-9\s\-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return ChannelSlug(slug);
  }

  /// Validates without throwing
  static bool isValid(String value) {
    try {
      ChannelSlug(value);
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
