import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Отчёты и аналитика')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ReportTile(
            title: 'Отчёт по силабусам',
            description: 'Утверждённые и отклонённые документы',
            onTap: () {
              // TODO: открыть подробный отчёт
            },
          ),
          _ReportTile(
            title: 'Отчёт по экзаменам',
            description: 'Обзор проверенных билетов',
            onTap: () {
              // TODO: открыть отчёт
            },
          ),
          _ReportTile(
            title: 'По кафедрам',
            description: 'Документы по каждому направлению',
            onTap: () {
              // TODO: открыть
            },
          ),
          _ReportTile(
            title: 'По преподавателям',
            description: 'Сводка по активности',
            onTap: () {
              // TODO: открыть
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: экспортировать в PDF/Excel
              },
              icon: const Icon(Icons.download),
              label: const Text('Экспортировать отчет'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _ReportTile({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.insert_chart_outlined),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
