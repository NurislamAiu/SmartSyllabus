import '../../domain/entities/notification_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


abstract class NotificationDataSource {
  Future<List<NotificationItem>> fetchUnread({int limit = 5});
}


class NotificationRemoteDataSource implements NotificationDataSource {
  @override
  Future<List<NotificationItem>> fetchUnread({int limit = 10}) async {
    final url = Uri.parse('http://localhost:8080/api/notifications/unread?limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => NotificationItem.fromJson(e)).toList();
    } else {
      throw Exception('Ошибка при получении уведомлений');
    }
  }
}