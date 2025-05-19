enum SyllabusStatus {
  pending,
  approved,
  rejected,
}

class Syllabus {
  final String id;
  final String title;
  final SyllabusStatus status;

  const Syllabus({
    required this.id,
    required this.title,
    required this.status,
  });
}