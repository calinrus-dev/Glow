import 'supabase_client.dart';

/// Remote datasource for auth operations
class AuthRemoteDatasource {
  const AuthRemoteDatasource({
    required this.client,
  });

  final SupabaseClient client;

  /// Sign in with email and password
  Future<Map<String, dynamic>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await client.signIn(email, password);
    if (response == null) {
      throw Exception('Sign in failed');
    }
    return response;
  }

  /// Sign up with email and password
  Future<Map<String, dynamic>> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    // TODO: Implement actual sign up
    return {};
  }

  /// Sign out
  Future<void> signOut() async {
    // TODO: Implement actual sign out
  }

  /// Get current session
  Future<Map<String, dynamic>?> getCurrentSession() async {
    // TODO: Implement actual session retrieval
    return null;
  }
}
