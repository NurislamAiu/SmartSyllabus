import 'package:flutter/material.dart';

class ProjectExamForm extends StatelessWidget {
  final TextEditingController descriptionController;
  final TextEditingController requirementsController;
  final TextEditingController criteriaController;

  static const Color primaryColor = Color(0xFF3F3F8F);

  const ProjectExamForm({
    super.key,
    required this.descriptionController,
    required this.requirementsController,
    required this.criteriaController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Проект: описание и требования',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Описание проекта',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: requirementsController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Требования к проекту',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: criteriaController,
              decoration: const InputDecoration(
                labelText: 'Критерии оценивания',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}