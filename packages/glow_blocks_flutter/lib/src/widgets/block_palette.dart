import 'package:flutter/material.dart';
import 'package:glow_blocks_engine/glow_blocks_engine.dart';

/// Block palette for selecting blocks
class BlockPalette extends StatelessWidget {
  const BlockPalette({
    required this.blockTypes,
    this.onBlockTypeSelected,
    super.key,
  });

  final List<BlockType> blockTypes;
  final ValueChanged<BlockType>? onBlockTypeSelected;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: blockTypes.length,
        itemBuilder: (context, index) {
          final blockType = blockTypes[index];
          return ListTile(
            title: Text(blockType.name),
            subtitle: blockType.description != null
                ? Text(blockType.description!)
                : null,
            onTap: () => onBlockTypeSelected?.call(blockType),
          );
        },
      );
}
