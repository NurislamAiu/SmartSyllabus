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
}