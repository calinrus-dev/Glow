import 'isar_client.dart';

/// Local datasource for auth
class AuthLocalDatasource {
  const AuthLocalDatasource({
    required this.client,
  });

  final IsarClient client;

  /// Save session
  Future<void> saveSession(Map<String, dynamic> session) async {
    await client.insert('sessions', session);
  }

  /// Get session
  Future<Map<String, dynamic>?> getSession() async {
    final sessions = await client.getCollection('sessions');
    return sessions.isNotEmpty ? sessions.first : null;
  }

  /// Clear session
  Future<void> clearSession() async {
    await client.clear('sessions');
  }
}
