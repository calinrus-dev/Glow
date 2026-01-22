import 'package:flutter/material.dart';
import 'package:glow_blocks_engine/glow_blocks_engine.dart';
import '../theme/block_theme.dart';

/// Block widget
class BlockWidget extends StatelessWidget {
  const BlockWidget({
    required this.block,
    this.theme = BlockTheme.light,
    this.onTap,
    super.key,
  });

  final Block block;
  final BlockTheme theme;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(theme.padding),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          border: Border.all(color: theme.borderColor),
          borderRadius: BorderRadius.circular(theme.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              block.type.name,
              style: TextStyle(
                color: theme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (block.type.description != null) ...[
              const SizedBox(height: 4),
              Text(
                block.type.description!,
                style: TextStyle(
                  color: theme.textColor.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
}
