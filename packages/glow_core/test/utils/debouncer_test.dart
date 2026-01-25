import 'package:glow_core/glow_core.dart';
import 'package:test/test.dart';

void main() {
  group('Debouncer', () {
    test('should execute callback after duration', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      debouncer.run(() => callCount++);

      expect(callCount, 0);

      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(callCount, 1);
      debouncer.dispose();
    });

    test('should cancel previous callback when called multiple times',
        () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      debouncer.run(() => callCount++);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      debouncer.run(() => callCount++);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      debouncer.run(() => callCount++);

      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(callCount, 1);
      debouncer.dispose();
    });

    test('should execute each callback if enough time passes', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      debouncer.run(() => callCount++);
      await Future<void>.delayed(const Duration(milliseconds: 150));

      debouncer.run(() => callCount++);
      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(callCount, 2);
      debouncer.dispose();
    });

    test('should not execute callback if cancelled', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      debouncer.run(() => callCount++);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      debouncer.cancel();

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(callCount, 0);
      debouncer.dispose();
    });

    test('should clear timer on dispose', () async {
      final debouncer = Debouncer(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      debouncer.run(() => callCount++);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      debouncer.dispose();

      await Future<void>.delayed(const Duration(milliseconds: 100));

      expect(callCount, 0);
    });
  });
}
