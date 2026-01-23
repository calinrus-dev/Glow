import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/effects.dart';

/// Icon with optional subtle glow
class GlowIcon extends StatelessWidget {
  const GlowIcon({
    required this.icon,
    this.size,
    this.color,
    this.glow = false,
    this.glowColor,
    super.key,
  });

  final IconData icon;
  final double? size;
  final Color? color;
  final bool glow;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? GlowColors.textSecondary;

    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: glow
            ? GlowEffects.glowShadow(
                color: glowColor ?? GlowColors.primaryGlow,
                blur: 20,
              )
            : const [],
      ),
      child: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
    );
  }
}
