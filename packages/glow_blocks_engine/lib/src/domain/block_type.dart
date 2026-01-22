/// Block type
class BlockType {
  const BlockType({
    required this.name,
    required this.category,
    this.description,
  });

  final String name;
  final String category;
  final String? description;

  @override
  String toString() => 'BlockType($name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockType && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
