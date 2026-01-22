import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

/// Glow theme configuration
class GlowTheme {
  const GlowTheme._();

  /// Light theme
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: GlowColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: GlowTypography.textTheme,
      );

  /// Dark theme
  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: GlowColors.primary,
          brightness: Brightness.dark,
        ),
        textTheme: GlowTypography.textTheme,
      );
}
