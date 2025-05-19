import '../../domain/entities/news_item.dart';

/// Интерфейс для получения новостей
abstract class NewsDataSource {
  /// Последние новости, ограниченное число
  Future<List<NewsItem>> fetchLatest({int limit = 3});
}