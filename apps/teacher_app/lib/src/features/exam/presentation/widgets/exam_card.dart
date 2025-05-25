import 'package:flutter/material.dart';
import '../../data/exam_model.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final ExamModel exam;

  const ExamCard({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd.MM.yyyy').format(exam.date);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📘 Название и тип
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  exam.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(exam.type),
                  backgroundColor: _getChipColor(exam.type),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 🗓 Дата
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // ❓ Вопросы (только первые 2)
            if (exam.questions.isNotEmpty) ...[
              const Text(
                'Вопросы:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              ...exam.questions.take(2).map((q) => Text('• $q')),
              if (exam.questions.length > 2)
                const Text('и др.', style: TextStyle(color: Colors.grey)),
            ],

            const SizedBox(height: 8),
            // 📋 Критерии
            Text(
              'Критерии: ${exam.criteria}',
              style: const TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Color _getChipColor(String type) {
    switch (type) {
      case 'Проект':
        return Colors.deepPurple.shade100;
      case 'Тест':
        return Colors.green.shade100;
      case 'Устный':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade300;
    }
  }
}