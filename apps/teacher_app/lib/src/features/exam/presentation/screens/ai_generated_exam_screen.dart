import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/exam_model.dart';
import '../../data/mock_exam_repository.dart';

class AIGeneratedExamScreen extends StatefulWidget {
  const AIGeneratedExamScreen({super.key});

  @override
  State<AIGeneratedExamScreen> createState() => _AIGeneratedExamScreenState();
}

class _AIGeneratedExamScreenState extends State<AIGeneratedExamScreen> {
  final TextEditingController _topicController = TextEditingController();
  bool isLoading = false;
  String? selectedType;
  int phraseIndex = 0;

  final List<String> phrases = [
    '🔍 Анализируем тему...',
    '🤖 Подключаем ИИ...',
    '📚 Генерируем вопросы...',
    '✍️ Формируем структуру...',
    '✅ Завершаем генерацию...'
  ];

  final List<String> types = ['Тест', 'Устный', 'Проект'];

  Future<void> _generateExam() async {
    final topic = _topicController.text.trim();
    if (topic.isEmpty || selectedType == null) return;

    setState(() {
      isLoading = true;
      phraseIndex = 0;
    });

    for (int i = 0; i < phrases.length; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() => phraseIndex = i);
    }

    final generatedExam = ExamModel(
      title: 'Генерация по теме: $topic',
      type: selectedType!,
      questions: [
        'Что такое Flutter?',
        'Основные виджеты в Flutter?',
        'Как работает состояние (State)?'
      ],
      criteria: 'Правильные ответы',
      date: DateTime.now(),
    );

    setState(() {
      isLoading = false;
      mockExamList.insert(0, generatedExam);
    });

    if (context.mounted) {
      GoRouter.of(context).pop(generatedExam);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFF9F9FB),
          appBar: AppBar(
            title: const Text('AI Генерация экзамена'),
            backgroundColor: Colors.white,
            foregroundColor: Color(0xFF3F3F8F),
            elevation: 1,
            surfaceTintColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Введите тему экзамена:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    hintText: 'Например: Основы Flutter',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Выберите тип экзамена',
                  ),
                  value: selectedType,
                  items: types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                  onChanged: (val) => setState(() => selectedType = val),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isLoading ? null : _generateExam,
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Сгенерировать экзамен'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF3F3F8F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Загрузка с анимированными фразами
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Color(0xFF3F3F8F)),
                  const SizedBox(height: 24),
                  Text(
                    phrases[phraseIndex],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}