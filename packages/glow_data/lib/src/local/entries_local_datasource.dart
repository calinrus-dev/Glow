import 'isar_client.dart';

/// Local datasource for entries
class EntriesLocalDatasource {
  const EntriesLocalDatasource({
    required this.client,
  });

  final IsarClient client;

  /// Get cached entries by channel
  Future<List<Map<String, dynamic>>> getEntriesByChannel(String channelId) async {
    final entries = await client.getCollection('entries');
    return entries.where((p) => p['channel_id'] == channelId).toList();
  }

  /// Cache entries
  Future<void> cacheEntries(List<Map<String, dynamic>> entries) async {
    for (final entry in entries) {
      await client.insert('entries', entry);
    }
  }

  /// Get pending entries (offline queue)
  Future<List<Map<String, dynamic>>> getPendingEntries() async {
    final entries = await client.getCollection('entries');
    return entries.where((p) => p['pending'] == true).toList();
  }
}
