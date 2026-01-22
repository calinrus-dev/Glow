/// Connectivity status
enum ConnectivityStatus {
  /// Connected to network
  connected,

  /// Disconnected from network
  disconnected,

  /// Unknown connectivity state
  unknown,
}

/// Contract for network connectivity monitoring
abstract class Connectivity {
  /// Get current connectivity status
  Future<ConnectivityStatus> get status;

  /// Stream of connectivity changes
  Stream<ConnectivityStatus> get onStatusChanged;

  /// Check if currently connected
  Future<bool> get isConnected async {
    final currentStatus = await status;
    return currentStatus == ConnectivityStatus.connected;
  }
}
