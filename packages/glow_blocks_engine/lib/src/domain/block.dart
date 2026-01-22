import 'block_type.dart';
import 'connection.dart';

/// Block model
class Block {
  const Block({
    required this.id,
    required this.type,
    required this.inputs,
    required this.outputs,
    this.metadata = const {},
  });

  final String id;
  final BlockType type;
  final List<Connection> inputs;
  final List<Connection> outputs;
  final Map<String, dynamic> metadata;

  @override
  String toString() => 'Block(id: $id, type: $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Block && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
