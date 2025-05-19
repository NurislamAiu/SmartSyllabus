import '../home_datasource.dart';
import '../../../domain/entities/syllabus.dart';

/// Мок-реализация HomeDataSource
class HomeMockDataSource implements HomeDataSource {
  @override
  Future<int> fetchAllCount() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return 17;
  }

  @override
  Future<int> fetchCountByStatus(SyllabusStatus status) async {
    await Future.delayed(const Duration(milliseconds: 100));
    switch (status) {
      case SyllabusStatus.pending:
        return 4;
      case SyllabusStatus.approved:
        return 10;
      case SyllabusStatus.rejected:
        return 3;
    }
  }
}