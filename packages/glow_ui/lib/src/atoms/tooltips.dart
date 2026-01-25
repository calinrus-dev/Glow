import 'package:flutter/material.dart';

import '../layouts/glow_glass_container.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

/// Tooltip with glow effects
class GlowTooltip extends StatelessWidget {
  const GlowTooltip({
    required this.message,
    this.child,
    this.preferBelow = true,
    this.waitDuration = const Duration(milliseconds: 500),
    this.showDuration = const Duration(seconds: 2),
    this.verticalOffset = 8,
    super.key,
  });

  final String message;
  final Widget? child;
  final bool preferBelow;
  final Duration waitDuration;
  final Duration showDuration;
  final double verticalOffset;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      waitDuration: waitDuration,
      showDuration: showDuration,
      verticalOffset: verticalOffset,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(GlowSpacing.sm),
        boxShadow: GlowEffects.hdrGlowShadow(
          color: GlowColors.primaryGlow,
          blur: 20,
          intensity: 0.8,
        ),
      ),
      textStyle: const TextStyle(
        color: GlowColors.textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      child: child,
    );
  }
}

/// Custom tooltip widget with glass effect
class GlowCustomTooltip extends StatefulWidget {
  const GlowCustomTooltip({
    required this.message,
    this.child,
    this.position = TooltipPosition.bottom,
    this.showDelay = const Duration(milliseconds: 500),
    super.key,
  });

  final String message;
  final Widget? child;
  final TooltipPosition position;
  final Duration showDelay;

  @override
  State<GlowCustomTooltip> createState() => _GlowCustomTooltipState();
}

enum TooltipPosition {
  top,
  bottom,
  left,
  right,
}

class _GlowCustomTooltipState extends State<GlowCustomTooltip> {
  OverlayEntry? _overlayEntry;

  void _show() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => _TooltipOverlay(
        message: widget.message,
        position: widget.position,
        onDismiss: _hide,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        Future.delayed(widget.showDelay, () {
          if (mounted) _show();
        });
      },
      onTapUp: (_) => _hide(),
      onTapCancel: _hide,
      child: widget.child,
    );
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    required this.message,
    required this.position,
    required this.onDismiss,
  });

  final String message;
  final TooltipPosition position;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.transparent),
            ),
            // Tooltip positioned based on position enum
            // This is a simplified version - full implementation would
            // calculate position based on child widget's RenderBox
            Center(
              child: GlowGlassContainer(
                padding: const EdgeInsets.symmetric(
                  horizontal: GlowSpacing.md,
                  vertical: GlowSpacing.sm,
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: GlowColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
