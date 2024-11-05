
import 'package:hive_flutter/hive_flutter.dart';

class ThemeService {
  static const String _boxName = 'theme_box';
  static const String _isDarkModeKey = 'is_dark_mode';

  static Future<void> init() async {
    await Hive.openBox(_boxName);
  }

  static bool isDarkMode() {
    final box = Hive.box(_boxName);
    return box.get(_isDarkModeKey, defaultValue: false);
  }

  static Future<void> toggleTheme() async {
    final box = Hive.box(_boxName);
    final isDark = isDarkMode();
    await box.put(_isDarkModeKey, !isDark);
  }
}