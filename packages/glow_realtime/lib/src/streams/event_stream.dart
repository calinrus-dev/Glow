/// Event stream for real-time updates
class EventStream {
  const EventStream();

  /// Stream of events
  Stream<RealtimeEvent> get events {
    // TODO: Implement actual event stream
    return const Stream.empty();
  }

  /// Filter events by type
  Stream<RealtimeEvent> byType(String type) => events.where((event) => event.type == type);
}

/// Real-time event
class RealtimeEvent {
  const RealtimeEvent({
    required this.type,
    required this.payload,
    required this.timestamp,
  });

  final String type;
  final Map<String, dynamic> payload;
  final DateTime timestamp;
}
