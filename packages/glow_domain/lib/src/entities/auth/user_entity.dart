/// User entity
class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    this.username,
    this.displayName,
    this.avatarUrl,
    this.bio,
    required this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String email;
  final String? username;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() =>
      'UserEntity(id: $id, email: $email, username: $username)';
}
