import '../../domain/entities/notification_item.dart';

/// Интерфейс для получения уведомлений
abstract class NotificationDataSource {
  /// Непрочитанные уведомления, ограниченное число
  Future<List<NotificationItem>> fetchUnread({int limit = 5});
}