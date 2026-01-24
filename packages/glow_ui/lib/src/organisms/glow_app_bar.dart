import 'package:flutter/material.dart';

import '../layouts/glow_glass_container.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

/// App bar with glass effect and subtle glow
class GlowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlowAppBar({
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    super.key,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(color: GlowColors.textPrimary);

    return GlowGlassContainer(
      blurSigma: 10,
      backgroundOpacity: 0.7,
      borderColor: GlowColors.border,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              if (leading != null) leading! else const SizedBox(width: 8),
              if (!centerTitle) const SizedBox(width: GlowSpacing.sm),
              Expanded(
                child: Align(
                  alignment:
                      centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: Text(title, style: textStyle),
                ),
              ),
              if (actions != null) ...[
                const SizedBox(width: GlowSpacing.sm),
                ...actions!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);
}
