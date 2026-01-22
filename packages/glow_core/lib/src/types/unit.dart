/// Represents a void/unit type (absence of value)
class Unit {
  const Unit._();

  static const Unit instance = Unit._();

  @override
  String toString() => 'Unit';
}

/// No parameters placeholder for use cases
class NoParams {
  const NoParams();

  @override
  String toString() => 'NoParams';
}
