import 'supabase_client.dart';

/// Remote datasource for spaces
class SpacesRemoteDatasource {
  const SpacesRemoteDatasource({
    required this.client,
  });

  final SupabaseClient client;

  /// Get all spaces
  Future<List<Map<String, dynamic>>> getSpaces() async {
    return client.from('spaces');
  }

  /// Get space by ID
  Future<Map<String, dynamic>?> getSpaceById(String id) async {
    final results = await client.from('spaces');
    return results.firstWhere(
      (w) => w['id'] == id,
      orElse: () => <String, dynamic>{},
    );
  }

  /// Create space
  Future<Map<String, dynamic>> createSpace({
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
