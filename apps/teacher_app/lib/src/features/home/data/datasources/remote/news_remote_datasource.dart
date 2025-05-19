import '../news_datasource.dart';
import '../../../domain/entities/news_item.dart';

/// Реализация для реального API (пока заглушка)
class NewsRemoteDataSource implements NewsDataSource {
  @override
  Future<List<NewsItem>> fetchLatest({int limit = 3}) {
    // TODO: реализовать HTTP-запрос
    throw UnimplementedError();
  }
}