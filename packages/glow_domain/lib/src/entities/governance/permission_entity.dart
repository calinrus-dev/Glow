/// Permission action
enum PermissionAction {
  read,
  write,
  delete,
  manage,
  invite,
  kick,
  ban,
}

/// Permission scope
enum PermissionScope {
  world,
  environment,
  channel,
}

/// Permission entity
class PermissionEntity {
  const PermissionEntity({
    required this.id,
    required this.scope,
    required this.scopeId,
    required this.subjectId,
    required this.subjectType,
    required this.action,
    required this.granted,
    required this.createdAt,
  });

  final String id;
  final PermissionScope scope;
  final String scopeId;
  final String subjectId;
  final String subjectType;
  final PermissionAction action;
  final bool granted;
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'PermissionEntity(action: $action, granted: $granted)';
}
