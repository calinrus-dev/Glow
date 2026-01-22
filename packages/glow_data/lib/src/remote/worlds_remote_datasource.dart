import 'supabase_client.dart';

/// Remote datasource for worlds
class WorldsRemoteDatasource {
  const WorldsRemoteDatasource({
    required this.client,
  });

  final SupabaseClient client;

  /// Get all worlds
  Future<List<Map<String, dynamic>>> getWorlds() async {
    return client.from('worlds');
  }

  /// Get world by ID
  Future<Map<String, dynamic>?> getWorldById(String id) async {
    final results = await client.from('worlds');
    return results.firstWhere(
      (w) => w['id'] == id,
      orElse: () => <String, dynamic>{},
    );
  }

  /// Create world
  Future<Map<String, dynamic>> createWorld({
    required String name,
    required String slug,
    String? description,
  }) async {
    // TODO: Implement actual creation
    return {
      'id': 'temp-id',
      'name': name,
      'slug': slug,
      'description': description,
    };
  }
}
