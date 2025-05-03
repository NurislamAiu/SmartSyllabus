import 'package:flutter/material.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Преподаватели')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StaffTile(name: 'Ахметова Д.А.', department: 'Информатика', documents: 5),
          _StaffTile(name: 'Серик Б.К.', department: 'Физика', documents: 3),
          _StaffTile(name: 'Смагулова А.М.', department: 'История', documents: 4),
        ],
      ),
    );
  }
}

class _StaffTile extends StatelessWidget {
  final String name;
  final String department;
  final int documents;

  const _StaffTile({
    required this.name,
    required this.department,
    required this.documents,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.person),
        title: Text(name),
        subtitle: Text('Кафедра: $department\nДокументов: $documents'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: перейти к документам преподавателя
        },
      ),
    );
  }
}
