import 'package:flutter/material.dart';

class SyllabusFormHelpers {
  static Widget buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboard,
      ),
    );
  }

  static Widget buildMultilineField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  static Widget buildDropdownField(
      String label,
      String? value,
      List<String> options,
      ValueChanged<String?> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items:
        options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  static Widget buildChipList(
      List<String> list,
      Color color,
      VoidCallback onUpdate,
      ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: list
          .map(
            (e) => Chip(
          label: Text(
            e,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
          backgroundColor: color.withOpacity(0.1),
          labelStyle: TextStyle(color: color),
          onDeleted: () {
            list.remove(e);
            onUpdate();
          },
        ),
      )
          .toList(),
    );
  }

  static Widget buildAddButton(String label, List<String> list,
      BuildContext context, VoidCallback onUpdate) {
    return TextButton.icon(
      onPressed: () {
        final controller = TextEditingController();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(label),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Введите текст'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    list.add(controller.text.trim());
                    onUpdate();
                  }
                  Navigator.pop(context);
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.add),
      label: Text(label),
    );
  }

  static Widget buildSectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        text,
        style:
        Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
