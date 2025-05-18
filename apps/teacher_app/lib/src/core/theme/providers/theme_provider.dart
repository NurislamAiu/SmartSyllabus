import 'package:flutter/material.dart';
import '../service/shared_prefs_helper.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    SharedPrefsHelper.setDarkMode(_isDarkMode);
    notifyListeners();
  }

  void _loadTheme() async {
    _isDarkMode = await SharedPrefsHelper.isDarkMode();
    notifyListeners();
  }
}