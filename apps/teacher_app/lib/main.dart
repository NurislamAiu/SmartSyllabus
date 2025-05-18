import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teacher_app/src/app/app.dart';
import 'package:teacher_app/src/core/theme/providers/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const TeacherApp(),
    ),
  );
}