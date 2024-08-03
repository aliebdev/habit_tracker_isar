import 'package:flutter/material.dart';
import 'package:habit_tracker_isar/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = AppTheme.light;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == AppTheme.dark;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDarkMode) {
      themeData = AppTheme.light;
    } else {
      themeData = AppTheme.dark;
    }
  }
}
