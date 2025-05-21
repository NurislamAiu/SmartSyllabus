import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// Ваши моковые источники и сущности:
import '../../../home/data/datasources/mock/home_mock_datasource.dart';
import '../../../home/data/datasources/mock/task_mock_datasource.dart';
import '../../../home/data/datasources/mock/news_mock_datasource.dart';
import '../../../home/data/datasources/mock/notification_mock_datasource.dart';
import '../../data/datasources/home_datasource.dart';
import '../../data/datasources/task_datasource.dart';
import '../../data/datasources/news_datasource.dart';
import '../../data/datasources/notification_datasource.dart';
import '../../domain/entities/syllabus.dart';
import '../../domain/entities/news_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    HomeDataSource? syllabusSource,
    TaskDataSource? taskSource,
    NewsDataSource? newsSource,
    NotificationDataSource? notificationSource,
  })  : syllabusSource = syllabusSource ?? HomeMockDataSource(),
        taskSource = taskSource ?? TaskMockDataSource(),
        newsSource = newsSource ?? NewsMockDataSource(),
        notificationSource = notificationSource ?? NotificationMockDataSource(),
        super(key: key);

  final HomeDataSource syllabusSource;
  final TaskDataSource taskSource;
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

  @override
  void initState() {
    super.initState();
    _instructions = [
      Instruction('Как отправить Силлабус на проверку?', 'assets/svg/instr1.svg'),
      Instruction('Как пользоваться AI-помощником?',   'assets/svg/instr2.svg'),
      Instruction('Преимущества SmartSyllabus',       'assets/svg/instr1.svg'),
      Instruction('Экспорт в PDF',                    'assets/svg/instr2.svg'),
      Instruction('Настройки профиля',                'assets/svg/instr1.svg'),
      Instruction('Управление экзаменами',            'assets/svg/instr2.svg'),
    ];
    _loadData();
  }

  Future<void> _loadData() async {
    total    = await widget.syllabusSource.fetchAllCount();
    pending  = await widget.syllabusSource.fetchCountByStatus(SyllabusStatus.pending);
    approved = await widget.syllabusSource.fetchCountByStatus(SyllabusStatus.approved);
    rejected = await widget.syllabusSource.fetchCountByStatus(SyllabusStatus.rejected);
    _newsItems = await widget.newsSource.fetchLatest(limit: 2);
    setState(() => _loading = false);
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
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
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
                          child: _KpiCard(
                            label: 'Все',
                            count: total,
                            color: primaryColor,
                            illustrationAsset: 'assets/svg/all_docs.svg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _KpiCard(
                            label: 'Ожидание',
                            count: pending,
                            color: Colors.orange,
                            illustrationAsset: 'assets/svg/wait_docs.svg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _KpiCard(
                            label: 'Отказ',
                            count: rejected,
                            color: Colors.red,
                            illustrationAsset: 'assets/svg/cancel_docs.svg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _KpiCard(
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
                        // Инструкция (2/3)
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionHeaderWithAction(
                                  title: 'Инструкция', onViewAll: () {}),
                              const SizedBox(height: 16),
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _instructions.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1.7,
                                ),
                                itemBuilder: (ctx, idx) =>
                                    _InstructionCard(ins: _instructions[idx]),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 32),

                        // Новости (1/3)
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _SectionHeaderWithAction(
                                  title: 'Новости Университета',
                                  onViewAll: () {}),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 230,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: _NewsCardBig(
                                            item: _newsItems[0],
                                            dateFmt: dateFmt)),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: _NewsCardBig(
                                            item: _newsItems[1],
                                            dateFmt: dateFmt)),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {},
        child: const Icon(Icons.notifications),
      ),
    );
  }
}

/// KPI-карточка
class _KpiCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final String illustrationAsset;

  const _KpiCard({
    Key? key,
    required this.label,
    required this.count,
    required this.color,
    required this.illustrationAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: const Color(0x1AD9D9D9),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: color)),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          elevation: 0,
                        ),
                        child: const Text('Перейти'),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Positioned(
              left: 80,
              top: 60,
              child: Text('$count',
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(illustrationAsset,
                  height: 90, fit: BoxFit.contain),
            ),
          ]),
        ),
      ),
    );
  }
}

/// Заголовок секции
class _SectionHeaderWithAction extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeaderWithAction(
      {Key? key, required this.title, required this.onViewAll})
      : super(key: key);

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

/// Модель инструкции
class Instruction {
  final String title;
  final String asset;
  Instruction(this.title, this.asset);
}

/// Карточка инструкции
class _InstructionCard extends StatelessWidget {
  final Instruction ins;
  const _InstructionCard({Key? key, required this.ins}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black12),
          borderRadius: BorderRadius.circular(8)),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(ins.title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: SvgPicture.asset(ins.asset, height: 90, fit: BoxFit.contain),
        ),
      ]),
    );
  }
}

/// Большая карточка новости
class _NewsCardBig extends StatelessWidget {
  final NewsItem item;
  final DateFormat dateFmt;

  const _NewsCardBig({Key? key, required this.item, required this.dateFmt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(item.imageUrl, fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.4)),
          Positioned(
            top: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Новости Года',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(color: Colors.black45, blurRadius: 4)
                        ])),
                const SizedBox(height: 4),
                Text(dateFmt.format(item.publishedAt),
                    style: TextStyle(
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black45, blurRadius: 4)])),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(item.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(color: Colors.black45, blurRadius: 4)
                    ]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
        ]),
      ),
    );
  }
}