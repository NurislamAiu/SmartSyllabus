import 'package:flutter/material.dart';

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
  final _outcomesController = TextEditingController();

  String semester = 'Осенний 2024';
  String controlType = 'Устный';

  final List<String> learningOutcomes = [];
  final List<String> literature = [];
  final List<String> examQuestions = [];

  void _addItemDialog(String title, List<String> targetList) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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

  void _saveSyllabus() {
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
      // TODO: сохранить в Firebase или локально
      Navigator.pop(context);
    }
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildChipList(List<String> list, Color color) {
    return Wrap(
      spacing: 8,
      children: list
          .map((e) => Chip(
        label: Text(e),
        backgroundColor: color.withOpacity(0.1),
        labelStyle: TextStyle(color: color),
        onDeleted: () => setState(() => list.remove(e)),
      ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Создание силабуса'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Основные поля
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название дисциплины'),
                validator: (value) => value!.isEmpty ? 'Обязательное поле' : null,
              ),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Код дисциплины'),
              ),
              TextFormField(
                controller: _programController,
                decoration: const InputDecoration(labelText: 'Образовательная программа'),
              ),
              TextFormField(
                controller: _creditsController,
                decoration: const InputDecoration(labelText: 'Кредиты'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _lecturerController,
                decoration: const InputDecoration(labelText: 'Преподаватель'),
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(labelText: 'Контакты (email, номер)'),
              ),

              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: semester,
                decoration: const InputDecoration(labelText: 'Семестр'),
                items: ['Осенний 2024', 'Весенний 2025']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => semester = val!),
              ),
              DropdownButtonFormField<String>(
                value: controlType,
                decoration: const InputDecoration(labelText: 'Форма контроля'),
                items: ['Устный', 'Письменный', 'Тест']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
                onPressed: () => _addItemDialog('Добавить результат обучения', learningOutcomes),
                icon: const Icon(Icons.add),
                label: const Text('Добавить'),
              ),

              _buildSectionTitle('Литература'),
              _buildChipList(literature, Colors.blue),
              TextButton.icon(
                onPressed: () => _addItemDialog('Добавить источник', literature),
                icon: const Icon(Icons.add),
                label: const Text('Добавить'),
              ),

              _buildSectionTitle('Экзаменационные вопросы'),
              _buildChipList(examQuestions, Colors.orange),
              TextButton.icon(
                onPressed: () => _addItemDialog('Добавить вопрос', examQuestions),
                icon: const Icon(Icons.add),
                label: const Text('Добавить'),
              ),

              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveSyllabus,
                  icon: const Icon(Icons.check),
                  label: const Text('Сохранить силабус'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    backgroundColor: const Color(0xFF3F3F8F),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}