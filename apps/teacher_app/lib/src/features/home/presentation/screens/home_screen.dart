import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../home/data/datasources/mock/home_mock_datasource.dart';
import '../../../home/data/datasources/mock/news_mock_datasource.dart';
import '../../../home/data/datasources/mock/notification_mock_datasource.dart';
import '../../data/datasources/home_datasource.dart';
import '../../data/datasources/news_datasource.dart';
import '../../data/datasources/notification_datasource.dart';
import '../../domain/entities/syllabus.dart';
import '../../domain/entities/news_item.dart';
import '../../domain/entities/notification_item.dart';

import '../widgets/instruction_card.dart';
import '../widgets/kpi_card.dart';
import '../widgets/news_card_big.dart';
import '../widgets/section_header_with_action.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    HomeDataSource? syllabusSource,
    NewsDataSource? newsSource,
    NotificationDataSource? notificationSource,
  }) : syllabusSource = syllabusSource ?? HomeMockDataSource(),
        newsSource = newsSource ?? NewsMockDataSource(),
        notificationSource = notificationSource ?? NotificationMockDataSource();

  final HomeDataSource syllabusSource;
  final NewsDataSource newsSource;
  final NotificationDataSource notificationSource;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color primaryColor = Color(0xFF3F3F8F);

  bool _loading = true;
  int total = 0, pending = 0, approved = 0, rejected = 0;
  late List<Instruction> _instructions;
  late List<NewsItem> _newsItems;
  late List<NotificationItem> _notifications; // 🔥 [NEW]

  @override
  void initState() {
    super.initState();
    _instructions = getInstructions();
    _notifications = []; // 🔥 [NEW]
    _loadData();
  }

  Future<void> _loadData() async {
    final counts = await Future.wait([
      widget.syllabusSource.fetchAllCount(),
      widget.syllabusSource.fetchCountByStatus(SyllabusStatus.pending),
      widget.syllabusSource.fetchCountByStatus(SyllabusStatus.approved),
      widget.syllabusSource.fetchCountByStatus(SyllabusStatus.rejected),
    ]);

    final news = await widget.newsSource.fetchLatest(limit: 2);
    final notifs = await widget.notificationSource.fetchUnread(limit: 10); // 🔥 [NEW]

    setState(() {
      total = counts[0];
      pending = counts[1];
      approved = counts[2];
      rejected = counts[3];
      _newsItems = news;
      _notifications = notifs; // 🔥 [NEW]
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final dateFmt = DateFormat('d.MM.yy', 'ru');
    const designWidth = 1200.0;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: designWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Добро пожаловать, Нурислам',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black54),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('KAZ'),
                        ),
                        const SizedBox(width: 12),
                        const CircleAvatar(
                          backgroundColor: primaryColor,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // KPI-карточки
                    Row(
                      children: [
                        Expanded(
                          child: KpiCard(
                            label: 'Все',
                            count: total,
                            color: primaryColor,
                            illustrationAsset: 'assets/svg/all_docs.svg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: KpiCard(
                            label: 'Ожидание',
                            count: pending,
                            color: Colors.orange,
                            illustrationAsset: 'assets/svg/wait_docs.svg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: KpiCard(
                            label: 'Отказ',
                            count: rejected,
                            color: Colors.red,
                            illustrationAsset: 'assets/svg/cancel_docs.svg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: KpiCard(
                            label: 'Принято',
                            count: approved,
                            color: Colors.green,
                            illustrationAsset: 'assets/svg/done_docs.svg',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Инструкция + Новости
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Инструкция
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeaderWithAction(
                                title: 'Инструкция',
                                onViewAll: () {},
                              ),
                              const SizedBox(height: 16),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _instructions.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.7,
                                ),
                                itemBuilder: (ctx, idx) => InstructionCard(ins: _instructions[idx]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 32),

                        // Новости
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionHeaderWithAction(
                                title: 'Новости Университета',
                                onViewAll: () {},
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 230,
                                child: Row(
                                  children: [
                                    Expanded(child: NewsCardBig(item: _newsItems[0], dateFmt: dateFmt)),
                                    const SizedBox(width: 16),
                                    Expanded(child: NewsCardBig(item: _newsItems[1], dateFmt: dateFmt)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      // ✅ [UPDATED] FloatingActionButton с диалогом уведомлений
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(maxHeight: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Уведомления',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Expanded(
                      child: _notifications.isEmpty
                          ? const Center(child: Text('Нет новых уведомлений'))
                          : ListView.separated(
                        itemCount: _notifications.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final notif = _notifications[index];
                          return ListTile(
                            leading: const Icon(Icons.notifications, color: Colors.blue),
                            title: Text(notif.title),
                            subtitle: Text(notif.message),
                            trailing: Text(
                              DateFormat('HH:mm').format(notif.createdAt),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Закрыть'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.notifications),
      ),
    );
  }
}