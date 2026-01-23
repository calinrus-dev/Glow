import 'package:flutter/material.dart';

import '../atoms/glow_surface.dart';
import '../layouts/glow_glass_container.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

/// Card with optional glass effect
class GlowCard extends StatelessWidget {
  const GlowCard({
    required this.child,
    this.onTap,
    this.padding,
    this.isGlass = true,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool isGlass;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ?? const EdgeInsets.all(GlowSpacing.md),
      child: child,
    );

    final cardChild = isGlass
        ? GlowGlassContainer(
            child: content,
          )
        : GlowSurface(
            backgroundColor: GlowColors.backgroundCard,
            child: content,
          );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GlowSpacing.md),
        child: cardChild,
      ),
    );
  }
}
