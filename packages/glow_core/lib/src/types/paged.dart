/// Represents paginated data
class Paged<T> {
  const Paged({
    required this.items,
    required this.total,
    required this.page,
    required this.pageSize,
  });

  final List<T> items;
  final int total;
  final int page;
  final int pageSize;

  /// Check if there are more pages
  bool get hasMore => (page * pageSize) < total;

  /// Get total number of pages
  int get totalPages => (total / pageSize).ceil();

  /// Map items to a different type
  Paged<R> map<R>(R Function(T item) transform) => Paged(
        items: items.map(transform).toList(),
        total: total,
        page: page,
        pageSize: pageSize,
      );

  @override
  String toString() =>
      'Paged(items: ${items.length}, total: $total, page: $page, pageSize: $pageSize)';
}
