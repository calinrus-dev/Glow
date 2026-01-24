import 'package:test/test.dart';
import 'package:glow_core/glow_core.dart';

void main() {
  group('Throttler', () {
    test('should execute callback immediately on first call', () {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);

      expect(callCount, 1);
    });

    test('should throttle subsequent calls within duration', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);
      throttler.run(() => callCount++);
      throttler.run(() => callCount++);

      expect(callCount, 1);

      await Future<void>.delayed(const Duration(milliseconds: 150));

      throttler.run(() => callCount++);
      expect(callCount, 2);
    });

    test('should allow execution after duration passes', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);
      expect(callCount, 1);

      await Future<void>.delayed(const Duration(milliseconds: 150));

      throttler.run(() => callCount++);
      expect(callCount, 2);
    });

    test('should reset throttle state', () {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);
      expect(callCount, 1);

      // Reset allows immediate execution again
      throttler.reset();
      throttler.run(() => callCount++);

      expect(callCount, 2);
    });
  });
}
