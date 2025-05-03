import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Экзамены и билеты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Поиск
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ExamCard(
            title: 'ЕНТ по истории',
            date: '12.05.2025',
            type: 'AI',
            questionCount: 20,
            status: 'Review',
            statusColor: Colors.blue,
            onView: () => context.go('/exam/view/1'),
            onExport: () {},
          ),
          _ExamCard(
            title: 'Промежуточный тест по биологии',
            date: '01.05.2025',
            type: 'Manual',
            questionCount: 15,
            status: 'Draft',
            statusColor: Colors.orange,
            onView: () => context.go('/exam/edit/2'),
            onExport: () {},
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/exam/create'),
            icon: const Icon(Icons.note_add),
            label: const Text('Создать экзамен вручную'),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => context.go('/exam/ai-assistant'),
            icon: const Icon(Icons.smart_toy),
            label: const Text('Сгенерировать экзамен (ИИ)'),
          ),
        ],
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final String title;
  final String date;
  final String type;
  final int questionCount;
  final String status;
  final Color statusColor;
  final VoidCallback onView;
  final VoidCallback onExport;

  const _ExamCard({
    required this.title,
    required this.date,
    required this.type,
    required this.questionCount,
    required this.status,
    required this.statusColor,
    required this.onView,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Тип: $type | Вопросов: $questionCount'),
            Text('Дата: $date'),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(child: Text('Просмотреть'), value: 'view'),
            const PopupMenuItem(child: Text('Экспорт'), value: 'export'),
          ],
          onSelected: (value) {
            if (value == 'view') onView();
            if (value == 'export') onExport();
          },
        ),
      ),
    );
  }
}
