import 'supabase_client.dart';

/// Remote datasource for posts
class PostsRemoteDatasource {
  const PostsRemoteDatasource({
    required this.client,
  });

  final SupabaseClient client;

  /// Get posts by channel
  Future<List<Map<String, dynamic>>> getPostsByChannel(String channelId) async {
    final results = await client.from('posts');
    return results.where((p) => p['channel_id'] == channelId).toList();
  }

  /// Create post
  Future<Map<String, dynamic>> createPost({
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

  /// Delete post
  Future<void> deletePost(String postId) async {
    // TODO: Implement actual deletion
  }
}
