import '../notification_datasource.dart';
import '../../../domain/entities/notification_item.dart';

/// Реализация для реального API (пока заглушка)
class NotificationRemoteDataSource implements NotificationDataSource {
  @override
  Future<List<NotificationItem>> fetchUnread({int limit = 5}) {
    // TODO: реализовать HTTP-запрос
    throw UnimplementedError();
  }
}