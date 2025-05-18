import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_app/src/core/router/route_names.dart';
import 'package:teacher_app/src/core/router/route_paths.dart';

import '../../features/evaluation/presentation/screens/evaluation_screen.dart';
import '../../features/exam/presentation/screens/exam_screen.dart';
import '../../features/literature/presentation/screens/literature_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/syllabus/presentation/screens/home_screen.dart';
import '../../features/syllabus/presentation/screens/syllabus_screen.dart';

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
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutePaths.syllabus,
          name: RouteNames.syllabus,
          builder: (context, state) => const SyllabusScreen(),
        ),
        GoRoute(
          path: RoutePaths.exam,
          name: RouteNames.exam,
          builder: (context, state) => const ExamScreen(),
        ),
        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: RoutePaths.literature,
          name: RouteNames.literature,
          builder: (context, state) => const LiteratureScreen(),
        ),
        GoRoute(
          path: RoutePaths.evaluation,
          name: RouteNames.evaluation,
          builder: (context, state) => const EvaluationScreen(),
        ),
      ],
    ),
  ],
);



class TeacherScaffold extends StatelessWidget {
  final Widget child;
  const TeacherScaffold({super.key, required this.child});

  static final _tabs = [
    ('Главная', Icons.home, '/home'),
    ('Силабус', Icons.menu_book, '/syllabus'),
    ('Экзамен', Icons.assignment, '/exam'),
    ('Профиль', Icons.person, '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex = _tabs.indexWhere((tab) => location.startsWith(tab.$3));
    if (currentIndex == -1) currentIndex = 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          context.go(_tabs[index].$3);
        },
        destinations: _tabs
            .map(
              (tab) => NavigationDestination(
            icon: Icon(tab.$2),
            label: tab.$1,
          ),
        )
            .toList(),
      ),
    );
  }
}