import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'src/app/app.dart';
import 'src/core/theme/providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    setWindowTitle('SmartSyllabus');
    setWindowMinSize(const Size(800, 600));
    // setWindowMaxSize(const Size(1920, 1080));
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const TeacherApp(),
    ),
  );
}