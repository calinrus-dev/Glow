class {{entity_name}}Entity {
  const {{entity_name}}Entity({
    required this.id,
  });

  final String id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is {{entity_name}}Entity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
