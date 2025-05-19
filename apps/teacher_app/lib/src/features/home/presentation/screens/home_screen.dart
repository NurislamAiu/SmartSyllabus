
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/kpi_card.dart';
import '../../../../core/widgets/news_card.dart';
import '../../../../core/widgets/section_header.dart';

import '../../../home/data/datasources/mock/home_mock_datasource.dart';
import '../../../home/data/datasources/mock/task_mock_datasource.dart';
import '../../../home/data/datasources/mock/news_mock_datasource.dart';
import '../../../home/data/datasources/mock/notification_mock_datasource.dart';
import '../../data/datasources/home_datasource.dart';
import '../../data/datasources/news_datasource.dart';
import '../../data/datasources/notification_datasource.dart';
import '../../data/datasources/task_datasource.dart';
import '../../domain/entities/syllabus.dart';

class HomeScreen extends StatefulWidget {

  final HomeDataSource syllabusSource;
  final TaskDataSource taskSource;
  final NewsDataSource newsSource;
  final NotificationDataSource notificationSource;

  HomeScreen({
    super.key,
    HomeDataSource? syllabusSource,
    TaskDataSource? taskSource,
    NewsDataSource? newsSource,
    NotificationDataSource? notificationSource,
  }) :
        syllabusSource = syllabusSource ?? HomeMockDataSource(),
        taskSource     = taskSource     ?? TaskMockDataSource(),
        newsSource     = newsSource     ?? NewsMockDataSource(),
        notificationSource = notificationSource ?? NotificationMockDataSource();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const primaryColor = Color(0xFF3F3F8F);
  bool _loading = true;

  List<Map<String, dynamic>> _kpiData = [];
  List<String> _urgentTasks = [];
  List<Map<String, String>> _news = [];
  List<String> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Load counts from syllabus source
    final total     = await widget.syllabusSource.fetchAllCount();
    final pending   = await widget.syllabusSource.fetchCountByStatus(SyllabusStatus.pending);
    final approved  = await widget.syllabusSource.fetchCountByStatus(SyllabusStatus.approved);
    final rejected  = await widget.syllabusSource.fetchCountByStatus(SyllabusStatus.rejected);

    // Load urgent tasks
    final tasks = await widget.taskSource.fetchUpcomingTasks(limit: 3);

    // Load news
    final newsItems = await widget.newsSource.fetchLatest(limit: 3);

    // Load notifications
    final notes = await widget.notificationSource.fetchUnread(limit: 3);

    String fmt(DateTime dt) => DateFormat('d MMMM yyyy', 'ru').format(dt);

    setState(() {
      _kpiData = [
        {'label':'Все',      'value': total,    'icon': Icons.list_alt,        'color': primaryColor},
        {'label':'Ожидание', 'value': pending,  'icon': Icons.hourglass_empty,'color': Colors.orange},
        {'label':'Принято',  'value': approved, 'icon': Icons.check_circle,   'color': Colors.green},
        {'label':'Отклонено','value': rejected, 'icon': Icons.cancel,         'color': Colors.redAccent},
      ];

      _urgentTasks = tasks.map((t) => '\${t.title} до \${fmt(t.dueDate)}').toList();

      _news = newsItems.map((n) => {
        'title': n.title,
        'date' : fmt(n.publishedAt),
        'image': n.imageUrl,
      }).toList();

      _notifications = notes.map((n) => n.message).toList();

      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with profile
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Добро пожаловать, Нурислам!',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // KPI
                    Row(
                      children: _kpiData.map((d) =>
                          Expanded(child: KpiCard(
                            icon: d['icon'] as IconData,
                            label: d['label'] as String,
                            value: d['value'] as int,
                            color: d['color'] as Color,
                          ))
                      ).toList(),
                    ),
                    const SizedBox(height: 32),

                    // Urgent tasks
                    const SectionHeader('🚨 Срочные задачи'),
                    const SizedBox(height: 12),
                    ..._urgentTasks.map((t) => Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.priority_high, color: Colors.redAccent),
                        title: Text(t, style: const TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    )),
                    const SizedBox(height: 32),

                    // News
                    const SectionHeader('📰 Новости университета'),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _news.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (_, i) {
                          final item = _news[i];
                          return NewsCard(
                            title: item['title']!,
                            date: item['date']!,
                            imageUrl: item['image']!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),
          FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              // show notifications...
            },
            child: const Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
