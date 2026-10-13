import 'dart:convert';
import 'dart:io';

import 'package:async_json/book.dart';

/// 异步读取 data/books.json 并解析为图书列表。
Future<List<Book>> loadBooks(String path) async {
  final file = File(path);
  final content = await file.readAsString();
  final data = jsonDecode(content) as List<dynamic>;
  return data
      .map((e) => Book.fromJson(e as Map<String, dynamic>))
      .toList();
}

/// 统计各类目数量。
Map<String, int> countByCategory(List<Book> books) {
  final result = <String, int>{};
  for (final book in books) {
    result.update(book.category, (v) => v + 1, ifAbsent: () => 1);
  }
  return result;
}

/// 按借阅量降序取前 [topN] 本。
List<Book> topBorrowed(List<Book> books, int topN) {
  final sorted = [...books]..sort((a, b) => b.borrowCount.compareTo(a.borrowCount));
  return sorted.take(topN).toList();
}

Future<void> main(List<String> arguments) async {
  final books = await loadBooks('data/books.json');

  print('总数：${books.length}');

  print('各类目数量：');
  countByCategory(books).forEach((category, count) {
    print('  $category: $count');
  });

  print('借阅量 Top3：');
  final top3 = topBorrowed(books, 3);
  for (var i = 0; i < top3.length; i++) {
    final b = top3[i];
    print('  ${i + 1}. ${b.title}（${b.category}，${b.borrowCount} 次）');
  }
}
