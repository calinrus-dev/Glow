/// Contract for clock abstraction (testable time)
abstract class Clock {
  /// Get current DateTime
  DateTime now();

  /// Get current timestamp in milliseconds
  int get millisecondsSinceEpoch => now().millisecondsSinceEpoch;
}

/// Default implementation using system clock
class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now();

  @override
  int get millisecondsSinceEpoch => now().millisecondsSinceEpoch;
}
