import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои силабусы'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: добавить фильтрацию
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SyllabusCard(
            title: 'Информатика 1',
            status: 'Draft',
            color: Colors.orange,
            onTap: () => context.go('/syllabus/edit/1'),
          ),
          _SyllabusCard(
            title: 'История Казахстана',
            status: 'Approved',
            color: Colors.green,
            onTap: () => context.go('/syllabus/view/2'),
          ),
          _SyllabusCard(
            title: 'Биология',
            status: 'Review',
            color: Colors.blue,
            onTap: () => context.go('/syllabus/review/3'),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/syllabus/create'),
            icon: const Icon(Icons.note_add),
            label: const Text('Создать силабус'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => context.go('/syllabus/ai-assistant'),
            icon: const Icon(Icons.smart_toy),
            label: const Text('Сгенерировать с ИИ'),
          ),
          const SizedBox(height: 24),
          Text('Дополнительно', style: textTheme.titleMedium),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => context.go('/literature'),
            icon: const Icon(Icons.menu_book),
            label: const Text('Учебная литература'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => context.go('/evaluation'),
            icon: const Icon(Icons.rule),
            label: const Text('Критерии оценивания'),
          ),
        ],
      ),
    );
  }
}

class _SyllabusCard extends StatelessWidget {
  final String title;
  final String status;
  final Color color;
  final VoidCallback onTap;

  const _SyllabusCard({
    required this.title,
    required this.status,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
