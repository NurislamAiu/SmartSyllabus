import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/instruction_card.dart';

class InstructionDetailScreen extends StatelessWidget {
  final Instruction instruction;

  const InstructionDetailScreen({super.key, required this.instruction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(instruction.title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(instruction.asset, height: 200),
            const SizedBox(height: 24),
            Text(
              instruction.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              '📌 Здесь будет подробная инструкция по выбранной теме. '
                  'Вы можете заменить этот текст на реальное содержание.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}