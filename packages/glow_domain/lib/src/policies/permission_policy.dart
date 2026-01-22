import '../entities/governance/permission_entity.dart';

/// Permission policy - business rules for permissions
class PermissionPolicy {
  const PermissionPolicy();

  /// Check if user has permission
  bool hasPermission({
    required List<PermissionEntity> userPermissions,
    required PermissionAction requiredAction,
    required PermissionScope scope,
    required String scopeId,
  }) {
    return userPermissions.any(
      (p) =>
          p.scope == scope &&
          p.scopeId == scopeId &&
          p.action == requiredAction &&
          p.granted,
    );
  }

  /// Check if user can manage (admin-level)
  bool canManage({
    required List<PermissionEntity> userPermissions,
    required PermissionScope scope,
    required String scopeId,
  }) {
    return hasPermission(
      userPermissions: userPermissions,
      requiredAction: PermissionAction.manage,
      scope: scope,
      scopeId: scopeId,
    );
  }
}
