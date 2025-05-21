import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:teacher_app/src/core/router/route_names.dart';

import '../../../../core/router/route_paths.dart';

class Syllabus {
  final String title;
  final String description;
  final DateTime createdAt;
  final String status; // approved, pending, draft
  final bool isAI;

  Syllabus({
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
    this.isAI = false,
  });
}

String _extractBetween(String text, String start, String end) {
  try {
    final startIndex = text.indexOf(start);
    final endIndex = text.indexOf(end, startIndex + start.length);
    if (startIndex == -1 || endIndex == -1) return '';
    return text.substring(startIndex + start.length, endIndex).trim();
  } catch (_) {
    return '';
  }
}

final List<Syllabus> mockSyllabusList = [
  Syllabus(
    title: 'Информатика 1 курс',
    description: 'Цифровая грамотность и основы программирования',
    createdAt: DateTime(2024, 9, 1),
    status: 'approved',
    isAI: false,
  ),
  Syllabus(
    title: 'История Казахстана',
    description: 'Хронология, ключевые события и личности',
    createdAt: DateTime(2024, 9, 5),
    status: 'pending',
    isAI: true,
  ),
  Syllabus(
    title: 'Педагогика',
    description: 'Методы преподавания и психология обучения',
    createdAt: DateTime(2024, 9, 8),
    status: 'draft',
    isAI: false,
  ),
];

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({super.key});

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
              // Заголовок
              Text(
                'Создать силабус',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // AI
              _CreateOptionCard(
                icon: Icons.smart_toy,
                title: 'Сгенерировать с помощью AI',
                subtitle: 'Автоматически создать структуру силабуса',
                onTap: () {
                  Navigator.pop(context);
                },
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ),
              ),
              const SizedBox(height: 12),

              // Вручную
              _CreateOptionCard(
                icon: Icons.edit,
                title: 'Создать вручную',
                subtitle: 'Ввести все поля самостоятельно',
                onTap: () {
                  // Закрыть диалог из самого "корневого" контекста
                  Navigator.of(context, rootNavigator: true).pop();

                  // Навигация — немного позже
                  Future.delayed(Duration.zero, () {
                    GoRouter.of(context).push(RoutePaths.createSyllabus);
                  });
                },
                gradient: const LinearGradient(
                  colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
                ),
              ),
              const SizedBox(height: 12),

              // Импорт
              _CreateOptionCard(
                icon: Icons.upload_file,
                title: 'Импортировать из файла',
                subtitle: 'Загрузить готовый силабус',
                  onTap: () async {
                    Navigator.of(context, rootNavigator: true).pop();

                    final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );

                    if (result != null && result.files.single.path != null) {
                      final file = File(result.files.single.path!);
                      final bytes = await file.readAsBytes();
                      final document = PdfDocument(inputBytes: bytes);
                      final rawText = PdfTextExtractor(document).extractText();
                      document.dispose();

                      final text = rawText.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');

                      final title = _extractBetween(text, 'по дисциплине', '(код');
                      final code = _extractBetween(text, 'по дисциплине', 'Программирование')
                          .split(' ')
                          .firstWhere((e) => e.startsWith('JP'), orElse: () => '');

                      final program = _extractBetween(text, 'по образовательной программе', 'осенний');
                      final credits = _extractBetween(text, 'Кол-во кредитов -', 'Всего');
                      final controlType = _extractBetween(text, 'итогового контроля', 'Лекции').trim().toLowerCase();
                      final lecturer = _extractBetween(text, 'Лектор', 'e-mail');
                      final contact = _extractBetween(text, 'e-mail и телефон:', 'Zoom ID');
                      final goal = _extractBetween(text, 'Целью изучения дисциплины', 'РО');

                      // 🔍 Универсальный парсинг всех РО (РО10 — ...; РО11 — ...)
                      final outcomes = RegExp(r'(РО\d{1,2})\s*[-–—]\s*(.*?)(?=(РО\d{1,2})|$)', dotAll: true)
                          .allMatches(text)
                          .map((match) => '${match.group(1)} — ${match.group(2)?.trim()}')
                          .toList();

                      // 📚 Литература
                      final litStart = text.indexOf('Литература');
                      final litEnd = text.indexOf('Интернет ресурсы');
                      final literature = litStart != -1 && litEnd != -1
                          ? RegExp(r'\d+\.\s(.*?)\s(?=\d+\.\s|Интернет ресурсы|$)', dotAll: true)
                          .allMatches(text.substring(litStart, litEnd))
                          .map((m) => m.group(1)!.trim())
                          .toList()
                          : [];

                      // ❓ Вопросы
                      final exStart = text.indexOf('Экзаменационные вопросы');
                      final examQuestions = exStart != -1
                          ? RegExp(r'\d+\.\s(.*?)(?=\d+\.\s|$)', dotAll: true)
                          .allMatches(text.substring(exStart))
                          .map((m) => m.group(1)!.trim())
                          .toList()
                          : [];

                      print('📄 Название: $title');
                      print('📄 Код: $code');
                      print('📄 Программа: $program');
                      print('📄 Кредиты: $credits');
                      print('📄 Контроль: $controlType');
                      print('📄 Преподаватель: $lecturer');
                      print('📄 Контакт: $contact');
                      print('📄 Цель: $goal');
                      print('🧠 Результаты обучения: ${outcomes.length}');
                      print('📚 Литература: ${literature.length}');
                      print('❓ Вопросы: ${examQuestions.length}');

                      Future.microtask(() {
                        GoRouter.of(context).pushNamed(
                          RouteNames.createSyllabus,
                          extra: {
                            'title': title,
                            'code': code,
                            'program': program,
                            'credits': credits.trim(),
                            'lecturer': lecturer,
                            'contact': contact,
                            'controlType': controlType,
                            'goal': goal,
                            'outcomes': outcomes,
                            'literature': literature,
                            'examQuestions': examQuestions,
                          },
                        );
                      });
                    }
                  },
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
                ),
              ),
            ],
          ),
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
        if (isAI)
          const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Icon(Icons.smart_toy, size: 18, color: Colors.deepPurple),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок и кнопка
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Syllabus',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showCreateDialog(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3F3F8F), Color(0xFF5A5AD6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
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
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.add, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Создать силабус',
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

              // Подзаголовок
              Text(
                'Мои силабусы',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Список силабусов
              ...mockSyllabusList.map((syllabus) {
                final dateStr = DateFormat('dd MMM yyyy', 'ru').format(syllabus.createdAt);

                return InkWell(
                  onTap: () {
                    // TODO: переход к деталям силабуса
                    debugPrint('Открыть: ${syllabus.title}');
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Иконка / статус
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

                        // Контент
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                syllabus.title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                syllabus.description,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[800]),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatusChip(syllabus.status, syllabus.isAI),
                                  Text(
                                    'Создан: $dateStr',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Gradient gradient;

  const _CreateOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradient,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.grey[700])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}