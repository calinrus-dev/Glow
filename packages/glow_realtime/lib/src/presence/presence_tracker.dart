/// Presence tracker for user status
class PresenceTracker {
  const PresenceTracker();

  /// Track presence for a channel
  Stream<List<PresenceState>> track(String channelId) {
    // TODO: Implement presence tracking
    return const Stream.empty();
  }

  /// Update own presence
  Future<void> updatePresence({
    required String channelId,
    required Map<String, dynamic> state,
  }) async {
    // TODO: Implement presence update
  }
}

/// Presence state
class PresenceState {
  const PresenceState({
    required this.userId,
    required this.state,
  });

  final String userId;
  final Map<String, dynamic> state;
}
