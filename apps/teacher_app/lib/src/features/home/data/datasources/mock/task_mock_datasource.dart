import '../task_datasource.dart';
import '../../../domain/entities/task.dart';

/// Мок-реализация TaskDataSource
class TaskMockDataSource implements TaskDataSource {
  @override
  Future<List<Task>> fetchUpcomingTasks({int limit = 3}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.generate(limit, (i) {
      final index = i + 1;
      return Task(
        id: '$index',
        title: 'Задача №$index',
        dueDate: DateTime.now().add(Duration(days: index)),
      );
    });
  }
}