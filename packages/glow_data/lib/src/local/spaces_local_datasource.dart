import 'isar_client.dart';

/// Local datasource for spaces
class SpacesLocalDatasource {
  const SpacesLocalDatasource({
    required this.client,
  });

  final IsarClient client;

  /// Get all cached spaces
  Future<List<Map<String, dynamic>>> getSpaces() async {
    return client.getCollection('spaces');
  }

  /// Cache spaces
  Future<void> cacheSpaces(List<Map<String, dynamic>> spaces) async {
    await client.clear('spaces');
    for (final space in spaces) {
      await client.insert('spaces', space);
    }
  }

  /// Get space by ID
  Future<Map<String, dynamic>?> getSpaceById(String id) async {
    final spaces = await client.getCollection('spaces');
    return spaces.firstWhere(
      (w) => w['id'] == id,
      orElse: () => <String, dynamic>{},
    );
  }
}
