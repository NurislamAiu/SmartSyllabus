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

  factory SyllabusAI.fromJson(Map<String, dynamic> json) {
    return SyllabusAI(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'] ?? 'pending',
    );
  }
}

