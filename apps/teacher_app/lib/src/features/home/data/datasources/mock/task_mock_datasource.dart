import '../task_datasource.dart';
import '../../../domain/entities/task.dart';

/// Мок-реализация TaskDataSource
class TaskMockDataSource implements TaskDataSource {
  @override
  Future<List<Task>> fetchUpcomingTasks({int limit = 3}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.generate(limit, (i) => Task(
      id: '\$i',
      title: 'Задача #\$i',
      dueDate: DateTime.now().add(Duration(days: i + 1)),
    ));
  }
}