import 'package:flutter/material.dart';

/// Glow primary button
class GlowButton extends StatelessWidget {
  const GlowButton({
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(label),
    );
}

/// Glow outlined button
class GlowOutlinedButton extends StatelessWidget {
  const GlowOutlinedButton({
    required this.onPressed,
    required this.label,
    super.key,
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) => OutlinedButton(
      onPressed: onPressed,
      child: Text(label),
    );
}
