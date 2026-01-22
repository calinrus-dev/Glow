import '../domain/block.dart';

/// Block parser
class BlockParser {
  const BlockParser();

  /// Parse block composition
  Future<List<Block>> parse(Map<String, dynamic> data) async {
    // TODO: Implement block parsing
    return [];
  }

  /// Validate block connections
  Future<bool> validate(List<Block> blocks) async {
    // TODO: Implement validation
    return true;
  }
}
