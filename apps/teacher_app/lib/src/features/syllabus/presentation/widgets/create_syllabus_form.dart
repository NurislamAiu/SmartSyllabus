
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/remote_syllabus_repository.dart';
import '../widgets/syllabus_form_helpers.dart';

class CreateSyllabusForm extends StatefulWidget {
  const CreateSyllabusForm({super.key});

  @override
  State<CreateSyllabusForm> createState() => _CreateSyllabusFormState();
}

class _CreateSyllabusFormState extends State<CreateSyllabusForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _codeController = TextEditingController();
  final _programController = TextEditingController();
  final _creditsController = TextEditingController();
  final _lecturerController = TextEditingController();
  final _contactController = TextEditingController();
  final _zoomController = TextEditingController();
  final _assistantController = TextEditingController();
  final _assistantContactController = TextEditingController();
  final _goalController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _prerequisiteController = TextEditingController();
  final _postrequisiteController = TextEditingController();
  final _resourcesController = TextEditingController();
  final _softwareController = TextEditingController();
  final _policyController = TextEditingController();
  final _assessmentController = TextEditingController();
  final _topicsPlanController = TextEditingController();

  String semester = 'Осенний 2024';
  String controlType = 'Устный';

  final List<String> learningOutcomes = [];
  final List<String> literature = [];
  final List<String> examQuestions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extra != null) {
      _titleController.text = extra['title'] ?? '';
      _codeController.text = extra['code'] ?? '';
      _programController.text = extra['program'] ?? '';
      _creditsController.text = extra['credits'] ?? '';
      _lecturerController.text = extra['lecturer'] ?? '';
      _contactController.text = extra['contact'] ?? '';
      _zoomController.text = extra['zoom'] ?? '';
      _assistantController.text = extra['assistant'] ?? '';
      _assistantContactController.text = extra['assistantContact'] ?? '';
      _goalController.text = extra['goal'] ?? '';
      _descriptionController.text = extra['description'] ?? '';
      _prerequisiteController.text = extra['prerequisite'] ?? '';
      _postrequisiteController.text = extra['postrequisite'] ?? '';
      _resourcesController.text = extra['resources'] ?? '';
      _softwareController.text = extra['software'] ?? '';
      _policyController.text = extra['policy'] ?? '';
      _assessmentController.text = extra['assessment'] ?? '';
      _topicsPlanController.text = extra['topicsPlan'] ?? '';

      final s = extra['semester'];
      if (s != null && ['Осенний 2024', 'Весенний 2025'].contains(s)) {
        semester = s;
      }

      final c = (extra['controlType'] ?? '').toString().toLowerCase();
      if (c.contains('уст')) {
        controlType = 'Устный';
      } else if (c.contains('пись')) {
        controlType = 'Письменный';
      } else if (c.contains('тест')) {
        controlType = 'Тест';
      }

      learningOutcomes.addAll(List<String>.from(extra['outcomes'] ?? []));
      literature.addAll(List<String>.from(extra['literature'] ?? []));
      examQuestions.addAll(List<String>.from(extra['examQuestions'] ?? []));
    }
  }


  final _remote = SyllabusRemoteDataSource();

  void _saveSyllabus() async {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'title': _titleController.text,
        'code': _codeController.text,
        'program': _programController.text,
        'credits': int.tryParse(_creditsController.text),
        'lecturer': _lecturerController.text,
        'contact': _contactController.text,
        'zoom': _zoomController.text,
        'assistant': _assistantController.text,
        'assistantContact': _assistantContactController.text,
        'goal': _goalController.text,
        'description': _descriptionController.text,
        'prerequisite': _prerequisiteController.text,
        'postrequisite': _postrequisiteController.text,
        'resources': _resourcesController.text,
        'software': _softwareController.text,
        'policy': _policyController.text,
        'assessment': _assessmentController.text,
        'topicsPlan': _topicsPlanController.text,
        'semester': semester,
        'controlType': controlType,
        'outcomes': learningOutcomes,
        'literature': literature,
        'examQuestions': examQuestions,
      };

      try {
        await _remote.createSyllabus(data);
        if (mounted) {
          Navigator.pop(context); // вернуться назад
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _codeController.dispose();
    _programController.dispose();
    _creditsController.dispose();
    _lecturerController.dispose();
    _contactController.dispose();
    _zoomController.dispose();
    _assistantController.dispose();
    _assistantContactController.dispose();
    _goalController.dispose();
    _descriptionController.dispose();
    _prerequisiteController.dispose();
    _postrequisiteController.dispose();
    _resourcesController.dispose();
    _softwareController.dispose();
    _policyController.dispose();
    _assessmentController.dispose();
    _topicsPlanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SyllabusFormHelpers.buildSectionTitle(context, 'Основная информация'),
          SyllabusFormHelpers.buildTextField('Название дисциплины', _titleController),
          SyllabusFormHelpers.buildTextField('Код дисциплины', _codeController),
          SyllabusFormHelpers.buildTextField('Образовательная программа', _programController),
          SyllabusFormHelpers.buildTextField('Кредиты', _creditsController, keyboard: TextInputType.number),
          SyllabusFormHelpers.buildTextField('Преподаватель', _lecturerController),
          SyllabusFormHelpers.buildTextField('Контакты (email, номер)', _contactController),
          SyllabusFormHelpers.buildTextField('Zoom ID', _zoomController),
          SyllabusFormHelpers.buildTextField('Ассистент', _assistantController),
          SyllabusFormHelpers.buildTextField('Контакты ассистента', _assistantContactController),
          SyllabusFormHelpers.buildDropdownField('Семестр', semester, ['Осенний 2024', 'Весенний 2025'], (val) => setState(() => semester = val!)),
          SyllabusFormHelpers.buildDropdownField('Форма контроля', controlType, ['Устный', 'Письменный', 'Тест'], (val) => setState(() => controlType = val!)),
          SyllabusFormHelpers.buildSectionTitle(context, 'Краткое описание дисциплины'),
          SyllabusFormHelpers.buildMultilineField('Описание', _descriptionController),
          SyllabusFormHelpers.buildSectionTitle(context, 'Результаты обучения'),
          SyllabusFormHelpers.buildChipList(learningOutcomes, Colors.deepPurple, () => setState(() {})),
          SyllabusFormHelpers.buildAddButton('Добавить результат обучения', learningOutcomes, context, () => setState(() {})),
          SyllabusFormHelpers.buildSectionTitle(context, 'Пререквизиты и Постреквизиты'),
          SyllabusFormHelpers.buildTextField('Пререквизиты', _prerequisiteController),
          SyllabusFormHelpers.buildTextField('Постреквизиты', _postrequisiteController),
          SyllabusFormHelpers.buildSectionTitle(context, 'Литература'),
          SyllabusFormHelpers.buildChipList(literature, Colors.blue, () => setState(() {})),
          SyllabusFormHelpers.buildAddButton('Добавить источник', literature, context, () => setState(() {})),
          SyllabusFormHelpers.buildSectionTitle(context, 'Интернет-ресурсы и ПО'),
          SyllabusFormHelpers.buildMultilineField('Интернет-ресурсы', _resourcesController),
          SyllabusFormHelpers.buildTextField('Программное обеспечение', _softwareController),
          SyllabusFormHelpers.buildSectionTitle(context, 'Политика дисциплины'),
          SyllabusFormHelpers.buildMultilineField('Описание политики', _policyController),
          SyllabusFormHelpers.buildSectionTitle(context, 'Политика оценивания и аттестации'),
          SyllabusFormHelpers.buildMultilineField('Критерии и требования', _assessmentController),
          SyllabusFormHelpers.buildSectionTitle(context, 'Тематический план дисциплины (названия тем)'),
          SyllabusFormHelpers.buildMultilineField('План на 15 недель', _topicsPlanController),
          SyllabusFormHelpers.buildSectionTitle(context, 'Экзаменационные вопросы'),
          SyllabusFormHelpers.buildChipList(examQuestions, Colors.orange, () => setState(() {})),
          SyllabusFormHelpers.buildAddButton('Добавить вопрос', examQuestions, context, () => setState(() {})),
          const SizedBox(height: 24),
          Center(
            child: GestureDetector(
              onTap: _saveSyllabus,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(colors: [Color(0xFF3F3F8F), Color(0xFF5A5AD6)]),
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
                    Text('Сохранить силабус', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}