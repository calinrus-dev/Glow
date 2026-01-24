import 'dart:ui';

import 'package:flutter/material.dart';

import '../shaders/glow_stroke.dart';
import '../theme/colors.dart';
import '../theme/effects.dart';
import '../theme/spacing.dart';

enum GlowButtonVariant { primary, secondary, ghost }

enum GlowButtonSize { sm, md, lg }

/// Primary action button with subtle glow
class GlowButton extends StatefulWidget {
  const GlowButton({
    required this.onPressed,
    this.label,
    this.child,
    this.leadingIcon,
    this.trailingIcon,
    this.leadingWidget,
    this.trailingWidget,
    this.variant = GlowButtonVariant.primary,
    this.size = GlowButtonSize.md,
    this.isLoading = false,
    this.expand = false,
    this.glass = true,
    this.padding,
    this.glowBoost = 1.0,
    super.key,
  }) : assert(label != null || child != null, 'Provide label or child');

  final VoidCallback? onPressed;
  final String? label;
  final Widget? child;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final GlowButtonVariant variant;
  final GlowButtonSize size;
  final bool isLoading;
  final bool expand;
  final bool glass;
  final EdgeInsetsGeometry? padding;
  final double glowBoost;

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isPressed = false;
  Offset? _haloOffset;
  bool _showHalo = false;

  void _setHovered(bool value) => setState(() => _isHovered = value);

  void _setFocused(bool value) => setState(() => _isFocused = value);

  void _setPressed(bool value) => setState(() => _isPressed = value);

  void _showHaloAt(Offset offset) {
    setState(() {
      _haloOffset = offset;
      _showHalo = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null && !widget.isLoading;
    final isActive = _isHovered || _isFocused || _isPressed;

    final palette = _ButtonPalette.resolve(
      variant: widget.variant,
      enabled: enabled,
      active: isActive,
    );
    final padding = widget.padding ?? _ButtonMetrics.padding(widget.size);

    final borderWidth = _isPressed ? 2.4 : (isActive ? 1.5 : 1.2);
    final strokeOpacity = widget.variant == GlowButtonVariant.primary
      ? (_isPressed ? 0.95 : (isActive ? 0.7 : 0.6))
      : (_isPressed ? 0.8 : (isActive ? 0.55 : 0.45));
    final glowBlur = (_isPressed ? 36.0 : (isActive ? 28.0 : 24.0))
        * widget.glowBoost;
    final scale = _isPressed ? 0.98 : (isActive ? 1.01 : 1.0);

    return FocusableActionDetector(
      onShowHoverHighlight: _setHovered,
      onShowFocusHighlight: _setFocused,
      child: GestureDetector(
        onTapDown: enabled ? (details) {
          _setPressed(true);
          _showHaloAt(details.localPosition);
        } : null,
        onTapUp: enabled ? (details) {
          _setPressed(false);
          Future.delayed(const Duration(milliseconds: 180), () {
            if (mounted) {
              setState(() => _showHalo = false);
            }
          });
        } : null,
        onTapCancel: enabled ? () {
          _setPressed(false);
          Future.delayed(const Duration(milliseconds: 180), () {
            if (mounted) {
              setState(() => _showHalo = false);
            }
          });
        } : null,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutCubic,
          scale: scale,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: palette.background,
              borderRadius: BorderRadius.circular(GlowSpacing.md),
              boxShadow: [
                ...GlowEffects.glowShadow(
                  color: palette.glow,
                  blur: glowBlur,
                ),
                if (enabled)
                  ...GlowEffects.softShadow(blur: 16, spread: -8),
              ],
            ),
            child: GlowStroke(
              radius: GlowSpacing.md,
              strokeWidth: borderWidth,
              color: palette.border,
              opacity: strokeOpacity,
              animate: widget.variant == GlowButtonVariant.primary && enabled,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(GlowSpacing.md),
                child: Stack(
                  children: [
                    if (widget.glass)
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    if (_haloOffset != null)
                      Positioned(
                        left: _haloOffset!.dx - 36,
                        top: _haloOffset!.dy - 36,
                        child: IgnorePointer(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 380),
                            curve: Curves.easeOutExpo,
                            width: _showHalo ? 72 : 0,
                            height: _showHalo ? 72 : 0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: _showHalo
                                  ? GlowEffects.glowShadow(
                                      color: GlowColors.primaryGlow,
                                      blur: 30,
                                    )
                                  : const [],
                            ),
                          ),
                        ),
                      ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: enabled ? widget.onPressed : null,
                        borderRadius: BorderRadius.circular(GlowSpacing.md),
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        child: Padding(
                          padding: padding,
                          child: Row(
                            mainAxisSize: widget.expand
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.leadingWidget != null ||
                                  widget.leadingIcon != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: GlowSpacing.sm,
                                  ),
                                  child: widget.leadingWidget ??
                                      Icon(
                                        widget.leadingIcon,
                                        size: _ButtonMetrics.iconSize(widget.size),
                                        color: palette.foreground,
                                      ),
                                ),
                              if (widget.isLoading)
                                SizedBox(
                                  height: _ButtonMetrics.loaderSize(widget.size),
                                  width: _ButtonMetrics.loaderSize(widget.size),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      palette.foreground,
                                    ),
                                  ),
                                )
                              else
                                Flexible(
                                  child: DefaultTextStyle(
                                    style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: palette.foreground,
                                              shadows: [
                                                Shadow(
                                                  color: GlowColors.primaryGlow
                                                      .withValues(
                                                    alpha:
                                                        _isPressed ? 0.85 : 0.45,
                                                  ),
                                                  blurRadius:
                                                      _isPressed ? 16 : 9,
                                                ),
                                              ],
                                            ) ??
                                        TextStyle(color: palette.foreground),
                                    child: widget.child ??
                                        Text(
                                          widget.label ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                  ),
                                ),
                              if (widget.trailingWidget != null ||
                                  widget.trailingIcon != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: GlowSpacing.sm,
                                  ),
                                  child: widget.trailingWidget ??
                                      Icon(
                                        widget.trailingIcon,
                                        size: _ButtonMetrics.iconSize(widget.size),
                                        color: palette.foreground,
                                      ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonPalette {
  _ButtonPalette({
    required this.background,
    required this.border,
    required this.foreground,
    required this.glow,
  });

  factory _ButtonPalette.resolve({
    required GlowButtonVariant variant,
    required bool enabled,
    required bool active,
  }) => _ButtonPalette(
        background: _resolveBackground(variant, enabled),
        border: _resolveBorder(variant, enabled),
        foreground: GlowColors.textPrimary,
        glow: _resolveGlow(variant, enabled, active),
      );

  final Color background;
  final Color border;
  final Color foreground;
  final Color glow;

  static Color _resolveBackground(
    GlowButtonVariant variant,
    bool enabled,
  ) {
    return Colors.transparent;
  }

  static Color _resolveBorder(
    GlowButtonVariant variant,
    bool enabled,
  ) {
    final base = enabled ? 1.0 : 0.5;

    switch (variant) {
      case GlowButtonVariant.primary:
        return GlowColors.accentPrimary.withValues(alpha: 0.9 * base);
      case GlowButtonVariant.secondary:
        return GlowColors.secondaryGlow.withValues(alpha: 0.6 * base);
      case GlowButtonVariant.ghost:
        return GlowColors.accentPrimary.withValues(alpha: 0.6 * base);
    }
  }

  static Color _resolveGlow(
    GlowButtonVariant variant,
    bool enabled,
    bool active,
  ) {
    final base = enabled ? 1.0 : 0.5;
    final intensity = active ? 0.95 : 0.7;

    switch (variant) {
      case GlowButtonVariant.primary:
        return GlowColors.accentPrimary.withValues(alpha: intensity * base);
      case GlowButtonVariant.secondary:
        return GlowColors.secondaryGlow.withValues(alpha: 0.5 * base);
      case GlowButtonVariant.ghost:
        return GlowColors.accentPrimary.withValues(alpha: 0.5 * base);
    }
  }
}

class _ButtonMetrics {
  const _ButtonMetrics._();

  static EdgeInsetsGeometry padding(GlowButtonSize size) {
    switch (size) {
      case GlowButtonSize.sm:
        return const EdgeInsets.symmetric(
          horizontal: GlowSpacing.md,
          vertical: GlowSpacing.sm,
        );
      case GlowButtonSize.md:
        return const EdgeInsets.symmetric(
          horizontal: GlowSpacing.lg,
          vertical: GlowSpacing.md,
        );
      case GlowButtonSize.lg:
        return const EdgeInsets.symmetric(
          horizontal: GlowSpacing.xl,
          vertical: GlowSpacing.md,
        );
    }
  }

  static double iconSize(GlowButtonSize size) {
    switch (size) {
      case GlowButtonSize.sm:
        return 16;
      case GlowButtonSize.md:
        return 18;
      case GlowButtonSize.lg:
        return 20;
    }
  }

  static double loaderSize(GlowButtonSize size) {
    switch (size) {
      case GlowButtonSize.sm:
        return 14;
      case GlowButtonSize.md:
        return 16;
      case GlowButtonSize.lg:
        return 18;
    }
  }
}
