import '../home_datasource.dart';
import '../../../domain/entities/syllabus.dart';

/// Реализация для реального API (пока заглушка)
class HomeRemoteDataSource implements HomeDataSource {
  @override
  Future<int> fetchAllCount() {
    // TODO: реализовать HTTP-запрос
    throw UnimplementedError();
  }

  @override
  Future<int> fetchCountByStatus(SyllabusStatus status) {
    // TODO: реализовать HTTP-запрос
    throw UnimplementedError();
  }
}