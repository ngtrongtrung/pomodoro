import 'package:flutter/material.dart';

import 'package:pomodoro/theme/app_color.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme() {
    themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class AppThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: DEAF_COVE,
    colorScheme: ColorScheme.dark(),
    brightness: Brightness.dark,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    brightness: Brightness.light,
  );
}
