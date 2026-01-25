import 'package:flutter/material.dart';

import '../atoms/buttons.dart';
import '../layouts/glow_glass_container.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';

/// Dialog with glow effects
class GlowDialog extends StatelessWidget {
  const GlowDialog({
    this.title,
    this.content,
    this.actions,
    this.showCloseButton = true,
    this.barrierDismissible = true,
    super.key,
  });

  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final bool showCloseButton;
  final bool barrierDismissible;

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? content,
    List<Widget>? actions,
    bool showCloseButton = true,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: GlowColors.overlay,
      builder: (context) => GlowDialog(
        title: title,
        content: content,
        actions: actions,
        showCloseButton: showCloseButton,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: GlowGlassContainer(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null || showCloseButton)
              Padding(
                padding: const EdgeInsets.all(GlowSpacing.md),
                child: Row(
                  children: [
                    if (title != null)
                      Expanded(
                        child: Text(
                          title!,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: GlowColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    if (showCloseButton)
                      IconButton(
                        icon: const Icon(Icons.close_rounded),
                        color: GlowColors.textSecondary,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                  ],
                ),
              ),
            if (content != null)
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: GlowSpacing.md,
                    right: GlowSpacing.md,
                    bottom: title != null ? 0 : GlowSpacing.md,
                  ),
                  child: DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: GlowColors.textSecondary,
                            ) ??
                        const TextStyle(color: GlowColors.textSecondary),
                    child: content!,
                  ),
                ),
              ),
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(GlowSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Confirmation dialog
class GlowConfirmDialog extends StatelessWidget {
  const GlowConfirmDialog({
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    super.key,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: GlowColors.overlay,
      builder: (context) => GlowConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlowDialog(
      title: title,
      content: Text(message),
      actions: [
        GlowButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(false),
          label: cancelText,
          variant: GlowButtonVariant.ghost,
        ),
        const SizedBox(width: GlowSpacing.sm),
        GlowButton(
          onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
          label: confirmText,
          variant: GlowButtonVariant.primary,
        ),
      ],
    );
  }
}
