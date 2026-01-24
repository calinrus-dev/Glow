import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/isar/space_isar_model.dart';
import '../models/isar/sync_operation_isar_model.dart';

/// Service for managing Isar database instance
class IsarService {
  static IsarService? _instance;
  Isar? _isar;

  IsarService._();

  /// Singleton instance
  static IsarService get instance {
    _instance ??= IsarService._();
    return _instance!;
  }

  /// Get Isar instance (throws if not initialized)
  Isar get isar {
    if (_isar == null) {
      throw StateError(
        'IsarService not initialized. Call initialize() first.',
      );
    }
    return _isar!;
  }

  /// Whether Isar is initialized
  bool get isInitialized => _isar != null;

  /// Initialize Isar database
  Future<void> initialize() async {
    if (_isar != null) {
      return; // Already initialized
    }

    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [
        SpaceIsarModelSchema,
        SyncOperationIsarModelSchema,
        // Add more schemas as you create them:
        // EntryIsarModelSchema,
        // MessageIsarModelSchema,
        // UserIsarModelSchema,
        // etc.
      ],
      directory: dir.path,
      name: 'glow_db',
      inspector: true, // Enable Isar Inspector for debugging
    );
  }

  /// Close Isar instance
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// Clear all data (use with caution!)
  Future<void> clearAll() async {
    await _isar?.writeTxn(() async {
      await _isar?.clear();
    });
  }

  /// Clear specific collection
  Future<void> clearCollection<T>() async {
    await _isar?.writeTxn(() async {
      await _isar?.collection<T>().clear();
    });
  }

  /// Get database size in bytes
  Future<int> getDatabaseSize() async {
    return await _isar?.getSize() ?? 0;
  }

  /// Compact database (reclaim space)
  Future<void> compact() async {
    await close();
    await initialize();
  }
}
