import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class CreateSyllabusScreen extends StatefulWidget {
  const CreateSyllabusScreen({super.key});

  @override
  State<CreateSyllabusScreen> createState() => _CreateSyllabusScreenState();
}

class _CreateSyllabusScreenState extends State<CreateSyllabusScreen> {
  final _formKey = GlobalKey<FormState>();

  // Контроллеры
  final _titleController = TextEditingController();
  final _codeController = TextEditingController();
  final _programController = TextEditingController();
  final _creditsController = TextEditingController();
  final _lecturerController = TextEditingController();
  final _contactController = TextEditingController();
  final _goalController = TextEditingController();

  String semester = 'Осенний 2024';
  String controlType = 'Устный';

  final List<String> learningOutcomes = [];
  final List<String> literature = [];
  final List<String> examQuestions = [];

  @override
  void initState() {
    super.initState();

    // Получаем данные из GoRouter.extra
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

      if (extra != null) {
        _titleController.text = extra['title'] ?? '';
        _codeController.text = extra['code'] ?? '';
        _programController.text = extra['program'] ?? '';
        _creditsController.text = extra['credits'] ?? '';
        _lecturerController.text = extra['lecturer'] ?? '';
        _contactController.text = extra['contact'] ?? '';
        _goalController.text = extra['goal'] ?? '';

        // Автоустановка формы контроля
        final controlFromExtra =
            (extra['controlType'] ?? '').toString().toLowerCase();
        if (controlFromExtra.contains('пись'))
          controlType = 'Письменный';
        else if (controlFromExtra.contains('тест'))
          controlType = 'Тест';
        else if (controlFromExtra.contains('уст'))
          controlType = 'Устный';

        // Литература
        final List<String>? litList = extra['literature']?.cast<String>();
        if (litList != null) literature.addAll(litList);

        // Вопросы
        final List<String>? questionList =
            extra['examQuestions']?.cast<String>();
        if (questionList != null) examQuestions.addAll(questionList);

        // Результаты обучения
        final List<String>? outcomesList = extra['outcomes']?.cast<String>();
        if (outcomesList != null) learningOutcomes.addAll(outcomesList);
      }
    });
  }

  void _addItemDialog(String title, List<String> targetList) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Введите текст'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    setState(() => targetList.add(controller.text.trim()));
                  }
                  Navigator.pop(context);
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
    );
  }

  Future<void> _saveSyllabus() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'title': _titleController.text,
        'code': _codeController.text,
        'program': _programController.text,
        'credits': int.tryParse(_creditsController.text),
        'lecturer': _lecturerController.text,
        'contact': _contactController.text,
        'semester': semester,
        'controlType': controlType,
        'goal': _goalController.text,
        'outcomes': List<String>.from(learningOutcomes),
        'literature': List<String>.from(literature),
        'examQuestions': List<String>.from(examQuestions),
      };

      debugPrint('✅ Силабус сохранён: $data');
      await generatePdf(data);
      // TODO: сохранить в Firebase или БД
      Navigator.pop(context);
    }
  }


  Future<void> generatePdf(Map<String, dynamic> data) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    final theme = pw.ThemeData.withFont(base: ttf);
    final normal = pw.TextStyle(font: ttf, fontSize: 12);
    final bold = pw.TextStyle(font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold);

    // Главная информация — первая страница
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      theme: theme,
      build: (context) => [
        pw.Text('СИЛАБУС', style: pw.TextStyle(font: ttf, fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 10),
        pw.Text('Название: ${data['title']}', style: normal),
        pw.Text('Код: ${data['code']}', style: normal),
        pw.Text('Программа: ${data['program']}', style: normal),
        pw.Text('Кредиты: ${data['credits']}', style: normal),
        pw.Text('Преподаватель: ${data['lecturer']}', style: normal),
        pw.Text('Контакт: ${data['contact']}', style: normal),
        pw.Text('Семестр: ${data['semester']}', style: normal),
        pw.Text('Контроль: ${data['controlType']}', style: normal),
        pw.SizedBox(height: 12),
        pw.Text('Цель дисциплины:', style: bold),
        pw.Text(data['goal'] ?? '', style: normal),
      ],
    ));

    // ⚙️ Безопасное добавление списка в виде страниц
    void safelyAddList(String title, List items, int chunkSize) {
      for (int i = 0; i < items.length; i += chunkSize) {
        final chunk = items.sublist(i, i + chunkSize > items.length ? items.length : i + chunkSize);
        try {
          pdf.addPage(pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            theme: theme,
            build: (context) => [
              pw.Text(title, style: bold),
              pw.SizedBox(height: 6),
              ...chunk.map((e) => pw.Bullet(text: e.toString(), style: normal)),
            ],
          ));
        } catch (e) {
          debugPrint('❌ Ошибка при добавлении раздела "$title": $e');
        }
      }
    }

    // ✅ Добавление всех разделов с проверками
    if (data['outcomes'] != null && data['outcomes'] is List) {
      safelyAddList('Результаты обучения:', data['outcomes'], 20);
    }

    if (data['literature'] != null && data['literature'] is List) {
      safelyAddList('Литература:', data['literature'], 20);
    }

    if (data['examQuestions'] != null && data['examQuestions'] is List) {
      safelyAddList('Экзаменационные вопросы:', data['examQuestions'], 20);
    }

    // 📂 Сохранение PDF
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/syllabus_${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(await pdf.save());

    debugPrint('✅ PDF сохранён: ${file.path}');
  }


  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChipList(List<String> list, Color color) {
    return Wrap(
      spacing: 8,
      children:
          list
              .map(
                (e) => Chip(
                  label: Text(e),
                  backgroundColor: color.withOpacity(0.1),
                  labelStyle: TextStyle(color: color),
                  onDeleted: () => setState(() => list.remove(e)),
                ),
              )
              .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Создание силабуса'),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Основная информация'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Название дисциплины',
                  ),
                  validator:
                      (value) => value!.isEmpty ? 'Обязательное поле' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    labelText: 'Код дисциплины',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _programController,
                  decoration: const InputDecoration(
                    labelText: 'Образовательная программа',
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _creditsController,
                  decoration: const InputDecoration(labelText: 'Кредиты'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _lecturerController,
                  decoration: const InputDecoration(labelText: 'Преподаватель'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'Контакты (email, номер)',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: semester,
                  decoration: const InputDecoration(labelText: 'Семестр'),
                  items:
                      ['Осенний 2024', 'Весенний 2025']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => semester = val!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: controlType,
                  decoration: const InputDecoration(
                    labelText: 'Форма контроля',
                  ),
                  items:
                      ['Устный', 'Письменный', 'Тест']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => controlType = val!),
                ),
                _buildSectionTitle('Цель дисциплины'),
                TextFormField(
                  controller: _goalController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Введите цель дисциплины',
                  ),
                ),
                _buildSectionTitle('Результаты обучения'),
                _buildChipList(learningOutcomes, Colors.deepPurple),
                TextButton.icon(
                  onPressed:
                      () => _addItemDialog(
                        'Добавить результат обучения',
                        learningOutcomes,
                      ),
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить'),
                ),
                _buildSectionTitle('Литература'),
                _buildChipList(literature, Colors.blue),
                TextButton.icon(
                  onPressed:
                      () => _addItemDialog('Добавить источник', literature),
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить'),
                ),
                _buildSectionTitle('Экзаменационные вопросы'),
                _buildChipList(examQuestions, Colors.orange),
                TextButton.icon(
                  onPressed:
                      () => _addItemDialog('Добавить вопрос', examQuestions),
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить'),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: _saveSyllabus,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3F3F8F), Color(0xFF5A5AD6)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Сохранить силабус',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
