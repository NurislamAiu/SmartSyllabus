import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/evaluation/presentation/screens/evaluation_screen.dart';
import '../../features/exam/presentation/screens/exam_screen.dart';
import '../../features/literature/presentation/screens/literature_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/staff/presentation/screens/staff_screen.dart';
import '../../features/syllabus/presentation/screens/syllabus_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AdminScaffold(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
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
          path: '/staff',
          name: 'staff',
          builder: (context, state) => const StaffScreen(),
        ),
        GoRoute(
          path: '/reports',
          name: 'reports',
          builder: (context, state) => const ReportsScreen(),
        ),
        GoRoute(
          path: '/literature',
          name: 'literature',
          builder: (context, state) => const LiteratureScreen(),
        ),
        GoRoute(
          path: '/evaluation',
          name: 'evaluation',
          builder: (context, state) => const EvaluationScreen(),
        ),
      ],
    ),
  ],
);



class AdminScaffold extends StatelessWidget {
  final Widget child;
  const AdminScaffold({super.key, required this.child});

  static final _tabs = [
    ('Главная', Icons.dashboard, '/dashboard'),
    ('Силабусы', Icons.menu_book, '/syllabus'),
    ('Экзамены', Icons.assignment, '/exam'),
    ('Профиль', Icons.person, '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    int currentIndex = _tabs.indexWhere((tab) => location.startsWith(tab.$3));
    if (currentIndex == -1) currentIndex = 0;

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => context.go(_tabs[index].$3),
        items: _tabs
            .map((tab) => BottomNavigationBarItem(
          icon: Icon(tab.$2),
          label: tab.$1,
        ))
            .toList(),
      ),
    );
  }
}
