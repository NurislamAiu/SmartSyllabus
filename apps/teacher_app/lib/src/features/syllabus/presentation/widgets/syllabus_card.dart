// presentation/widgets/syllabus_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/syllabus.dart';

class SyllabusCard extends StatelessWidget {
  final SyllabusAI syllabus;

  const SyllabusCard({super.key, required this.syllabus});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('dd MMM yyyy', 'ru').format(syllabus.createdAt);

    return InkWell(
      onTap: () => debugPrint('Открыть: ${syllabus.title}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: syllabus.isAI ? Colors.deepPurple.withOpacity(0.1) : Colors.blueGrey.withOpacity(0.1),
              ),
              child: Icon(
                syllabus.isAI ? Icons.smart_toy : Icons.menu_book,
                color: syllabus.isAI ? Colors.deepPurple : Colors.blueGrey,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(syllabus.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(syllabus.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[800])),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  _buildStatusChip(syllabus.status, syllabus.isAI),
                  Text('Создан: $dateStr', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, bool isAI) {
    Color color;
    String label;
    switch (status) {
      case 'approved':
        color = Colors.green;
        label = 'Утверждён';
        break;
      case 'pending':
        color = Colors.orange;
        label = 'Ожидает';
        break;
      case 'draft':
        color = Colors.grey;
        label = 'Черновик';
        break;
      default:
        color = Colors.blueGrey;
        label = 'Неизвестно';
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          label: Text(label),
          backgroundColor: color.withOpacity(0.1),
          labelStyle: TextStyle(color: color),
        ),
        if (isAI) const Padding(
          padding: EdgeInsets.only(left: 6),
          child: Icon(Icons.smart_toy, size: 18, color: Colors.deepPurple),
        ),
      ],
    );
  }
}