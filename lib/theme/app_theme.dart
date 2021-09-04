import 'package:flutter/material.dart';

import 'package:pomodoro/theme/app_color.dart';

class AppThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: DEAF_COVE,
    colorScheme: ColorScheme.dark(),
    brightness: Brightness.dark,
    canvasColor: NAVY,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    brightness: Brightness.light,
    canvasColor: JAVA,
  );
}
