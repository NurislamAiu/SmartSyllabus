import 'package:flutter/material.dart';

class SectionHeaderWithAction extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeaderWithAction(
      {super.key, required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(title,
          style:
          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      const Spacer(),
      GestureDetector(
        onTap: onViewAll,
        child: const Text('Посмотреть все',
            style: TextStyle(color: Colors.black54, fontSize: 12)),
      ),
    ]);
  }
}