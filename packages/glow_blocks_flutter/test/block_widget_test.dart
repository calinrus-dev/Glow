import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glow_blocks_engine/glow_blocks_engine.dart';
import 'package:glow_blocks_flutter/glow_blocks_flutter.dart';

void main() {
  testWidgets('BlockWidget renders correctly', (tester) async {
    const block = Block(
      id: '1',
      type: BlockType(name: 'Test Block', category: 'test'),
      inputs: [],
      outputs: [],
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BlockWidget(block: block),
        ),
      ),
    );

    expect(find.text('Test Block'), findsOneWidget);
  });
}
