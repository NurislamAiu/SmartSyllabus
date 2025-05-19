import '../../domain/entities/task.dart';

/// Интерфейс для получения срочных задач
abstract class TaskDataSource {
  /// Список предстоящих задач, ограниченное число
  Future<List<Task>> fetchUpcomingTasks({int limit = 3});
}