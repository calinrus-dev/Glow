import 'package:flutter/material.dart';

import '../theme/colors.dart';
import 'glow_shader.dart';

/// Stroke-only glow shader for borders with animated pulse
class GlowStroke extends StatefulWidget {
  const GlowStroke({
    required this.child,
    this.radius = 16,
    this.strokeWidth = 1.2,
    this.color,
    this.opacity = 0.5,
    this.animate = true,
    super.key,
  });

  final Widget child;
  final double radius;
  final double strokeWidth;
  final Color? color;
  final double opacity;
  final bool animate;

  @override
  State<GlowStroke> createState() => _GlowStrokeState();
}

class _GlowStrokeState extends State<GlowStroke>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(GlowStroke oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.animate && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) => CustomPaint(
          foregroundPainter: _GlowStrokePainter(
            radius: widget.radius,
            strokeWidth: widget.strokeWidth,
            color: widget.color ?? GlowColors.primaryGlow,
            opacity: widget.opacity,
            pulseValue: widget.animate ? _pulseAnimation.value : 0.5,
          ),
          child: child,
        ),
        child: widget.child,
      );
}

class _GlowStrokePainter extends CustomPainter {
  _GlowStrokePainter({
    required this.radius,
    required this.strokeWidth,
    required this.color,
    required this.opacity,
    required this.pulseValue,
  });

  final double radius;
  final double strokeWidth;
  final Color color;
  final double opacity;
  final double pulseValue;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    // Pulso que aclara el color (aumenta luminosidad)
    final hslColor = HSLColor.fromColor(color);
    final brightenedColor = hslColor
        .withLightness(
          (hslColor.lightness + (pulseValue * 0.15)).clamp(0, 1),
        )
        .toColor();

    // Opacidad pulsante
    final pulsingOpacity = opacity + (pulseValue * 0.2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = GlowShader.createGlowGradient(
        color: brightenedColor,
        opacity: pulsingOpacity,
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GlowStrokePainter oldDelegate) =>
      oldDelegate.radius != radius ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.color != color ||
      oldDelegate.opacity != opacity ||
      oldDelegate.pulseValue != pulseValue;
}
