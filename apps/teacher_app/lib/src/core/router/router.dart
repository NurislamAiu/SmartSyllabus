import 'package:go_router/go_router.dart';
import 'package:teacher_app/src/features/syllabus/presentation/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);