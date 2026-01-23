# glow_realtime

Real-time communication and presence tracking for Glow.

## Overview

Powers Glow's real-time features across Global and Space contexts:
- Global chats (DMs, groups)
- Space chats (Space DMs, private groups)
- Channel chats (text messages in channels)
- Presence tracking (online/offline status)
- Typing indicators
- Live updates for entries

## Features

### **WebSocket Management**
- Connection pooling
- Automatic reconnection
- Heartbeat/ping-pong
- Connection state management

### **Presence Tracking**
- User online/offline status
- Per-Space presence
- Per-Channel presence
- Activity timestamps

### **Event Streams**
- Chat messages (Global, Space, Channel)
- Entry updates
- User presence changes
- Typing indicators
- Channel activity

### **Sync**
- Offline message queuing
- Message delivery confirmation
- Read receipts

**Note:** Pure Dart package (no Flutter dependencies).

## Dependencies

- `web_socket_channel` - WebSocket client
- `glow_core` - Base types
- `rxdart` - Reactive streams

## Usage

```dart
import 'package:glow_realtime/glow_realtime.dart';

// Connect to realtime
final realtime = RealtimeClient(url: 'wss://realtime.glow.app');
await realtime.connect();

// Subscribe to channel messages
realtime.channel('space-123:channel-456').on('message', (data) {
  print('New message: ${data['content']}');
});

// Track presence
final presence = realtime.presence('space-123');
presence.subscribe();
```
