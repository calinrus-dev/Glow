import 'channel.dart';

class RealtimeClient {
  const RealtimeClient({
    required this.url,
  });

  final String url;

  /// Connect to real-time server
  Future<void> connect() async {
    // TODO: Implement WebSocket connection
  }

  /// Disconnect from server
  Future<void> disconnect() async {
    // TODO: Implement disconnect
  }

  /// Subscribe to channel
  Future<RealtimeChannel> channel(String name) async {
    // TODO: Implement channel subscription
    return RealtimeChannel(name: name);
  }

  /// Get connection status
  Future<ConnectionStatus> getStatus() async {
    // TODO: Implement status check
    return ConnectionStatus.disconnected;
  }
}

/// Connection status
enum ConnectionStatus {
  connected,
  connecting,
  disconnected,
  error,
}
