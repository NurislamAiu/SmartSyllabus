// lib/src/features/home/data/datasources/mock/news_mock_datasource.dart

import '../news_datasource.dart';
import '../../../domain/entities/news_item.dart';

/// Мок-реализация NewsDataSource, возвращающая осмысленные заголовки
class NewsMockDataSource implements NewsDataSource {
  @override
  Future<List<NewsItem>> fetchLatest({int limit = 3}) async {
    // эмуляция задержки
    await Future.delayed(const Duration(milliseconds: 200));

    // заранее подготовленные новости
    final items = <NewsItem>[
      NewsItem(
        id: '1',
        title: 'Открыта регистрация на осенний семестр',
        publishedAt: DateTime(2025, 5, 20),
        imageUrl: 'assets/images/news1.jpg',
      ),
      NewsItem(
        id: '2',
        title: 'Обновлены материалы по курсу "Data Science"',
        publishedAt: DateTime(2025, 5, 19),
        imageUrl: 'assets/images/news2.jpg',
      ),
      NewsItem(
        id: '3',
        title: 'Приглашение на научную конференцию 30 мая',
        publishedAt: DateTime(2025, 5, 18),
        imageUrl: 'assets/images/news3.jpg',
      ),
      // при желании можно добавить больше, но HomeScreen берёт только первые `limit`
    ];

    return items.take(limit).toList();
  }
}