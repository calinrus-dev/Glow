# glow_blocks_flutter

Flutter widgets for rendering block-based **Entries** (NOT posts) in Glow.

## Overview

Provides the UI layer for Glow's block-based content system. Works with `glow_blocks_engine` to render Entries across all contexts:
- Global feed entries
- Channel entries (within Spaces)
- User-created entries
- Space entries (from Space staff)

## Architecture

```
glow_blocks_engine (Core logic - Pure Dart)
        ↑
        │ uses
        │
glow_blocks_flutter (UI rendering - Flutter)
```

## Features

### **Block Widgets**
- `TextBlockWidget` - Formatted text with styling
- `ImageBlockWidget` - Images with captions
- `VideoBlockWidget` - Embedded video
- `CodeBlockWidget` - Syntax-highlighted code
- `EmbedBlockWidget` - External embeds (YouTube, Twitter, etc.)
- `DividerBlockWidget` - Visual separators

### **Composition**
- `EntryRenderer` - Renders complete Entry from blocks
- `BlockComposer` - Interactive block editor
- Drag-and-drop block reordering
- Block toolbar and actions

### **Theme**
- Block styling system
- Space-specific block themes
- Dark/light mode support
- Syntax highlighting themes

**Note:** Flutter package - depends on `glow_blocks_engine`.

## Dependencies

- `flutter` - UI framework
- `glow_blocks_engine` - Block logic
- `glow_ui` - Design system
- `flutter_syntax_view` - Code highlighting

## Usage

```dart
import 'package:glow_blocks_flutter/glow_blocks_flutter.dart';

// Render entry
EntryRenderer(
  entry: entry,
  theme: BlockTheme.fromSpace(space),
  onBlockTap: (block) => handleBlockTap(block),
)

// Edit entry
BlockComposer(
  initialBlocks: entry.blocks,
  onChanged: (blocks) => updateEntry(blocks),
)
```
