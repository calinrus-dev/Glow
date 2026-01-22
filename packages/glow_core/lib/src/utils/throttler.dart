/// Throttler utility - limits execution frequency
class Throttler {
  Throttler({required this.duration});

  final Duration duration;
  DateTime? _lastExecutionTime;

  /// Run callback if enough time has passed
  void run(void Function() callback) {
    final now = DateTime.now();

    if (_lastExecutionTime == null ||
        now.difference(_lastExecutionTime!) >= duration) {
      _lastExecutionTime = now;
      callback();
    }
  }

  /// Reset throttle state
  void reset() {
    _lastExecutionTime = null;
  }
}
