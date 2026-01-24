# Offline-First Strategy in Glow

## 🎯 Objective

Glow must work **completely offline**, with transparent synchronization when connected.

---

## 🏗️ Architecture

```
┌──────────────────────────────────────────────────┐
│            PRESENTATION (UI)                     │
│            - Shows data from any source          │
└─────────────────┬────────────────────────────────┘
                  │
                  ↓
┌──────────────────────────────────────────────────┐
│         RIVERPOD CONTROLLERS                     │
│  - Orchestrate Repositories                      │
│  - Manage sync states                            │
└────────┬──────────────────────┬──────────────────┘
         │                      │
         ↓                      ↓
┌─────────────────┐    ┌────────────────────────────┐
│  REPOSITORY     │    │   SYNC MANAGER             │
│  - Try remote   │◄───┤   - Queue offline ops      │
│  - Fallback     │    │   - Resolve conflicts      │
│    local        │────►│   - Batch sync             │
└─────────────────┘    └────────────────────────────┘
         │                      │
         ↓                      ↓
┌─────────────────┐    ┌────────────────────────────┐
│  ISAR (Local)   │    │   SUPABASE (Remote)        │
│  - Source of    │◄───┤   - Source of truth        │
│    truth        │sync │   - Realtime updates       │
│    offline      │────►│   - When online            │
└─────────────────┘    └────────────────────────────┘
```

---

## 📦 Key Components

### 1. **Isar Collections** (Local Storage)

Cada entidad tiene un modelo Isar:

```dart
// lib/src/models/isar/space_isar_model.dart
@collection
class SpaceIsarModel {
  Id id = Isar.autoIncrement;
  
  @Index(unique: true)
  late String remoteId;
  
  late String name;
  late String description;
  
  @enumerated
  late SpaceStatus status; // active, archived
  
  DateTime? createdAt;
  DateTime? updatedAt;
  
  // Sync metadata
  bool isPendingSync = false;
  String? syncOperation; // 'create', 'update', 'delete'
  DateTime? lastSyncedAt;
  
  // Mappers
  SpaceEntity toEntity() => SpaceEntity(
    id: remoteId,
    name: name,
    description: description,
  );
  
  static SpaceIsarModel fromEntity(SpaceEntity entity) => SpaceIsarModel()
    ..remoteId = entity.id
    ..name = entity.name
    ..description = entity.description;
}
```

### 2. **Sync Queue** (Pending Operations)

```dart
// lib/src/sync/sync_queue.dart
@collection
class SyncOperation {
  Id id = Isar.autoIncrement;
  
  late String entityType; // 'space', 'entry', 'message'
  late String entityId;
  late String operation; // 'create', 'update', 'delete'
  
  late String payload; // JSON serializado
  
  DateTime createdAt;
  int retryCount = 0;
  int maxRetries = 3;
  
  String? errorMessage;
  
  bool get shouldRetry => retryCount < maxRetries;
}
```

### 3. **Repository Pattern** (Offline-First)

```dart
// lib/src/repositories/spaces_repository_impl.dart
class SpacesRepositoryImpl implements SpacesRepository {
  final SpacesRemoteDataSource _remote;
  final SpacesLocalDataSource _local;
  final SyncManager _syncManager;
  final ConnectivityService _connectivity;
  
  @override
  Future<Result<List<SpaceEntity>, Failure>> getSpaces() async {
    // 1. SIEMPRE lee local primero (instantáneo)
    final cached = await _local.getSpaces();
    
    // 2. Si hay conexión, sync en background
    if (await _connectivity.isOnline) {
      _syncInBackground();
    }
    
    // 3. Retorna datos locales inmediatamente
    return Success(cached);
  }
  
  Future<void> _syncInBackground() async {
    try {
      final remote = await _remote.fetchSpaces();
      
      // Actualiza cache local
      await _local.saveSpaces(remote);
      
      // Process pending operations
      await _syncManager.processPendingOperations();
    } catch (e) {
      // Silent fail - user already has local data
      print('Background sync failed: $e');
    }
  }
  
  @override
  Future<Result<SpaceEntity, Failure>> createSpace(SpaceEntity space) async {
    // 1. Save locally IMMEDIATELY
    await _local.saveSpace(space, pendingSync: true);
    
    // 2. Queue for sync
    await _syncManager.enqueue(
      SyncOperation(
        entityType: 'space',
        entityId: space.id,
        operation: 'create',
        payload: jsonEncode(space.toJson()),
        createdAt: DateTime.now(),
      ),
    );
    
    // 3. If connected, try sync now
    if (await _connectivity.isOnline) {
      await _syncManager.processPendingOperations();
    }
    
    return Success(space);
  }
}
```

### 4. **Sync Manager** (Sincronización Inteligente)

```dart
// lib/src/sync/sync_manager.dart
class SyncManager {
  final Isar _isar;
  final SupabaseClient _supabase;
  final ConnectivityService _connectivity;
  
  Future<void> processPendingOperations() async {
    if (!await _connectivity.isOnline) return;
    
    final pending = await _isar.syncOperations
        .filter()
        .shouldRetryEqualTo(true)
        .findAll();
    
    for (final op in pending) {
      try {
        await _executeOperation(op);
        
        // Mark as synced
        await _isar.writeTxn(() async {
          await _isar.syncOperations.delete(op.id);
        });
      } catch (e) {
        // Increment retry count
        await _isar.writeTxn(() async {
          op.retryCount++;
          op.errorMessage = e.toString();
          await _isar.syncOperations.put(op);
        });
      }
    }
  }
  
  Future<void> _executeOperation(SyncOperation op) async {
    switch (op.operation) {
      case 'create':
        await _executeCreate(op);
      case 'update':
        await _executeUpdate(op);
      case 'delete':
        await _executeDelete(op);
    }
  }
  
  Future<void> _executeCreate(SyncOperation op) async {
    final payload = jsonDecode(op.payload);
    
    switch (op.entityType) {
      case 'space':
        await _supabase.from('spaces').insert(payload);
      case 'entry':
        await _supabase.from('entries').insert(payload);
      case 'message':
        await _supabase.from('messages').insert(payload);
    }
  }
}
```

### 5. **Conflict Resolution**

```dart
// lib/src/sync/conflict_resolver.dart
class ConflictResolver {
  T resolve<T extends Entity>({
    required T local,
    required T remote,
    required ConflictStrategy strategy,
  }) {
    switch (strategy) {
      case ConflictStrategy.lastWriteWins:
        return _lastWriteWins(local, remote);
      
      case ConflictStrategy.remoteWins:
        return remote;
      
      case ConflictStrategy.localWins:
        return local;
      
      case ConflictStrategy.merge:
        return _merge(local, remote);
    }
  }
  
  T _lastWriteWins<T extends Entity>(T local, T remote) {
    if (local.updatedAt.isAfter(remote.updatedAt)) {
      return local;
    }
    return remote;
  }
  
  T _merge<T extends Entity>(T local, T remote) {
    // Entity-specific implementation
    if (T == SpaceEntity) {
      return _mergeSpace(local as SpaceEntity, remote as SpaceEntity) as T;
    }
    // ... other types
    return remote;
  }
}

enum ConflictStrategy {
  lastWriteWins,
  remoteWins,
  localWins,
  merge,
}
```

---

## 🎭 Sync States (UI)

```dart
enum SyncStatus {
  synced,      // ✅ All synced
  pending,     // ⏳ Pending operation
  syncing,     // 🔄 Syncing now
  error,       // ❌ Sync error
  offline,     // 📴 No connection
}
```

### En la UI:

```dart
// Entry indicator
Entry(
  content: "My entry...",
  syncStatus: SyncStatus.pending,
  // Shows "Pending" badge with ⏳ icon
)

// En feed
if (syncStatus == SyncStatus.pending) {
  return Stack(
    children: [
      EntryCard(entry: entry),
      Positioned(
        top: 8,
        right: 8,
        child: Chip(
          label: Text('Pending'),
          icon: Icon(Icons.cloud_upload_outlined),
          backgroundColor: Colors.orange.withOpacity(0.2),
        ),
      ),
    ],
  );
}
```

---

## 📱 Offline Functionalities

### ✅ View content
- Global Feed
- Spaces
- Channels
- Entries
- Messages

### ✅ Create content
- New Entries → saved locally + marked "pending"
- Messages → sent locally + sync queue
- Edit Entries → local version + later sync

### ✅ Interact
- Reactions → saved locally
- Comments → saved locally
- Identity changes → saved locally

### ❌ NOT available offline
- Login/Register (requires server)
- Heavy media upload (queued)
- Realtime updates (obviously)

---

## 🔄 Complete Flow Example

### User creates an Entry without connection:

```
1. User taps "Publish Entry"
   ↓
2. UI shows "Publishing..."
   ↓
3. Repository saves to Isar:
   - entry_isar_model.isPendingSync = true
   ↓
4. Sync Manager queues operation:
   - SyncOperation(type: 'entry', op: 'create')
   ↓
5. UI updates:
   - Entry appears in feed with "Pending" badge
   ↓
6. User sees their Entry immediately
   (even though it's not on server)
   ↓
7. When connection returns:
   - SyncManager processes queue
   - POST to Supabase
   - Updates entry_isar_model.isPendingSync = false
   - UI removes "Pending" badge
   ↓
8. Entry now synced ✅
```

---

## 🛠️ Step-by-Step Implementation

### Phase 1: Isar Setup
- ✅ Add dependencies
- ⬜ Create Isar models
- ⬜ Setup initialization
- ⬜ Migrations

### Phase 2: Local DataSources
- ⬜ SpacesLocalDataSource
- ⬜ EntriesLocalDataSource
- ⬜ MessagesLocalDataSource
- ⬜ UsersLocalDataSource

### Phase 3: Sync System
- ⬜ SyncQueue implementation
- ⬜ SyncManager
- ⬜ ConflictResolver
- ⬜ Connectivity monitoring

### Phase 4: Repository Updates
- ⬜ Offline-first pattern
- ⬜ Background sync
- ⬜ Error handling
- ⬜ Retry logic

### Phase 5: UI Updates
- ⬜ Sync status indicators
- ⬜ Pending badges
- ⬜ Error states
- ⬜ Manual retry buttons

---

## 📊 Priorización de Sync

```dart
enum SyncPriority {
  critical,  // Mensajes, reacciones inmediatas
  high,      // Creación de Entries
  medium,    // Ediciones de Entries
  low,       // Cambios de perfil
}
```

Operaciones críticas se intentan inmediatamente cuando vuelva conexión.

---

## 🎯 Métricas a Monitorear

- Operaciones pendientes en cola
- Tasa de éxito de sync
- Tiempo promedio de sincronización
- Conflictos resueltos
- Errores de sync

---

## ⚡ Optimizaciones

### Batch Sync
```dart
// En vez de sync 1 a 1
await _syncOperation(op1);
await _syncOperation(op2);

// Batch de operaciones
await _batchSync([op1, op2, op3, ...]);
```

### Delta Sync
```dart
// Solo sincroniza cambios desde último sync
final lastSync = await _local.getLastSyncTimestamp();
final changes = await _remote.getChangesSince(lastSync);
```

### Selective Sync
```dart
// Solo sync Spaces que el usuario tiene abiertos
final activeSpaces = await _local.getActiveSpaces();
for (final space in activeSpaces) {
  await _syncSpace(space);
}
```

---

Esta estrategia hace que Glow sea **resiliente, rápido y usable sin conexión** 🚀
