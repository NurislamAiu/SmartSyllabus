import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;

class CreateSyllabusScreen extends StatefulWidget {
  const CreateSyllabusScreen({super.key});

  @override
  State<CreateSyllabusScreen> createState() => _CreateSyllabusScreenState();
}

class _CreateSyllabusScreenState extends State<CreateSyllabusScreen> {
  final _formKey = GlobalKey<FormState>();

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

        final controlFromExtra =
            (extra['controlType'] ?? '').toString().toLowerCase();
        if (controlFromExtra.contains('пись'))
          controlType = 'Письменный';
        else if (controlFromExtra.contains('тест'))
          controlType = 'Тест';
        else if (controlFromExtra.contains('уст'))
          controlType = 'Устный';

        final List<String>? litList = extra['literature']?.cast<String>();
        if (litList != null) literature.addAll(litList);

        final List<String>? questionList =
            extra['examQuestions']?.cast<String>();
        if (questionList != null) examQuestions.addAll(questionList);

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
      await generatePdfSkeleton();

      Navigator.pop(context);
    }
  }

  Future<void> generatePdfSkeleton() async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    final bold = pw.TextStyle(
      font: ttf,
      fontWeight: pw.FontWeight.bold,
      fontSize: 8,
    );
    final normal = pw.TextStyle(font: ttf, fontSize: 9);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        theme: pw.ThemeData.withFont(base: ttf),
        build:
            (context) => [
              pw.Center(
                child: pw.Text('АСТАНА ХАЛЫҚАРАЛЫҚ УНИВЕРСИТЕТІ', style: bold),
              ),
              pw.Center(
                child: pw.Text('МЕЖДУНАРОДНЫЙ УНИВЕРСИТЕТ АСТАНА', style: bold),
              ),
              pw.SizedBox(height: 20),

              /// Заголовок "Общая информация"
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {0: pw.FlexColumnWidth(1)},
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Общая информация', style: bold),
                      ),
                    ],
                  ),
                ],
              ),

              /// Таблица с данными
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(5),
                  2: pw.FlexColumnWidth(2),
                  3: pw.FlexColumnWidth(2),
                },
                children: [
                  /// Первая строка
                  pw.TableRow(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Код и название дисциплины',
                          style: bold,
                        ),
                      ),
                      pw.Column(
                        children: [
                          pw.Container(
                            alignment: pw.Alignment.center,
                            padding: const pw.EdgeInsets.all(6),
                            child: pw.Text('Кол-во кредитов – 6', style: bold),
                          ),
                          pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {
                              0: pw.FlexColumnWidth(1),
                              1: pw.FlexColumnWidth(2.5),
                              2: pw.FlexColumnWidth(1),
                              3: pw.FlexColumnWidth(1),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Center(
                                    child: pw.Padding(
                                      padding: const pw.EdgeInsets.all(4),
                                      child: pw.Text('Лекции', style: bold),
                                    ),
                                  ),
                                  pw.Center(
                                    child: pw.Padding(
                                      padding: const pw.EdgeInsets.all(4),
                                      child: pw.Text(
                                        'Семинары/\nпракт./лаб. занятия',
                                        style: bold,
                                      ),
                                    ),
                                  ),
                                  pw.Center(
                                    child: pw.Padding(
                                      padding: const pw.EdgeInsets.all(4),
                                      child: pw.Text('СРСП', style: bold),
                                    ),
                                  ),
                                  pw.Center(
                                    child: pw.Padding(
                                      padding: const pw.EdgeInsets.all(4),
                                      child: pw.Text('СРС', style: bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      pw.Center(child: pw.Text('Всего\nчасов', style: bold)),
                      pw.Center(
                        child: pw.Text(
                          'Форма\nитогового\nконтроля',
                          style: bold,
                        ),
                      ),
                    ],
                  ),

                  /// Вторая строка (пустая, можно будет заполнить)
                  pw.TableRow(
                    children: [
                      pw.Container(height: 20),
                      pw.Table(
                        border: pw.TableBorder.all(),
                        columnWidths: {
                          0: pw.FlexColumnWidth(1),
                          1: pw.FlexColumnWidth(2.5),
                          2: pw.FlexColumnWidth(1),
                          3: pw.FlexColumnWidth(1),
                        },
                        children: [
                          pw.TableRow(
                            children: List.generate(4, (_) {
                              return pw.Container(height: 20);
                            }),
                          ),
                        ],
                      ),
                      pw.Container(height: 20),
                      pw.Container(height: 20),
                    ],
                  ),
                ],
              ),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {0: pw.FlexColumnWidth(1)},
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Контактная информация', style: bold),
                      ),
                    ],
                  ),
                ],
              ),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(9),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Высшая школа', style: bold),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'Информационных технологий и инженерии',
                          style: normal,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Лектор', style: bold),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'Қайұпов Е.К., старший преподаватель',
                          style: normal,
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('e-mail и телефон:', style: bold),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('yerik.kai@gmail.com', style: normal),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Zoom ID', style: bold),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('', style: normal),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Ассистент', style: bold),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('', style: normal),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('e-mail и телефон:', style: bold),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('', style: normal),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {0: pw.FlexColumnWidth(1)},
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Академическая информация', style: bold),
                      ),
                    ],
                  ),
                ],
              ),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(4),
                  1: pw.FlexColumnWidth(6),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text(
                        'Краткое описание дисциплины\n(согласно ЕСУВО)',
                        style: bold,
                      ),
                      pw.Text(
                        'Результаты обучения\n(согласно ЕСУВО)',
                        style: bold,
                      ),
                    ],
                  ),

                  pw.TableRow(
                    children: [
                      pw.Text(' ', style: normal),

                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(' ', style: normal),

                          pw.SizedBox(height: 6),

                          pw.Table(
                            border: pw.TableBorder.all(),
                            columnWidths: {
                              0: pw.FlexColumnWidth(1),
                              1: pw.FlexColumnWidth(1),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Text(
                                    'PO 10,11,15 по дисциплине',
                                    style: bold,
                                  ),
                                  pw.Text(
                                    'Индикаторы достижения PO по дисциплине',
                                    style: bold,
                                  ),
                                ],
                              ),
                              pw.TableRow(
                                children: [
                                  pw.Text(' ', style: normal),
                                  pw.Text(' ', style: normal),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(4),
                  1: pw.FlexColumnWidth(6),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('Пререквизиты', style: bold),
                      pw.Text('', style: normal),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('Постреквизиты', style: bold),
                      pw.Text('', style: normal),
                    ],
                  ),
                ],
              ),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(4),
                  1: pw.FlexColumnWidth(6),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('Литература и ресурсы**', style: bold),
                      pw.Text('', style: normal),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 10),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {0: pw.FlexColumnWidth(10)},
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        alignment: pw.Alignment.center,
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Политика дисциплины', style: bold),
                      ),
                    ],
                  ),

                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        height: 150,
                        child: pw.Text('', style: normal),
                      ),
                    ],
                  ),
                ],
              ),

              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(7),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          'Политика оценивания и аттестации',
                          style: bold,
                        ),
                      ),
                      pw.Container(
                        padding: const pw.EdgeInsets.all(6),
                        height: 200,
                        child: pw.Text('', style: normal),
                      ),
                    ],
                  ),
                ],
              ),
            ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/syllabus_skeleton.pdf');
    await file.writeAsBytes(await pdf.save());

    debugPrint('✅ Каркас PDF сохранён: ${file.path}');
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
