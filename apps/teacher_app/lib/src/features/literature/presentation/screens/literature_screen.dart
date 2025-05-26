import 'package:flutter/material.dart';

class LiteratureScreen extends StatelessWidget {
  const LiteratureScreen({super.key});

  static const Color primaryColor = Color(0xFF3F3F8F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Учебная литература',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO: обработка добавления книги
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F3F8F), Color(0xFF5A5AD6)],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Добавить книгу',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Список литературы',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: 2,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final books = [
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
                  ];
                  return books[index];
                },
              ),
            ),
          ],
        ),
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor: required ? Colors.redAccent.withOpacity(0.15) : Colors.grey.withOpacity(0.15),
          child: Icon(
            required ? Icons.book : Icons.menu_book_outlined,
            color: required ? Colors.redAccent : Colors.grey,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(author),
        trailing: Text(
          required ? 'Обязательная' : 'Дополнительная',
          style: TextStyle(
            color: required ? Colors.redAccent : Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}