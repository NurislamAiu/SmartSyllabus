import 'package:flutter/material.dart';

class LiteratureScreen extends StatelessWidget {
  const LiteratureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Учебная литература')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _BookTile(title: 'Основы программирования', author: 'К. Танат', year: 2022),
          _BookTile(title: 'История Казахстана', author: 'А. Жумабаев', year: 2020),
          _BookTile(title: 'Биология 11 класс', author: 'Г. Баймуханова', year: 2023),
        ],
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  final String title;
  final String author;
  final int year;

  const _BookTile({
    required this.title,
    required this.author,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.menu_book),
        title: Text(title),
        subtitle: Text('Автор: $author\nГод: $year'),
        trailing: Wrap(
          spacing: 8,
          children: const [
            Icon(Icons.check, color: Colors.green),
            Icon(Icons.clear, color: Colors.red),
          ],
        ),
        onTap: () {
          // TODO: открыть подробности книги
        },
      ),
    );
  }
}
