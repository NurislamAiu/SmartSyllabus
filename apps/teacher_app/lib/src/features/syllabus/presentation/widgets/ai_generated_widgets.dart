import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teacher_app/src/features/syllabus/data/syllabus.dart';
import '../../data/ai_generated_controller.dart';

Widget buildTopicInput(AIGeneratedController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('📘 Название курса:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 12),
      TextFormField(
        controller: controller.topicController,
        decoration: InputDecoration(
          hintText: 'Например: Data Science',
          prefixIcon: const Icon(Icons.school),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ],
  );
}

Widget buildGenerateButton(AIGeneratedController controller, BuildContext context) {
  return ElevatedButton.icon(
    onPressed: controller.isLoading
        ? null
        : () {
      final topic = controller.topicController.text.trim();
      if (topic.isNotEmpty) {
        controller.generateSyllabus(() => (context as Element).markNeedsBuild());
      }
    },
    icon: const Icon(Icons.auto_awesome, color: Colors.white),
    label: const Text('Сгенерировать syllabus', style: TextStyle(color: Colors.white)),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF3F3F8F),
      padding: const EdgeInsets.all(20),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

Widget buildSyllabusCard(AIGeneratedController controller, BuildContext context) {
  if (controller.syllabusData == null) return const SizedBox();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: SelectableText(
          const JsonEncoder.withIndent('  ').convert(controller.syllabusData!),
          style: const TextStyle(fontFamily: 'Courier', fontSize: 13),
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: ElevatedButton.icon(
          onPressed: () {
            final newSyllabus = SyllabusAI(
              title: controller.syllabusData!['title'],
              description: controller.syllabusData!['description'],
              createdAt: DateTime.now(),
              status: 'draft',
              isAI: true,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Силабус сохранён ✅')),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pop(context, newSyllabus);
            });
          },
          icon: const Icon(Icons.save_alt),
          label: const Text('Сохранить силабус'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    ],
  );
}

Widget buildLoadingOverlay(AIGeneratedController controller) {
  return AnimatedOpacity(
    opacity: controller.isLoading ? 1 : 0,
    duration: const Duration(milliseconds: 400),
    child: IgnorePointer(
      ignoring: !controller.isLoading,
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(strokeWidth: 3),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                controller.currentPhrase,
                key: ValueKey(controller.currentPhrase),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}