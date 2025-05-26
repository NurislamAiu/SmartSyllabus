import '../../domain/entities/syllabus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


abstract class HomeDataSource {

  Future<int> fetchAllCount();

  Future<int> fetchCountByStatus(SyllabusStatus status);
}



class HomeRemoteDataSource implements HomeDataSource {
  @override
  Future<int> fetchAllCount() async {
    final url = Uri.parse('http://localhost:8080/api/home/kpi');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data['total'];
  }

  @override
  Future<int> fetchCountByStatus(SyllabusStatus status) async {
    final url = Uri.parse('http://localhost:8080/api/home/kpi');
    final response = await http.get(url);
    final data = jsonDecode(response.body);

    switch (status) {
      case SyllabusStatus.total:
        return data['total'];
      case SyllabusStatus.pending:
        return data['pending'];
      case SyllabusStatus.approved:
        return data['approved'];
      case SyllabusStatus.rejected:
        return data['rejected'];
    }
  }
}