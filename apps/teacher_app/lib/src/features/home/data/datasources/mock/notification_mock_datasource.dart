import '../notification_datasource.dart';
import '../../../domain/entities/notification_item.dart';

/// Мок-реализация NotificationDataSource
class NotificationMockDataSource implements NotificationDataSource {
  @override
  Future<List<NotificationItem>> fetchUnread({int limit = 5}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.generate(limit, (i) => NotificationItem(
      id: '\$i',
      message: 'Уведомление #\$i',
      date: DateTime.now().subtract(Duration(hours: i)),
    ));
  }
}