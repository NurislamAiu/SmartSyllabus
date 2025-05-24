import 'package:flutter/material.dart';
import '../widgets/create_syllabus_form.dart';

class CreateSyllabusScreen extends StatelessWidget {
  const CreateSyllabusScreen({super.key});

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: CreateSyllabusForm(),
      ),
    );
  }
}