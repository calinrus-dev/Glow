// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:glow_app/main_dev.dart';

void main() {
  testWidgets('Glow App initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GlowApp());

    // Verify that the app displays the expected text
    expect(find.text('Glow App Inicializada'), findsOneWidget);
    expect(find.text('Estructura Monorepo cargada correctamente'), findsOneWidget);

    // Verify that the icon is present
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
  });
}
