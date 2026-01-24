import 'supabase_client.dart';

/// Remote datasource for entries
class EntriesRemoteDatasource {
  const EntriesRemoteDatasource({
    required this.client,
  });

  final SupabaseClient client;

  /// Get entries by channel
  Future<List<Map<String, dynamic>>> getEntriesByChannel(
    String channelId,
  ) async {
    final results = await client.from('entries');
    return results.where((p) => p['channel_id'] == channelId).toList();
  }

  /// Create entry
  Future<Map<String, dynamic>> createEntry({
    required String channelId,
    required String content,
  }) async {
    // TODO: Implement actual creation
    return {
      'id': 'temp-id',
      'channel_id': channelId,
      'content': content,
      'created_at': DateTime.now().toIso8601String(),
    };
  }

  /// Delete entry
  Future<void> deleteEntry(String entryId) async {
    // TODO: Implement actual deletion
  }
}
