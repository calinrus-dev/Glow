import 'package:flutter/material.dart';

import '../shaders/hdr_shader.dart';
import 'colors.dart';

/// Glow visual effects tokens with HDR support
class GlowEffects {
  const GlowEffects._();

  // Blur constants
  static const double blurLow = 8;
  static const double blurMedium = 12;
  static const double blurHigh = 18;
  static const double blurXl = 32;

  /// Soft shadow for depth
  static List<BoxShadow> softShadow({
    Color? color,
    double blur = 24,
    double spread = -6,
    Offset offset = const Offset(0, 12),
  }) =>
      [
        BoxShadow(
          color: color ?? GlowColors.shadow,
          blurRadius: blur,
          spreadRadius: spread,
          offset: offset,
        ),
      ];

  /// Standard glow shadow
  static List<BoxShadow> glowShadow({
    Color? color,
    double blur = 24,
    double spread = 0,
    Offset offset = const Offset(0, 0),
  }) =>
      [
        BoxShadow(
          color: (color ?? GlowColors.primaryGlow).withValues(alpha: 0.28),
          blurRadius: blur,
          spreadRadius: spread,
          offset: offset,
        ),
      ];

  /// HDR-enhanced glow shadow with bloom effect
  static List<BoxShadow> hdrGlowShadow({
    Color? color,
    double blur = 24,
    double spread = 0,
    Offset offset = const Offset(0, 0),
    double intensity = 1.0,
    double bloom = 0.35,
  }) =>
      HdrShader.createHdrShadow(
        color: color ?? GlowColors.primaryGlow,
        blur: blur,
        spread: spread,
        offset: offset,
        intensity: intensity,
        bloom: bloom,
      );

  /// Multi-layer glow for premium effects
  static List<BoxShadow> multiGlow({
    required Color primaryColor,
    Color? secondaryColor,
    double blur = 24,
    double intensity = 1.0,
  }) {
    final secondary = secondaryColor ?? primaryColor;
    return [
      // Outer glow
      BoxShadow(
        color: primaryColor.withValues(alpha: 0.15 * intensity),
        blurRadius: blur * 1.8,
        spreadRadius: 2,
      ),
      // Mid glow
      BoxShadow(
        color: secondary.withValues(alpha: 0.25 * intensity),
        blurRadius: blur * 1.2,
        spreadRadius: 0,
      ),
      // Inner glow
      BoxShadow(
        color: primaryColor.withValues(alpha: 0.4 * intensity),
        blurRadius: blur * 0.6,
        spreadRadius: -2,
      ),
    ];
  }

  /// Animated pulse glow
  static List<BoxShadow> pulseGlow({
    required Color color,
    required double pulseValue,
    double baseBlur = 24,
    double pulseRange = 8,
  }) =>
      [
        BoxShadow(
          color: color.withValues(
            alpha: 0.3 + (pulseValue * 0.2),
          ),
          blurRadius: baseBlur + (pulseValue * pulseRange),
          spreadRadius: pulseValue * 2,
        ),
      ];

  /// Depth shadow for elevated surfaces
  static List<BoxShadow> depthShadow({
    double elevation = 1,
    Color? color,
  }) {
    final baseColor = color ?? GlowColors.shadow;
    return [
      BoxShadow(
        color: baseColor.withValues(alpha: 0.2 * elevation),
        blurRadius: 8 * elevation,
        spreadRadius: -2 * elevation,
        offset: Offset(0, 4 * elevation),
      ),
      BoxShadow(
        color: baseColor.withValues(alpha: 0.1 * elevation),
        blurRadius: 16 * elevation,
        spreadRadius: -4 * elevation,
        offset: Offset(0, 8 * elevation),
      ),
    ];
  }
}
