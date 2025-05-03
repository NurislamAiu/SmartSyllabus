import 'package:flutter/material.dart';

class LiteratureScreen extends StatelessWidget {
  const LiteratureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Учебная литература')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _BookTile(
            title: 'Алгоритмы и структуры данных',
            author: 'Н. Вирт',
            required: true,
          ),
          _BookTile(
            title: 'Основы педагогики',
            author: 'Сластёнин В.А.',
            required: false,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: добавить новую литературу
            },
            icon: const Icon(Icons.add),
            label: const Text('Добавить книгу'),
          ),
        ],
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  final String title;
  final String author;
  final bool required;

  const _BookTile({
    required this.title,
    required this.author,
    required this.required,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(required ? Icons.book : Icons.menu_book_outlined,
          color: required ? Colors.redAccent : Colors.grey),
      title: Text(title),
      subtitle: Text(author),
      trailing: required ? const Text('Обязательная') : const Text('Дополнительная'),
    );
  }
}
