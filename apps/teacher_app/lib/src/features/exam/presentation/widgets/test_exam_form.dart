import 'package:flutter/material.dart';

class TestExamForm extends StatelessWidget {
  final TextEditingController questionController;
  final List<String> dynamicOptions;
  final int? correctAnswerIndex;
  final List<Map<String, dynamic>> testQuestions;
  final ValueChanged<int?> onChanged;
  final VoidCallback onUpdate;

  static const Color primaryColor = Color(0xFF3F3F8F);

  const TestExamForm({
    super.key,
    required this.questionController,
    required this.dynamicOptions,
    required this.correctAnswerIndex,
    required this.testQuestions,
    required this.onChanged,
    required this.onUpdate,
  });

  void _addOption() => dynamicOptions.add('');

  void _removeOption(int index) {
    dynamicOptions.removeAt(index);
    if (correctAnswerIndex == index) {
      onChanged(null);
    }
  }

  void _addTestQuestion() {
    if (questionController.text.trim().isEmpty ||
        dynamicOptions.any((o) => o.trim().isEmpty) ||
        correctAnswerIndex == null) return;

    testQuestions.add({
      'question': questionController.text.trim(),
      'options': List<String>.from(dynamicOptions),
      'correct': correctAnswerIndex,
    });

    questionController.clear();
    dynamicOptions.clear();
    dynamicOptions.add('');
    onChanged(null);
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
            const Text('Тест: вопрос и варианты',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: 'Вопрос',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(dynamicOptions.length, (i) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Radio<int>(
                    value: i,
                    groupValue: correctAnswerIndex,
                    activeColor: primaryColor,
                    onChanged: onChanged,
                  ),
                  title: TextField(
                    decoration: InputDecoration(
                      hintText: 'Вариант ${i + 1}',
                      border: InputBorder.none,
                    ),
                    onChanged: (val) => dynamicOptions[i] = val,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _removeOption(i);
                      onUpdate();
                    },
                  ),
                ),
              );
            }),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  _addOption();
                  onUpdate();
                },
                icon: const Icon(Icons.add),
                label: const Text('Добавить вариант'),
              ),
            ),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: _addTestQuestion,
              icon: const Icon(Icons.check),
              label: const Text('Добавить вопрос'),
            ),
            const SizedBox(height: 16),
            ...testQuestions.map((q) => Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(q['question'], style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(q['options'].length, (i) => Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        Icon(
                          i == q['correct'] ? Icons.check_circle : Icons.circle_outlined,
                          size: 16,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Flexible(child: Text(q['options'][i])),
                      ],
                    ),
                  )),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: primaryColor),
                      onPressed: () {
                        questionController.text = q['question'];
                        dynamicOptions
                          ..clear()
                          ..addAll(List<String>.from(q['options']));
                        onChanged(q['correct']);
                        testQuestions.remove(q);
                        onUpdate();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        testQuestions.remove(q);
                        onUpdate();
                      },
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}