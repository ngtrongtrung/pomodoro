import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_state.dart';
import 'package:pomodoro/screens/home_screen/home_screen.dart';
import 'package:pomodoro/theme/app_theme.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppThemeBloc>(
      create: (context) => AppThemeBloc(),
      child: BlocBuilder<AppThemeBloc, AppThemeState>(
        builder: (context, state) {
          ThemeMode themeMode = state.props[0] as ThemeMode;
          return MaterialApp(
            title: 'Pomodoro',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            darkTheme: AppThemes.darkTheme,
            theme: AppThemes.lightTheme,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
