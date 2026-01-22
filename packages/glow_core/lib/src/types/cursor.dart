/// Cursor for cursor-based pagination
class Cursor {
  const Cursor({
    required this.value,
    this.direction = CursorDirection.after,
  });

  final String value;
  final CursorDirection direction;

  @override
  String toString() => 'Cursor(value: $value, direction: $direction)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cursor &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          direction == other.direction;

  @override
  int get hashCode => Object.hash(value, direction);
}

/// Direction for cursor pagination
enum CursorDirection {
  /// Get items after cursor
  after,

  /// Get items before cursor
  before,
}
