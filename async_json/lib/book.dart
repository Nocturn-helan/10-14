/// 图书数据模型，对应 data/books.json 中的一条记录。
class Book {
  final int id;
  final String title;
  final String category;
  final int borrowCount;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.borrowCount,
  });

  /// 从 JSON Map 构造 Book 实例（命名构造）。
  /// 当 borrowCount 字段缺失或为 null 时，默认按 0 处理，避免解析崩溃。
  Book.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        title = json['title'] as String,
        category = json['category'] as String,
        borrowCount = (json['borrowCount'] as num?)?.toInt() ?? 0;

  @override
  String toString() => 'Book(id: $id, title: $title, category: $category, '
      'borrowCount: $borrowCount)';
}
