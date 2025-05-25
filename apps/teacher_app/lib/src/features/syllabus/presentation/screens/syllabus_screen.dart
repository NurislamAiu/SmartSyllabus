import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/router/route_paths.dart';
import '../../data/mock_syllabus_repository.dart';
import '../../data/syllabus.dart';
import '../widgets/create_option_card.dart';
import '../widgets/syllabus_card.dart';
import '../widgets/syllabus_pdf_parser.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({super.key});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Создать силабус',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              CreateOptionCard(
                icon: Icons.smart_toy,
                title: 'Сгенерировать с помощью AI',
                subtitle: 'Автоматически создать структуру силабуса',
                onTap: () async {
                  Navigator.of(context, rootNavigator: true).pop();
                  final result = await GoRouter.of(context).push(RoutePaths.aiCreateSyllabus) as SyllabusAI?;

                  if (result != null) {
                    setState(() => mockSyllabusList.insert(0, result));
                  }
                },
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ),
              ),
              const SizedBox(height: 12),
              CreateOptionCard(
                icon: Icons.edit,
                title: 'Создать вручную',
                subtitle: 'Ввести все поля самостоятельно',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  GoRouter.of(context).push(RoutePaths.createSyllabus);
                },
                gradient: const LinearGradient(
                  colors: [Color(0xFF43CEA2), Color(0xFF185A9D)],
                ),
              ),
              const SizedBox(height: 12),
              CreateOptionCard(
                icon: Icons.upload_file,
                title: 'Импортировать из файла',
                subtitle: 'Загрузить готовый силабус',
                onTap: () => _importSyllabusFromFile(context),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _importSyllabusFromFile(BuildContext context) async {
    final data = await parseSyllabusFromPdf();
    if (data != null) {
      GoRouter.of(context).pushNamed(
        RouteNames.createSyllabus,
        extra: data,
      );
    }
  }

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
                  'Syllabus',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F3F8F),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showCreateDialog(context),
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
                          'Создать силабус',
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
              'Мои силабусы',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: mockSyllabusList.isEmpty
                  ? const Center(child: Text('Нет созданных силабусов'))
                  : ListView.separated(
                itemCount: mockSyllabusList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => SyllabusCard(syllabus: mockSyllabusList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}