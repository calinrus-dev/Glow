import 'package:glow_blocks_engine/glow_blocks_engine.dart';
import 'package:test/test.dart';

void main() {
  group('BlockCodec', () {
    late BlockCodec codec;

    setUp(() {
      codec = const BlockCodec();
    });

    test('encodes and decodes block', () {
      const block = Block(
        id: '1',
        type: BlockType(name: 'test', category: 'core'),
        inputs: [],
        outputs: [],
      );

      final encoded = codec.encode(block);
      final decoded = codec.decode(encoded);

      expect(decoded.id, equals(block.id));
      expect(decoded.type.name, equals(block.type.name));
    });
  });
}
