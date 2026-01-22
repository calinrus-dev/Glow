/// Type-safe identifiers
abstract class Identifier<T> {
  const Identifier(this.value);

  final T value;

  @override
  String toString() => value.toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Identifier<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// String-based ID
class StringId extends Identifier<String> {
  const StringId(super.value);
}

/// Integer-based ID
class IntId extends Identifier<int> {
  const IntId(super.value);
}

/// UUID-based ID
class UuidId extends Identifier<String> {
  const UuidId(super.value);
}
