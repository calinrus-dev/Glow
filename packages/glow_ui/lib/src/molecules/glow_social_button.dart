import 'package:flutter/material.dart';

import '../atoms/glow_button.dart';
import '../theme/spacing.dart';

/// Social auth button for consistent layout
class GlowSocialButton extends StatelessWidget {
  const GlowSocialButton({
    required this.label,
    required this.icon,
    this.onPressed,
    super.key,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return SizedBox(
      width: double.infinity,
      child: GlowButton(
        onPressed: onPressed,
        size: GlowButtonSize.md,
        variant: GlowButtonVariant.ghost,
        expand: true,
        padding: const EdgeInsets.symmetric(
          horizontal: GlowSpacing.sm,
          vertical: GlowSpacing.sm,
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.visible,
                softWrap: true,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
