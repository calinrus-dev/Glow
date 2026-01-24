/// Connection between blocks
class Connection {
  const Connection({
    required this.id,
    required this.blockId,
    required this.type,
    this.connectedTo,
  });

  final String id;
  final String blockId;
  final String? connectedTo;
  final ConnectionType type;

  @override
  String toString() => 'Connection(id: $id, type: $type)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Connection && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Connection type
enum ConnectionType {
  input,
  output,
}
