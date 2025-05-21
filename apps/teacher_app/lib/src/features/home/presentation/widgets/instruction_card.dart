import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Instruction {
  final String title;
  final String asset;

  Instruction(this.title, this.asset);
}

List<Instruction> getInstructions() => [
  Instruction('Как отправить Силлабус на проверку?', 'assets/svg/instr1.svg'),
  Instruction('Как пользоваться AI-помощником?', 'assets/svg/instr2.svg'),
  Instruction('Преимущества SmartSyllabus', 'assets/svg/instr1.svg'),
  Instruction('Экспорт в PDF', 'assets/svg/instr2.svg'),
  Instruction('Настройки профиля', 'assets/svg/instr1.svg'),
  Instruction('Управление экзаменами', 'assets/svg/instr2.svg'),
];

class InstructionCard extends StatelessWidget {
  final Instruction ins;

  const InstructionCard({super.key, required this.ins});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              ins.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: SvgPicture.asset(ins.asset, height: 90, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
