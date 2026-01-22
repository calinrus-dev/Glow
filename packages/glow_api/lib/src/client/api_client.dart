/// API client for backend communication
class ApiClient {
  const ApiClient({
    required this.baseUrl,
  });

  final String baseUrl;

  /// GET request
  Future<Map<String, dynamic>> get(String path) async =>
      {}; // TODO: Implement actual HTTP GET

  /// POST request
  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async =>
      {}; // TODO: Implement actual HTTP POST

  /// PUT request
  Future<Map<String, dynamic>> put(
    String path,
    Map<String, dynamic> body,
  ) async =>
      {}; // TODO: Implement actual HTTP PUT

  /// DELETE request
  Future<void> delete(String path) async {
    // TODO: Implement actual HTTP DELETE
  }
}
