import 'package:isar/isar.dart';

part 'sync_operation_isar_model.g.dart';

/// Isar model for queued sync operations (offline-first)
@collection
class SyncOperationIsarModel {
  /// Auto-increment ID
  Id id = Isar.autoIncrement;

  /// Entity type: 'space', 'entry', 'message', 'user', etc.
  @Index()
  late String entityType;

  /// Entity ID (remote ID)
  late String entityId;

  /// Operation type: 'create', 'update', 'delete'
  @enumerated
  late SyncOperationType operation;

  /// Priority: higher = sync first
  @enumerated
  late SyncPriority priority;

  /// Payload (JSON serialized entity)
  late String payload;

  /// Created timestamp
  late DateTime createdAt;

  /// Retry count
  int retryCount = 0;

  /// Max retries before giving up
  int maxRetries = 3;

  /// Last error message
  String? errorMessage;

  /// Last attempted timestamp
  DateTime? lastAttemptedAt;

  // Methods (not persisted - marked with @ignore)

  /// Whether this operation should be retried
  @ignore
  bool get shouldRetry => retryCount < maxRetries;

  /// Whether this operation has failed permanently
  @ignore
  bool get hasFailed => retryCount >= maxRetries;

  /// Age of this operation
  @ignore
  Duration get age => DateTime.now().difference(createdAt);

  // Methods

  /// Mark as attempted with error
  void markAttempted(String error) {
    retryCount++;
    errorMessage = error;
    lastAttemptedAt = DateTime.now();
  }

  /// Reset retry count
  void reset() {
    retryCount = 0;
    errorMessage = null;
    lastAttemptedAt = null;
  }
}

/// Sync operation types
enum SyncOperationType {
  create,
  update,
  delete,
}

/// Sync priority levels
enum SyncPriority {
  low,      // Profile changes, settings
  medium,   // Entry edits
  high,     // Entry creation
  critical, // Messages, reactions
}
