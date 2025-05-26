import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exam_model.dart';

class ExamRemoteDataSource {
  final String baseUrl = 'http://localhost:8080/api/exams';

  Future<List<ExamModel>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((json) => ExamModel.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при загрузке экзаменов');
    }
  }

  Future<void> createExam(ExamModel exam) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(exam.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при создании экзамена');
    }
  }
}