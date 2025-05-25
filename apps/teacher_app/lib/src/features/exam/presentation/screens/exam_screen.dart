import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../syllabus/presentation/widgets/create_option_card.dart';
import '../../data/mock_exam_repository.dart';
import '../../data/exam_model.dart';
import '../widgets/exam_card.dart';
import '../../../../core/router/route_names.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key});

  static const Color primaryColor = Color(0xFF3F3F8F);

  void _openManualExamForm(BuildContext context) {
    context.pushNamed(RouteNames.manualExamForm);
  }

  void _openAIGeneratedExam(BuildContext context) {
    context.pushNamed(RouteNames.aiGeneratedExam);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Exams',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () => _showCreateDialog(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F3F8F), Color(0xFF5A5AD6)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Создать экзамен',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Мои экзамены',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: mockExamList.isEmpty
                  ? const Center(child: Text('Нет созданных экзаменов'))
                  : ListView.separated(
                itemCount: mockExamList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => ExamCard(exam: mockExamList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Создать экзамен',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // AI создание
              CreateOptionCard(
                icon: Icons.smart_toy,
                title: 'Сгенерировать с помощью AI',
                subtitle: 'Автоматически создать структуру экзамена',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  _openAIGeneratedExam(context);
                },
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ),
              ),

              const SizedBox(height: 12),

              // Вручную
              CreateOptionCard(
                icon: Icons.edit_note,
                title: 'Создать вручную',
                subtitle: 'Заполнить данные самостоятельно',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  _openManualExamForm(context);
                },
                gradient: const LinearGradient(
                  colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}