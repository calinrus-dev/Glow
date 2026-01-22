import 'package:glow_core/glow_core.dart';

/// Trace implementation
class TraceImpl implements Trace {
  TraceImpl({required this.name}) : _startTime = DateTime.now();

  @override
  final String name;

  final DateTime _startTime;
  final Map<String, String> _attributes = {};
  final Map<String, int> _metrics = {};

  @override
  void stop() {
    final duration = DateTime.now().difference(_startTime);
    // ignore: avoid_print
    print('Trace [$name] completed in ${duration.inMilliseconds}ms');
  }

  @override
  void setAttribute(String key, String value) {
    _attributes[key] = value;
  }

  @override
  void incrementMetric(String metricName, [int value = 1]) {
    _metrics[metricName] = (_metrics[metricName] ?? 0) + value;
  }
}
