import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:teacher_app/src/features/syllabus/presentation/screens/home_screen.dart';
import 'package:teacher_app/src/features/syllabus/presentation/screens/syllabus_screen.dart';
import 'package:teacher_app/src/features/exam/presentation/screens/exam_screen.dart';
import 'package:teacher_app/src/features/profile/presentation/screens/profile_screen.dart';

import '../../features/evaluation/presentation/screens/evaluation_screen.dart';
import '../../features/literature/presentation/screens/literature_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return TeacherScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/syllabus',
          name: 'syllabus',
          builder: (context, state) => const SyllabusScreen(),
        ),
        GoRoute(
          path: '/exam',
          name: 'exam',
          builder: (context, state) => const ExamScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/literature',
          builder: (context, state) => const LiteratureScreen(),
        ),

        GoRoute(
          path: '/evaluation',
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