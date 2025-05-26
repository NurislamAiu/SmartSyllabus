class ExamModel {
  final String title;
  final String type;
  final List<String> questions;
  final String criteria;
  final DateTime date;

  ExamModel({
    required this.title,
    required this.type,
    required this.questions,
    required this.criteria,
    required this.date,
  });

  // 🔄 Для отправки на backend
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'questions': questions,
      'criteria': criteria,
      'date': date.toIso8601String(), // ✅ ISO формат
    };
  }

  // 🧠 Для получения с backend
  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      title: json['title'],
      type: json['type'],
      questions: List<String>.from(json['questions'] ?? []),
      criteria: json['criteria'],
      date: DateTime.parse(json['date']),
    );
  }
}