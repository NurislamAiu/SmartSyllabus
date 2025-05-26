import 'package:flutter/material.dart';

import '../../data/ai_generated_controller.dart';
import '../widgets/ai_generated_widgets.dart';

class AIGeneratedSyllabusScreen extends StatefulWidget {
  const AIGeneratedSyllabusScreen({super.key});

  @override
  State<AIGeneratedSyllabusScreen> createState() => _AIGeneratedSyllabusScreenState();
}

class _AIGeneratedSyllabusScreenState extends State<AIGeneratedSyllabusScreen> {
  final controller = AIGeneratedController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3F3F8F);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        title: const Text('AI Генерация Силабуса'),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                buildTopicInput(controller),
                const SizedBox(height: 20),
                buildGenerateButton(controller, context),
                buildSyllabusCard(controller, context),
              ],
            ),
          ),
          buildLoadingOverlay(controller),
        ],
      ),
    );
  }
}