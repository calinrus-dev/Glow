# glow_blocks_engine

Block-based content engine for Glow **Entries** (NOT posts).

## Overview

Powers Glow's **Entries** - block-based content that exists across multiple contexts:

- Global feed entries
- Channel entries (within Spaces)
- User-created entries
- Space entries (from Space staff)

Think Notion-like blocks, but for social content.

## Features

### **Domain Models**

- Block types: Text, Image, Video, Embed, Code, Divider, etc.
- Block attributes: Styling, alignment, metadata
- Block composition and nesting

### **Parser**

- Block validation
- Composition rules
- Nested block handling

### **Codecs**

- JSON serialization/deserialization
- Markdown conversion
- HTML export

**Note:** Pure Dart package (no Flutter dependencies). UI rendering is in `glow_blocks_flutter`.

## Architecture

```
glow_blocks_engine (Core logic - Pure Dart)
        ↑
        │ uses
        │
glow_blocks_flutter (UI rendering - Flutter)
```

## Usage

```dart
import 'package:glow_blocks_engine/glow_blocks_engine.dart';

// Create blocks
final textBlock = TextBlock(
  content: 'Welcome to this Space!',
  style: TextBlockStyle.heading1,
);

final imageBlock = ImageBlock(
  url: 'https://example.com/image.png',
  caption: 'Space banner',
);

// Compose entry
final entry = Entry(
  blocks: [textBlock, imageBlock],
);

// Serialize
final json = entry.toJson();
```
