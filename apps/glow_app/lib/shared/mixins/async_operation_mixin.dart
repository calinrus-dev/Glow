import 'package:flutter/widgets.dart';

/// Mixin for handling async operations with loading states.
mixin AsyncOperationMixin<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Executes an async operation with loading state management.
  Future<R?> executeAsync<R>({
    required Future<R> Function() operation,
    void Function()? onStart,
    void Function(R result)? onSuccess,
    void Function(Object error, StackTrace stack)? onError,
    void Function()? onFinally,
  }) async {
    if (_isLoading) return null;

    try {
      setState(() => _isLoading = true);
      onStart?.call();

      final result = await operation();
      onSuccess?.call(result);
      return result;
    } catch (error, stack) {
      onError?.call(error, stack);
      return null;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
      onFinally?.call();
    }
  }
}
