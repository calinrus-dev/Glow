/// Data layer - repositories and datasources
library;

// Models (DTOs)
export 'src/models/space_dto.dart';
export 'src/models/channel_dto.dart';
export 'src/models/entry_dto.dart';
export 'src/models/comment_dto.dart';

// Mappers
export 'src/mappers/space_mapper.dart';
export 'src/mappers/channel_mapper.dart';
export 'src/mappers/entry_mapper.dart';
export 'src/mappers/comment_mapper.dart';

// Remote datasources
export 'src/remote/supabase_client.dart';
export 'src/remote/auth_remote_datasource.dart';
export 'src/remote/spaces_remote_datasource.dart';
export 'src/remote/entries_remote_datasource.dart';

// Local datasources
export 'src/local/isar_client.dart';
export 'src/local/auth_local_datasource.dart';
export 'src/local/spaces_local_datasource.dart';
export 'src/local/entries_local_datasource.dart';

// Sync
export 'src/sync/sync_manager.dart';
export 'src/sync/sync_queue.dart';
export 'src/sync/conflict_resolver.dart';
