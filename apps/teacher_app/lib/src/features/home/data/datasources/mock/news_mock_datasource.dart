import '../news_datasource.dart';
import '../../../domain/entities/news_item.dart';

/// Мок-реализация NewsDataSource
class NewsMockDataSource implements NewsDataSource {
  @override
  Future<List<NewsItem>> fetchLatest({int limit = 3}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.generate(limit, (i) => NewsItem(
      id: '\$i',
      title: 'Новость #\$i',
      publishedAt: DateTime.now().subtract(Duration(days: i)),
      imageUrl: 'assets/images/news\${i+1}.jpg',
    ));
  }
}