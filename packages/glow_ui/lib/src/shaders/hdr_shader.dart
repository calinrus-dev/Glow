import 'package:flutter/material.dart';

/// HDR (High Dynamic Range) shader for enhanced glow effects
/// Provides tone mapping, bloom, and enhanced color saturation
class HdrShader {
  const HdrShader._();

  /// Create HDR gradient with tone mapping
  static Shader createHdrGradient({
    required Color baseColor,
    required Color accentColor,
    required Rect bounds,
    double intensity = 1.0,
    double bloom = 0.3,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    // Enhanced color with HDR-like saturation
    final hdrBase = _enhanceColor(baseColor, intensity, bloom);
    final hdrAccent = _enhanceColor(accentColor, intensity, bloom);

    return LinearGradient(
      colors: [
        hdrBase,
        _blendColors(hdrBase, hdrAccent, 0.5),
        hdrAccent,
      ],
      stops: const [0.0, 0.5, 1.0],
      begin: begin,
      end: end,
    ).createShader(bounds);
  }

  /// Create radial HDR glow
  static Shader createRadialHdrGlow({
    required Color color,
    required Rect bounds,
    required Offset center,
    double radius = 100.0,
    double intensity = 1.0,
    double bloom = 0.4,
  }) {
    final hdrColor = _enhanceColor(color, intensity, bloom);

    return RadialGradient(
      colors: [
        hdrColor.withValues(alpha: 0.9),
        hdrColor.withValues(alpha: 0.6),
        hdrColor.withValues(alpha: 0.3),
        hdrColor.withValues(alpha: 0),
      ],
      stops: const [0.0, 0.3, 0.6, 1.0],
      center: Alignment(
        (center.dx - bounds.width / 2) / (bounds.width / 2),
        (center.dy - bounds.height / 2) / (bounds.height / 2),
      ),
      radius: radius / (bounds.width / 2),
    ).createShader(bounds);
  }

  /// Create HDR box shadow with bloom effect
  static List<BoxShadow> createHdrShadow({
    required Color color,
    double blur = 24.0,
    double spread = 0.0,
    Offset offset = Offset.zero,
    double intensity = 1.0,
    double bloom = 0.35,
  }) {
    final hdrColor = _enhanceColor(color, intensity, bloom);

    return [
      // Main shadow
      BoxShadow(
        color: hdrColor.withValues(alpha: 0.4 * intensity),
        blurRadius: blur,
        spreadRadius: spread,
        offset: offset,
      ),
      // Bloom layer 1 (inner glow)
      BoxShadow(
        color: hdrColor.withValues(alpha: 0.25 * intensity),
        blurRadius: blur * 0.6,
        spreadRadius: spread - 2,
        offset: offset,
      ),
      // Bloom layer 2 (outer glow)
      BoxShadow(
        color: hdrColor.withValues(alpha: 0.15 * intensity),
        blurRadius: blur * 1.4,
        spreadRadius: spread + 4,
        offset: offset,
      ),
    ];
  }

  /// Enhance color with HDR-like properties
  static Color _enhanceColor(Color color, double intensity, double bloom) {
    final hsl = HSLColor.fromColor(color);

    // Increase saturation for HDR effect
    final enhancedSaturation =
        (hsl.saturation * (1.0 + bloom * 0.5)).clamp(0.0, 1.0);

    // Slight brightness boost
    final enhancedLightness =
        (hsl.lightness * (1.0 + intensity * 0.1)).clamp(0.0, 1.0);

    return hsl
        .withSaturation(enhancedSaturation)
        .withLightness(enhancedLightness)
        .toColor();
  }

  /// Blend two colors
  static Color _blendColors(Color a, Color b, double t) {
    return Color.lerp(a, b, t)!;
  }

  /// Create HDR paint with tone mapping
  static Paint createHdrPaint({
    required Color color,
    double intensity = 1.0,
    double bloom = 0.3,
    PaintingStyle style = PaintingStyle.fill,
    double strokeWidth = 1.0,
    Shader? shader,
  }) {
    final hdrColor = _enhanceColor(color, intensity, bloom);

    return Paint()
      ..color = hdrColor
      ..style = style
      ..strokeWidth = strokeWidth
      ..shader = shader
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, bloom * 10);
  }

  /// Apply HDR tone mapping to a color
  static Color toneMap(Color color, {double exposure = 1.0}) {
    // Simple Reinhard tone mapping
    final r = (color.red / 255.0) * exposure;
    final g = (color.green / 255.0) * exposure;
    final b = (color.blue / 255.0) * exposure;

    final toneMappedR = (r / (1.0 + r)).clamp(0.0, 1.0);
    final toneMappedG = (g / (1.0 + g)).clamp(0.0, 1.0);
    final toneMappedB = (b / (1.0 + b)).clamp(0.0, 1.0);

    return Color.fromRGBO(
      (toneMappedR * 255).round(),
      (toneMappedG * 255).round(),
      (toneMappedB * 255).round(),
      color.opacity,
    );
  }
}
