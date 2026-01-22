/// Auth interceptor for adding tokens to requests
class AuthInterceptor {
  const AuthInterceptor({
    required this.getToken,
  });

  final Future<String?> Function() getToken;

  /// Add auth header to request
  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
  }
}
