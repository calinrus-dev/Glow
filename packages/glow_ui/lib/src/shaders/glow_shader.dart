import 'package:flutter/material.dart';

/// Glow shader effects
class GlowShader {
  const GlowShader._();

  /// Create glow gradient
  static LinearGradient createGlowGradient({
    required Color color,
    double opacity = 0.6,
  }) => LinearGradient(
      colors: [
        color.withValues(alpha: opacity),
        color.withValues(alpha: 0),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
}
