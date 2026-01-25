import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/spacing.dart';

/// Skeleton loader with shimmer effect
class GlowSkeleton extends StatefulWidget {
  const GlowSkeleton({
    this.width,
    this.height,
    this.borderRadius,
    this.child,
    super.key,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? child;

  @override
  State<GlowSkeleton> createState() => _GlowSkeletonState();
}

class _GlowSkeletonState extends State<GlowSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        widget.borderRadius ?? BorderRadius.circular(GlowSpacing.sm);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
              colors: const [
                GlowColors.backgroundCard,
                GlowColors.backgroundElevated,
                GlowColors.backgroundCard,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}

/// Skeleton text line
class GlowSkeletonText extends StatelessWidget {
  const GlowSkeletonText({
    this.width,
    this.height = 16,
    this.borderRadius,
    super.key,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GlowSkeleton(
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }
}

/// Skeleton avatar
class GlowSkeletonAvatar extends StatelessWidget {
  const GlowSkeletonAvatar({
    this.size = 40,
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return GlowSkeleton(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }
}

/// Skeleton card
class GlowSkeletonCard extends StatelessWidget {
  const GlowSkeletonCard({
    this.width,
    this.height = 120,
    this.padding,
    super.key,
  });

  final double? width;
  final double height;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return GlowSkeleton(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(GlowSpacing.md),
      child: padding != null
          ? Padding(
              padding: padding!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlowSkeletonText(width: width != null ? width! * 0.6 : 120),
                  const SizedBox(height: GlowSpacing.sm),
                  GlowSkeletonText(width: width != null ? width! * 0.4 : 80),
                ],
              ),
            )
          : null,
    );
  }
}
