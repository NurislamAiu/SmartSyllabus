import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/router/router.dart';
import '../core/theme/theme.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SmartSyllabus Admin',
      theme: AppTheme.light, // Подключается светлая тема
      routerConfig: router,   // Подключение GoRouter
    );
  }
}