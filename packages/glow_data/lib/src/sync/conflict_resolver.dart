/// Conflict resolver for sync conflicts
class ConflictResolver {
  const ConflictResolver();

  /// Resolve conflict between local and remote data
  Future<Map<String, dynamic>> resolve({
    required Map<String, dynamic> local,
    required Map<String, dynamic> remote,
    ConflictStrategy strategy = ConflictStrategy.remoteWins,
  }) async {
    return switch (strategy) {
      ConflictStrategy.remoteWins => remote,
      ConflictStrategy.localWins => local,
      ConflictStrategy.newestWins => _newestWins(local, remote),
    };
  }

  Map<String, dynamic> _newestWins(
    Map<String, dynamic> local,
    Map<String, dynamic> remote,
  ) {
    final localTime = DateTime.tryParse(local['updated_at'] as String? ?? '');
    final remoteTime = DateTime.tryParse(remote['updated_at'] as String? ?? '');

    if (localTime == null || remoteTime == null) {
      return remote;
    }

    return localTime.isAfter(remoteTime) ? local : remote;
  }
}

/// Conflict resolution strategy
enum ConflictStrategy {
  remoteWins,
  localWins,
  newestWins,
}
