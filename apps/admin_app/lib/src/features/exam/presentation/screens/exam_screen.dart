import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Экзамены на проверке'), actions: [
        IconButton(
          icon: const Icon(Icons.bar_chart),
          tooltip: 'Отчёты',
          onPressed: () => context.go('/evaluation'),
        ),
      ],),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ExamCard(
            course: 'Алгоритмы и структуры данных',
            teacher: 'Ахметова Д.А.',
            status: 'Ожидает проверки',
            onApprove: () {},
            onReject: () {},
          ),
          _ExamCard(
            course: 'Физика 1',
            teacher: 'Серик Б.К.',
            status: 'На доработке',
            onApprove: () {},
            onReject: () {},
          ),
        ],
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final String course;
  final String teacher;
  final String status;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _ExamCard({
    required this.course,
    required this.teacher,
    required this.status,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final color = status == 'Ожидает проверки' ? Colors.orange : Colors.redAccent;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(Icons.assignment, color: color),
        title: Text(course, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Преподаватель: $teacher\nСтатус: $status'),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.check, color: Colors.green),
              onPressed: onApprove,
              tooltip: 'Утвердить',
            ),
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.red),
              onPressed: onReject,
              tooltip: 'Отклонить',
            ),
          ],
        ),
        onTap: () {
          // TODO: открыть подробный просмотр экзамена
        },
      ),
    );
  }
}
