import 'package:flutter/material.dart';

import '../atoms/glow_surface.dart';
import '../layouts/glow_glass_container.dart';
import '../shaders/glow_shader.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/glow_theme_variants.dart';
import '../theme/spacing.dart';

/// Card with optional glass effect and HDR support
class GlowCard extends StatefulWidget {
  const GlowCard({
    required this.child,
    this.onTap,
    this.padding,
    this.isGlass = true,
    this.showGlow = true,
    this.glowColor,
    this.elevated = false,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool isGlass;
  final bool showGlow;
  final Color? glowColor;
  final bool elevated;

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final glowTheme = theme.glowTheme;
    final enableHdr = glowTheme?.enableHdr ?? false;
    final glowIntensity = theme.glowIntensity;

    final isActive = _isHovered || widget.onTap != null;
    final glowColor = widget.glowColor ?? GlowColors.primaryGlow;

    final content = Padding(
      padding: widget.padding ?? const EdgeInsets.all(GlowSpacing.md),
      child: widget.child,
    );

    Widget cardChild = widget.isGlass
        ? GlowGlassContainer(
            child: content,
          )
        : GlowSurface(
            backgroundColor: GlowColors.backgroundCard,
            child: content,
          );

    // Add glow effect
    if (widget.showGlow && (glowTheme?.enableGlow ?? true) && isActive) {
      cardChild = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GlowSpacing.md),
          boxShadow: [
            ...GlowEffects.glowShadow(
              color: glowColor,
              blur: 20 * glowIntensity,
            ),
            if (widget.elevated)
              ...GlowEffects.softShadow(blur: 16, spread: -8),
          ],
        ),
        child: cardChild,
      );
    }

    // Apply HDR effect if enabled
    if (enableHdr && widget.showGlow && isActive) {
      cardChild = ShaderMask(
        shaderCallback: (Rect bounds) => GlowShader.createHdrGlowGradient(
          baseColor: glowColor,
          accentColor: glowColor,
          bounds: bounds,
          intensity: glowIntensity * 0.6,
          bloom: 0.3,
        ),
        blendMode: BlendMode.srcATop,
        child: cardChild,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(GlowSpacing.md),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()..scale(_isHovered ? 1.01 : 1.0),
            child: cardChild,
          ),
        ),
      ),
    );
  }
}
