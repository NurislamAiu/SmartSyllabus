import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/router/router.dart';
import '../core/theme/providers/theme_provider.dart';
import '../core/theme/theme.dart';

class TeacherApp extends StatelessWidget {
  const TeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return MaterialApp.router(
      title: 'SmartSyllabus Teacher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      routerConfig: appRouter,
    );
  }
}