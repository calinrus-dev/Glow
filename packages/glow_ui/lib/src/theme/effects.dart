import 'package:flutter/material.dart';

import 'colors.dart';

/// Glow visual effects tokens
class GlowEffects {
  const GlowEffects._();

  static const double blurLow = 8;
  static const double blurMedium = 12;
  static const double blurHigh = 18;

  static List<BoxShadow> softShadow({
    Color? color,
    double blur = 24,
    double spread = -6,
    Offset offset = const Offset(0, 12),
  }) => [
        BoxShadow(
          color: color ?? GlowColors.shadow,
          blurRadius: blur,
          spreadRadius: spread,
          offset: offset,
        ),
      ];

  static List<BoxShadow> glowShadow({
    Color? color,
    double blur = 24,
    double spread = 0,
    Offset offset = const Offset(0, 0),
  }) => [
        BoxShadow(
          color: (color ?? GlowColors.primaryGlow).withValues(alpha: 0.28),
          blurRadius: blur,
          spreadRadius: spread,
          offset: offset,
        ),
      ];
}
