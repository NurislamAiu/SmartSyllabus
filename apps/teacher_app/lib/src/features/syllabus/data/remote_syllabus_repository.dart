import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teacher_app/src/features/syllabus/data/syllabus.dart';

class SyllabusRemoteDataSource {
  final String baseUrl = 'http://localhost:8080/api/syllabus';

  Future<List<SyllabusAI>> fetchAll() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));

    if (response.statusCode == 200) {
      final List list = jsonDecode(response.body);
      return list.map((json) => SyllabusAI.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при загрузке силабусов');
    }
  }

  Future<void> createSyllabus(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при создании силабуса');
    }
  }
}
