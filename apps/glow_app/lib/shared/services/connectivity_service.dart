import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

/// Service for monitoring network connectivity.
class ConnectivityService {
  ConnectivityService({
    Connectivity? connectivity,
  }) : _connectivity = connectivity ?? Connectivity() {
    _initialize();
  }

  final Connectivity _connectivity;
  final _connectivityController = BehaviorSubject<bool>.seeded(true);

  /// Stream of connectivity status.
  Stream<bool> get connectivityStream => _connectivityController.stream;

  /// Current connectivity status.
  bool get isConnected => _connectivityController.value;

  void _initialize() {
    _connectivity.onConnectivityChanged.listen((result) {
      // Handle List<ConnectivityResult> from connectivity_plus 6.x
      final connected = !result.contains(ConnectivityResult.none);
      _connectivityController.add(connected);
    });
  }

  /// Checks current connectivity status.
  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    final connected = !result.contains(ConnectivityResult.none);
    _connectivityController.add(connected);
    return connected;
  }

  void dispose() {
    _connectivityController.close();
  }
}
