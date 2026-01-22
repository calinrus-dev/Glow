import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glow_ui/glow_ui.dart';

void main() {
  testWidgets('GlowButton renders correctly', (tester) async {
    var pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GlowButton(
            onPressed: () => pressed = true,
            label: 'Test Button',
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);

    await tester.tap(find.byType(GlowButton));
    expect(pressed, isTrue);
  });
}
