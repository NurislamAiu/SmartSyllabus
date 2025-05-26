import '../../domain/entities/news_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



/// Интерфейс для получения новостей
abstract class NewsDataSource {
  /// Последние новости, ограниченное число
  Future<List<NewsItem>> fetchLatest({int limit = 3});
}

class NewsRemoteDataSource implements NewsDataSource {
  @override
  Future<List<NewsItem>> fetchLatest({int limit = 2}) async {
    final url = Uri.parse('http://localhost:8080/api/news/latest?limit=$limit');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => NewsItem.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при получении новостей: ${response.statusCode}');
    }
  }
}