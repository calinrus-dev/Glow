import 'package:glow_core/glow_core.dart';

/// Logger implementation
class LoggerImpl implements Logger {
  const LoggerImpl({
    this.minLevel = LogLevel.debug,
  });

  final LogLevel minLevel;

  @override
  void debug(String message, [Map<String, dynamic>? metadata]) {
    if (_shouldLog(LogLevel.debug)) {
      _log('DEBUG', message, metadata: metadata);
    }
  }

  @override
  void info(String message, [Map<String, dynamic>? metadata]) {
    if (_shouldLog(LogLevel.info)) {
      _log('INFO', message, metadata: metadata);
    }
  }

  @override
  void warning(String message, [Map<String, dynamic>? metadata]) {
    if (_shouldLog(LogLevel.warning)) {
      _log('WARNING', message, metadata: metadata);
    }
  }

  @override
  void error(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  ]) {
    if (_shouldLog(LogLevel.error)) {
      _log('ERROR', message, exception: exception, metadata: metadata);
    }
  }

  @override
  void fatal(
    String message, [
    dynamic exception,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  ]) {
    if (_shouldLog(LogLevel.fatal)) {
      _log('FATAL', message, exception: exception, metadata: metadata);
    }
  }

  bool _shouldLog(LogLevel level) => level.index >= minLevel.index;

  void _log(
    String level,
    String message, {
    dynamic exception,
    Map<String, dynamic>? metadata,
  }) {
    // ignore: avoid_print
    print('[$level] $message${exception != null ? ' | $exception' : ''}');
  }
}
