import 'dart:async';

/// Debouncer utility - delays execution until calls stop
class Debouncer {
  Debouncer({required this.duration});

  final Duration duration;
  Timer? _timer;

  /// Run callback after debounce duration
  void run(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(duration, callback);
  }

  /// Cancel pending callback
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Dispose of the debouncer
  void dispose() {
    cancel();
  }
}
