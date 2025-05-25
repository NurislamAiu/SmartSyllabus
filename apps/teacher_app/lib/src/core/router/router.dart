import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_app/src/features/syllabus/presentation/screens/create_syllabus_screen.dart';

import '../../features/syllabus/presentation/screens/ai_generated_syllabus_screen.dart';
import 'route_names.dart';
import 'route_paths.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/syllabus/presentation/screens/syllabus_screen.dart';
import '../../features/exam/presentation/screens/exam_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/literature/presentation/screens/literature_screen.dart';
import '../../features/evaluation/presentation/screens/evaluation_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return TeacherScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          pageBuilder:
              (context, state) =>
                  NoTransitionPage(key: state.pageKey, child: HomeScreen()),
        ),
        GoRoute(
          path: RoutePaths.syllabus,
          name: RouteNames.syllabus,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const SyllabusScreen(),
              ),
        ),
        GoRoute(
          path: RoutePaths.exam,
          name: RouteNames.exam,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ExamScreen(),
              ),
        ),
        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
              ),
        ),
        GoRoute(
          path: RoutePaths.literature,
          name: RouteNames.literature,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const LiteratureScreen(),
              ),
        ),
        GoRoute(
          path: RoutePaths.evaluation,
          name: RouteNames.evaluation,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const EvaluationScreen(),
              ),
        ),
        GoRoute(
          path: RoutePaths.createSyllabus,
          name: RouteNames.createSyllabus,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const CreateSyllabusScreen(),
              ),
        ),
        GoRoute(
          path: RoutePaths.aiCreateSyllabus,
          name: RouteNames.aiCreateSyllabus,
          pageBuilder:
              (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const AIGeneratedSyllabusScreen(),
              ),
        ),
      ],
    ),
  ],
);

class TeacherScaffold extends StatelessWidget {
  final Widget child;

  const TeacherScaffold({Key? key, required this.child}) : super(key: key);

  static const _tabs = <Map<String, Object>>[
    {'label': 'Главная', 'icon': Icons.home, 'path': RoutePaths.home},
    {
      'label': 'Силлабусы',
      'icon': Icons.menu_book,
      'path': RoutePaths.syllabus,
    },
    {'label': 'Экзамен', 'icon': Icons.assignment, 'path': RoutePaths.exam},
    {'label': 'Профиль', 'icon': Icons.person, 'path': RoutePaths.profile},
    {
      'label': 'Литература',
      'icon': Icons.library_books,
      'path': RoutePaths.literature,
    },
    {
      'label': 'Оценка',
      'icon': Icons.rate_review,
      'path': RoutePaths.evaluation,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    var currentIndex = _tabs.indexWhere(
      (t) => location.startsWith(t['path'] as String),
    );
    if (currentIndex == -1) currentIndex = 0;

    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            tabs: _tabs,
            selectedIndex: currentIndex,
            onItemSelected: (i) => context.go(_tabs[i]['path'] as String),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class SideMenu extends StatefulWidget {
  final List<Map<String, Object>> tabs;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const SideMenu({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3F3F8F);

    return Container(
      width: 240,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, Color(0xFF30307B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.school, color: primaryColor, size: 36),
            ),
            const SizedBox(height: 12),
            const Text(
              'SmartSyllabus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            for (var i = 0; i < widget.tabs.length; i++)
              _NavItem(
                icon: widget.tabs[i]['icon'] as IconData,
                label: widget.tabs[i]['label'] as String,
                selected: i == widget.selectedIndex,
                onTap: () => widget.onItemSelected(i),
              ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bg =
        widget.selected
            ? Colors.white24
            : _hover
            ? Colors.white10
            : Colors.transparent;
    final color = widget.selected || _hover ? Colors.white : Colors.white70;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: color),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: TextStyle(
                  color: color,
                  fontWeight:
                      widget.selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
