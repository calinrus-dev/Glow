import 'isar_client.dart';

/// Local datasource for posts
class PostsLocalDatasource {
  const PostsLocalDatasource({
    required this.client,
  });

  final IsarClient client;

  /// Get cached posts by channel
  Future<List<Map<String, dynamic>>> getPostsByChannel(String channelId) async {
    final posts = await client.getCollection('posts');
    return posts.where((p) => p['channel_id'] == channelId).toList();
  }

  /// Cache posts
  Future<void> cachePosts(List<Map<String, dynamic>> posts) async {
    for (final post in posts) {
      await client.insert('posts', post);
    }
  }

  /// Get pending posts (offline queue)
  Future<List<Map<String, dynamic>>> getPendingPosts() async {
    final posts = await client.getCollection('posts');
    return posts.where((p) => p['pending'] == true).toList();
  }
}
