import '../domain/block.dart';
import '../domain/block_type.dart';
import '../domain/connection.dart';

/// Block codec for serialization
class BlockCodec {
  const BlockCodec();

  /// Encode block to JSON
  Map<String, dynamic> encode(Block block) => {
      'id': block.id,
      'type': {
        'name': block.type.name,
        'category': block.type.category,
        if (block.type.description != null) 'description': block.type.description,
      },
      'inputs': block.inputs.map(_encodeConnection).toList(),
      'outputs': block.outputs.map(_encodeConnection).toList(),
      'metadata': block.metadata,
    };

  /// Decode block from JSON
  Block decode(Map<String, dynamic> json) => Block(
      id: json['id'] as String,
      type: BlockType(
        name: json['type']['name'] as String,
        category: json['type']['category'] as String,
        description: json['type']['description'] as String?,
      ),
      inputs: (json['inputs'] as List)
          .map((e) => _decodeConnection(e as Map<String, dynamic>))
          .toList(),
      outputs: (json['outputs'] as List)
          .map((e) => _decodeConnection(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
    );

  Map<String, dynamic> _encodeConnection(Connection conn) => {
      'id': conn.id,
      'block_id': conn.blockId,
      if (conn.connectedTo != null) 'connected_to': conn.connectedTo,
      'type': conn.type.name,
    };

  Connection _decodeConnection(Map<String, dynamic> json) => Connection(
      id: json['id'] as String,
      blockId: json['block_id'] as String,
      connectedTo: json['connected_to'] as String?,
      type: ConnectionType.values.byName(json['type'] as String),
    );
}
