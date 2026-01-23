import 'package:flutter/material.dart';

import '../theme/spacing.dart';

/// Row of actions aligned with consistent spacing
class GlowActionRow extends StatelessWidget {
  const GlowActionRow({
    required this.actions,
    this.alignment = MainAxisAlignment.end,
    this.spacing = GlowSpacing.sm,
    this.runSpacing = GlowSpacing.xs,
    super.key,
  });

  final List<Widget> actions;
  final MainAxisAlignment alignment;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) => Wrap(
        alignment: _wrapAlignment(alignment),
        spacing: spacing,
        runSpacing: runSpacing,
        children: actions,
      );

  WrapAlignment _wrapAlignment(MainAxisAlignment alignment) {
    switch (alignment) {
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
      case MainAxisAlignment.start:
        return WrapAlignment.start;
    }
  }
}
