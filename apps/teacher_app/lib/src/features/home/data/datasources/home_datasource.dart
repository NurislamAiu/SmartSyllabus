import '../../domain/entities/syllabus.dart';

/// Интерфейс для получения данных силабусов
abstract class HomeDataSource {
  /// Общее число силабусов
  Future<int> fetchAllCount();

  /// Число силабусов по статусу
  Future<int> fetchCountByStatus(SyllabusStatus status);
}