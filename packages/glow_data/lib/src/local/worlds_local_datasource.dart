import 'isar_client.dart';

/// Local datasource for worlds
class WorldsLocalDatasource {
  const WorldsLocalDatasource({
    required this.client,
  });

  final IsarClient client;

  /// Get all cached worlds
  Future<List<Map<String, dynamic>>> getWorlds() async {
    return client.getCollection('worlds');
  }

  /// Cache worlds
  Future<void> cacheWorlds(List<Map<String, dynamic>> worlds) async {
    await client.clear('worlds');
    for (final world in worlds) {
      await client.insert('worlds', world);
    }
  }

  /// Get world by ID
  Future<Map<String, dynamic>?> getWorldById(String id) async {
    final worlds = await client.getCollection('worlds');
    return worlds.firstWhere(
      (w) => w['id'] == id,
      orElse: () => <String, dynamic>{},
    );
  }
}
