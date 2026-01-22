/// Identity provider type
enum IdentityProvider {
  email,
  google,
  apple,
  github,
}

/// Identity entity (linked auth provider)
class IdentityEntity {
  const IdentityEntity({
    required this.id,
    required this.userId,
    required this.provider,
    required this.providerId,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final IdentityProvider provider;
  final String providerId;
  final DateTime createdAt;

  @override
  String toString() => 'IdentityEntity(provider: $provider, userId: $userId)';
}
