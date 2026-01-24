import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Glow avatar with subtle border and optional active glow
class GlowAvatar extends StatefulWidget {
  const GlowAvatar({
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.isActive = false,
    this.onTap,
    super.key,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  State<GlowAvatar> createState() => _GlowAvatarState();
}

class _GlowAvatarState extends State<GlowAvatar> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.size / 2);
    final interactive = widget.onTap != null;
    final isActive = widget.isActive || _isHovered || _isPressed;
    final scale = _isPressed ? 0.96 : (_isHovered ? 1.02 : 1.0);
    final borderColor = isActive
        ? GlowColors.borderGlow.withValues(alpha: 0.85)
        : GlowColors.borderLight;
    final shadow = isActive
        ? GlowEffects.glowShadow(
            color: GlowColors.primaryGlow,
            blur: _isPressed ? 26 : 20,
          )
        : GlowEffects.softShadow(blur: 12, spread: -6);

    return MouseRegion(
      onEnter: interactive ? (_) => setState(() => _isHovered = true) : null,
      onExit: interactive ? (_) => setState(() => _isHovered = false) : null,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        scale: scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: InkWell(
            onTap: widget.onTap,
            onTapDown:
                interactive ? (_) => setState(() => _isPressed = true) : null,
            onTapCancel:
                interactive ? () => setState(() => _isPressed = false) : null,
            onTapUp:
                interactive ? (_) => setState(() => _isPressed = false) : null,
            borderRadius: radius,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(color: borderColor),
                boxShadow: shadow,
              ),
              child: ClipRRect(
                borderRadius: radius,
                child: widget.imageUrl != null
                    ? Image.network(widget.imageUrl!, fit: BoxFit.cover)
                    : Container(
                        color: GlowColors.backgroundCard,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(GlowSpacing.xs),
                        child: Text(
                          (widget.initials ?? '').toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: GlowColors.textPrimary),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
