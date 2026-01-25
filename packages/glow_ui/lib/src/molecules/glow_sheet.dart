import 'package:flutter/material.dart';

import '../layouts/glow_glass_container.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

/// Bottom sheet with glow effects
class GlowBottomSheet extends StatelessWidget {
  const GlowBottomSheet({
    required this.child,
    this.title,
    this.showDragHandle = true,
    this.isDismissible = true,
    this.isScrollControlled = false,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final String? title;
  final bool showDragHandle;
  final bool isDismissible;
  final bool isScrollControlled;
  final Color? backgroundColor;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showDragHandle = true,
    bool isDismissible = true,
    bool isScrollControlled = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      barrierColor: GlowColors.overlay,
      builder: (context) => GlowBottomSheet(
        child: child,
        title: title,
        showDragHandle: showDragHandle,
        isDismissible: isDismissible,
        isScrollControlled: isScrollControlled,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlowGlassContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(GlowSpacing.lg),
        topRight: Radius.circular(GlowSpacing.lg),
      ),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showDragHandle)
            Padding(
              padding: const EdgeInsets.only(top: GlowSpacing.sm),
              child: Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: GlowColors.textTertiary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(GlowSpacing.md),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: GlowColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          Flexible(child: child),
        ],
      ),
    );
  }
}
