import 'package:flutter/material.dart';

class EvaluationScreen extends StatelessWidget {
  const EvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Критерии оценивания')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _EvaluationCard(
            title: 'Проект',
            weight: '40%',
            description: 'Оценка на основе группового или индивидуального проекта',
          ),
          _EvaluationCard(
            title: 'Тест',
            weight: '30%',
            description: 'Автоматизированное тестирование на знания',
          ),
          _EvaluationCard(
            title: 'Эссе',
            weight: '30%',
            description: 'Оценка письменных аналитических работ',
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: добавить редактор критериев
            },
            icon: const Icon(Icons.add),
            label: const Text('Добавить критерий'),
          ),
        ],
      ),
    );
  }
}

class _EvaluationCard extends StatelessWidget {
  final String title;
  final String weight;
  final String description;

  const _EvaluationCard({
    required this.title,
    required this.weight,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(description),
        trailing: Text(weight, style: const TextStyle(fontWeight: FontWeight.bold)),
        onTap: () {
          // TODO: перейти к деталям
        },
      ),
    );
  }
}
