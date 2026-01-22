import 'package:glow_core/glow_core.dart';
import 'trace_impl.dart';

/// Performance monitor implementation
class PerformanceMonitor implements Tracer {
  const PerformanceMonitor();

  @override
  Trace startTrace(String name) => TraceImpl(name: name);

  @override
  void recordMetric(String name, double value) {
    // TODO: Implement metric recording
  }
}
