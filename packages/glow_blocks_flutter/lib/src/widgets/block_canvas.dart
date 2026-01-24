import 'package:flutter/material.dart';
import 'package:glow_blocks_engine/glow_blocks_engine.dart';

/// Block canvas for drag-and-drop editing
class BlockCanvas extends StatelessWidget {
  const BlockCanvas({
    required this.blocks,
    this.onBlockTap,
    super.key,
  });

  final List<Block> blocks;
  final ValueChanged<Block>? onBlockTap;

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey[100],
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final block = blocks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () => onBlockTap?.call(block),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(block.type.name),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: blocks.length,
                ),
              ),
            ),
          ],
        ),
      );
}
