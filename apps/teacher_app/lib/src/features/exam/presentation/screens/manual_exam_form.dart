import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../data/exam_model.dart';
import '../../data/exam_remote_datasource.dart';
import '../widgets/section_card_widget.dart';
import '../widgets/test_exam_form.dart';
import '../widgets/project_exam_form.dart';
import '../widgets/oral_exam_form.dart';

class ManualExamForm extends StatefulWidget {
  const ManualExamForm({super.key});

  @override
  State<ManualExamForm> createState() => _ManualExamFormState();
}

class _ManualExamFormState extends State<ManualExamForm> {
  final _formKey = GlobalKey<FormState>();
  final _remote = ExamRemoteDataSource();

  final _titleController = TextEditingController();
  final _criteriaController = TextEditingController();
  final _questionController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final _projectRequirementsController = TextEditingController();

  final List<String> _oralQuestions = [];
  final List<Map<String, dynamic>> _testQuestions = [];
  final List<String> _dynamicOptions = [''];
  int? _correctAnswerIndex;

  String? _selectedType;
  DateTime? _selectedDate;
  final List<String> _examTypes = ['Проект', 'Тест', 'Устный'];

  static const Color primaryColor = Color(0xFF3F3F8F);

  void _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _saveExam() async {
    if (!_formKey.currentState!.validate() || _selectedType == null || _selectedDate == null) return;

    List<String> finalQuestions = [];
    String criteria = _criteriaController.text;

    if (_selectedType == 'Тест') {
      if (_testQuestions.isEmpty) return;
      finalQuestions = _testQuestions
          .map((q) => "${q['question']} (Правильный: ${q['options'][q['correct']]})")
          .toList();
      criteria = 'Оценка по правильным ответам';
    } else if (_selectedType == 'Устный') {
      finalQuestions = List.from(_oralQuestions);
    } else if (_selectedType == 'Проект') {
      finalQuestions = [
        'Описание: ${_projectDescriptionController.text}',
        'Требования: ${_projectRequirementsController.text}',
      ];
    }

    final exam = ExamModel(
      title: _titleController.text,
      type: _selectedType!,
      questions: finalQuestions,
      criteria: criteria,
      date: _selectedDate!,
    );

    try {
      await _remote.createExam(exam);
      if (context.mounted) context.pop(); // Закрыть форму
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при сохранении: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _selectedDate != null
        ? DateFormat('dd.MM.yyyy').format(_selectedDate!)
        : 'Не выбрано';

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: primaryColor),
        title: const Text('Создание экзамена', style: TextStyle(color: primaryColor)),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SectionCardWidget(
                icon: Icons.title,
                title: 'Основная информация',
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Название экзамена',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.isEmpty ? 'Введите название' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Тип экзамена',
                        border: OutlineInputBorder(),
                      ),
                      items: _examTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      value: _selectedType,
                      onChanged: (val) => setState(() => _selectedType = val),
                      validator: (val) => val == null ? 'Выберите тип' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 20, color: primaryColor),
                        const SizedBox(width: 8),
                        Text('Дата экзамена: $formattedDate'),
                        const Spacer(),
                        TextButton(
                          onPressed: () => _pickDate(context),
                          child: const Text('Выбрать дату'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (_selectedType == 'Тест')
                TestExamForm(
                  questionController: _questionController,
                  dynamicOptions: _dynamicOptions,
                  correctAnswerIndex: _correctAnswerIndex,
                  testQuestions: _testQuestions,
                  onChanged: (val) => setState(() => _correctAnswerIndex = val),
                  onUpdate: () => setState(() {}),
                ),
              if (_selectedType == 'Проект')
                ProjectExamForm(
                  descriptionController: _projectDescriptionController,
                  requirementsController: _projectRequirementsController,
                  criteriaController: _criteriaController,
                ),
              if (_selectedType == 'Устный')
                OralExamForm(
                  questionController: _questionController,
                  criteriaController: _criteriaController,
                  oralQuestions: _oralQuestions,
                  onUpdate: () => setState(() {}),
                ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 4,
                  ),
                  onPressed: _saveExam,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Сохранить экзамен'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}