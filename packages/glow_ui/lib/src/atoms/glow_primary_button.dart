import 'package:flutter/material.dart';

import 'glow_button.dart';

/// Primary glass button with stronger glow
class GlowPrimaryButton extends StatelessWidget {
  const GlowPrimaryButton({
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.expand = true,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) => GlowButton(
        onPressed: onPressed,
        label: label,
        isLoading: isLoading,
        expand: expand,
        variant: GlowButtonVariant.primary,
        glowBoost: 1.3,
      );
}
