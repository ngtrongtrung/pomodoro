import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pomodoro/screens/home_screen/home_screen.dart';
import 'package:pomodoro/theme/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<AppThemeProvider>(context);
        return MaterialApp(
          title: 'Pomodoro',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          darkTheme: AppThemes.darkTheme,
          theme: AppThemes.lightTheme,
          home: HomeScreen(),
        );
      },
    );
  }
}
