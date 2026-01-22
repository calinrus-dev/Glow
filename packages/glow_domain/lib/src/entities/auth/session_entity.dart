/// Session entity
class SessionEntity {
  const SessionEntity({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  final String userId;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  /// Check if session is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  String toString() => 'SessionEntity(userId: $userId, expiresAt: $expiresAt)';
}
