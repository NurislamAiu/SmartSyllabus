import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _themeKey = 'isDarkMode';

  static Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }

  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false;
  }
}