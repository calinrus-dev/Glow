import 'dart:math';

/// Simple UUID generator (v4)
class UuidGenerator {
  const UuidGenerator._();

  static final Random _random = Random();

  /// Generate a v4 UUID
  static String generate() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));

    // Set version (4) and variant bits
    bytes[6] = (bytes[6] & 0x0F) | 0x40;
    bytes[8] = (bytes[8] & 0x3F) | 0x80;

    return _formatUuid(bytes);
  }

  static String _formatUuid(List<int> bytes) {
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-'
        '${hex.substring(20, 32)}';
  }
}
