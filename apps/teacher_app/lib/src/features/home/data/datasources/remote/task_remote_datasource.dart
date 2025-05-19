import '../task_datasource.dart';
import '../../../domain/entities/task.dart';

/// Реализация для реального API (пока заглушка)
class TaskRemoteDataSource implements TaskDataSource {
  @override
  Future<List<Task>> fetchUpcomingTasks({int limit = 3}) {
    // TODO: реализовать HTTP-запрос
    throw UnimplementedError();
  }
}