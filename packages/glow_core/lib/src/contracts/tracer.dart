/// Contract for performance tracing
abstract class Tracer {
  /// Start a trace with given name
  Trace startTrace(String name);

  /// Record a metric
  void recordMetric(String name, double value);
}

/// Represents an active trace
abstract class Trace {
  /// Name of the trace
  String get name;

  /// Stop the trace
  void stop();

  /// Add custom attribute
  void setAttribute(String key, String value);

  /// Increment a metric
  void incrementMetric(String metricName, [int value = 1]);
}
