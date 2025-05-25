class SyllabusAI{
  final String title;
  final String description;
  final DateTime createdAt;
  final String status;
  final bool isAI;

  SyllabusAI({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
    this.isAI = false,
  });
}