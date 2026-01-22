import '../domain/block.dart';

/// Block validator
class BlockValidator {
  const BlockValidator();

  /// Validate single block
  Future<bool> validateBlock(Block block) async {
    // TODO: Implement block validation
    return true;
  }

  /// Validate block graph
  Future<bool> validateGraph(List<Block> blocks) async {
    // TODO: Implement graph validation (cycles, types, etc.)
    return true;
  }
}
