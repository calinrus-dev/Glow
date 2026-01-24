import 'package:flutter_test/flutter_test.dart';
import 'package:glow_core/glow_core.dart';

void main() {
  group('Throttler', () {
    test('should execute callback immediately on first call', () {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);

      expect(callCount, 1);
      throttler.dispose();
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

      throttler.dispose();
    });

    test('should allow execution after duration passes', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);
      expect(callCount, 1);

      await Future<void>.delayed(const Duration(milliseconds: 150));

      throttler.run(() => callCount++);
      expect(callCount, 2);

      throttler.dispose();
    });

    test('should clear timer on dispose', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);
      throttler.dispose();

      await Future<void>.delayed(const Duration(milliseconds: 150));

      // Should not throw
      throttler.run(() => callCount++);
      
      expect(callCount, 2); // Both calls executed (no throttling after dispose)
    });
  });
}
