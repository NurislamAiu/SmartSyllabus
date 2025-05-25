import 'package:flutter/material.dart';

class OralExamForm extends StatelessWidget {
  final TextEditingController questionController;
  final TextEditingController criteriaController;
  final List<String> oralQuestions;
  final VoidCallback onUpdate;

  static const Color primaryColor = Color(0xFF3F3F8F);

  const OralExamForm({
    super.key,
    required this.questionController,
    required this.criteriaController,
    required this.oralQuestions,
    required this.onUpdate,
  });

  void _addOralQuestion() {
    final text = questionController.text.trim();
    if (text.isNotEmpty) {
      oralQuestions.add(text);
      questionController.clear();
      onUpdate();
    }
  }

  void _removeQuestion(int index) {
    oralQuestions.removeAt(index);
    onUpdate();
  }

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
            const Text('Устный экзамен: вопросы',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: questionController,
                    decoration: const InputDecoration(
                      labelText: 'Вопрос',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _addOralQuestion,
                  icon: const Icon(Icons.add_circle, color: primaryColor),
                )
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: criteriaController,
              decoration: const InputDecoration(
                labelText: 'Критерии оценивания',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Список вопросов:'),
            const SizedBox(height: 8),
            ...oralQuestions.asMap().entries.map((entry) => Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(entry.value),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeQuestion(entry.key),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}