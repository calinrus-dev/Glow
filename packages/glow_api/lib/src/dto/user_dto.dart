/// User DTO
class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    this.username,
    this.displayName,
    this.avatarUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json['id'] as String,
        email: json['email'] as String,
        username: json['username'] as String?,
        displayName: json['display_name'] as String?,
        avatarUrl: json['avatar_url'] as String?,
      );

  final String id;
  final String email;
  final String? username;
  final String? displayName;
  final String? avatarUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        if (username != null) 'username': username,
        if (displayName != null) 'display_name': displayName,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      };
}
