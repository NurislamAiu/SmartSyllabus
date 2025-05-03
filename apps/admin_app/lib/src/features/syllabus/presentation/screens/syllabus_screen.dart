import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Силабусы на проверке'), actions: [
        IconButton(
          icon: const Icon(Icons.menu_book_outlined),
          tooltip: 'Литература',
          onPressed: () => context.go('/literature'),
        ),
      ],),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SyllabusReviewCard(
            course: 'Информатика 1',
            author: 'Ильясов Н.Б.',
            status: 'Ожидает проверки',
            onApprove: () {},
            onReject: () {},
          ),
          _SyllabusReviewCard(
            course: 'История Казахстана',
            author: 'Смагулова А.М.',
            status: 'На доработке',
            onApprove: () {},
            onReject: () {},
          ),
        ],
      ),
    );
  }
}

class _SyllabusReviewCard extends StatelessWidget {
  final String course;
  final String author;
  final String status;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _SyllabusReviewCard({
    required this.course,
    required this.author,
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
        title: Text(course, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Преподаватель: $author\nСтатус: $status'),
        leading: Icon(Icons.book, color: color),
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
          // TODO: переход к подробному виду силабуса
        },
      ),
    );
  }
}
