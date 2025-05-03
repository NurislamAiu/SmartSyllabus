import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EvaluationScreen extends StatelessWidget {
  const EvaluationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Критерии оценивания'), actions: [
        IconButton(
          icon: const Icon(Icons.insert_chart),
          tooltip: 'Статистика',
          onPressed: () => context.go('/reports'),
        ),
      ],),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _CriteriaTile(type: 'Тест', weight: 30),
          _CriteriaTile(type: 'Проект', weight: 40),
          _CriteriaTile(type: 'Эссе', weight: 20),
          _CriteriaTile(type: 'Участие', weight: 10),
        ],
      ),
    );
  }
}

class _CriteriaTile extends StatelessWidget {
  final String type;
  final int weight;

  const _CriteriaTile({
    required this.type,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.rule),
        title: Text(type),
        subtitle: Text('Вес: $weight%'),
        trailing: Wrap(
          spacing: 8,
          children: const [
            Icon(Icons.check, color: Colors.green),
            Icon(Icons.clear, color: Colors.red),
          ],
        ),
        onTap: () {
          // TODO: детальный просмотр критерия
        },
      ),
    );
  }
}
