import 'package:glow_domain/glow_domain.dart';
import 'package:isar/isar.dart';

part 'space_isar_model.g.dart';

/// Isar model for Space entity (offline storage)
@collection
class SpaceIsarModel {
  /// Isar auto-increment ID (local)
  Id id = Isar.autoIncrement;

  /// Remote ID from Supabase (unique)
  @Index(unique: true)
  late String remoteId;

  /// Space name
  late String name;

  /// Space slug (URL-friendly identifier)
  late String slug;

  /// Space description
  String? description;

  /// Icon URL
  String? iconUrl;

  /// Cover URL
  String? coverUrl;

  /// Visibility (0=public, 1=private, 2=unlisted)
  @enumerated
  late SpaceVisibility visibility;

  /// Owner ID
  late String ownerId;

  /// Created timestamp
  late DateTime createdAt;

  /// Updated timestamp
  DateTime? updatedAt;

  /// Last synced timestamp
  DateTime? lastSyncedAt;

  // Sync metadata

  /// Whether this Space has pending changes to sync
  bool isPendingSync = false;

  /// Type of pending operation: 'create', 'update', 'delete'
  String? syncOperation;

  /// Sync error message (if any)
  String? syncError;

  /// Number of sync retries
  int syncRetryCount = 0;

  // Mappers

  /// Convert to domain entity
  SpaceEntity toEntity() {
    return SpaceEntity(
      id: remoteId,
      name: name,
      slug: slug,
      description: description,
      iconUrl: iconUrl,
      coverUrl: coverUrl,
      visibility: visibility,
      ownerId: ownerId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  /// Create from domain entity
  static SpaceIsarModel fromEntity(SpaceEntity entity) {
    return SpaceIsarModel()
      ..remoteId = entity.id
      ..name = entity.name
      ..slug = entity.slug
      ..description = entity.description
      ..iconUrl = entity.iconUrl
      ..coverUrl = entity.coverUrl
      ..visibility = entity.visibility
      ..ownerId = entity.ownerId
      ..createdAt = entity.createdAt
      ..updatedAt = entity.updatedAt
      ..lastSyncedAt = DateTime.now()
      ..isPendingSync = false;
  }

  /// Mark as pending sync
  void markPendingSync(String operation) {
    isPendingSync = true;
    syncOperation = operation;
    syncError = null;
  }

  /// Mark as synced
  void markSynced() {
    isPendingSync = false;
    syncOperation = null;
    syncError = null;
    syncRetryCount = 0;
    lastSyncedAt = DateTime.now();
  }

  /// Mark sync error
  void markSyncError(String error) {
    syncError = error;
    syncRetryCount++;
  }
}
