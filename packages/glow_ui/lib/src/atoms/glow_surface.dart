import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Base surface for Glow UI
class GlowSurface extends StatelessWidget {
  const GlowSurface({
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.glow = false,
    this.elevation = 0,
    this.accentedBorder = false,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool glow;
  final double elevation;
  final bool accentedBorder;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(GlowSpacing.md);
    final color = backgroundColor ?? GlowColors.backgroundElevated;
    final border = borderColor ?? GlowColors.border;

    final base = Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
        border: Border.all(color: border),
        boxShadow: [
          if (elevation > 0) ...GlowEffects.softShadow(blur: 18, spread: -8),
          if (glow) ...GlowEffects.glowShadow(),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(GlowSpacing.md),
          child: child,
        ),
      ),
    );

    if (!accentedBorder) {
      return Container(margin: margin, child: base);
    }

    return Container(
      margin: margin,
      padding: const EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GlowColors.borderAccentStart,
            GlowColors.borderAccentEnd,
          ],
        ),
        boxShadow: GlowEffects.glowShadow(
          color: GlowColors.primaryGlow,
          blur: 20,
        ),
      ),
      child: base,
    );
  }
}
