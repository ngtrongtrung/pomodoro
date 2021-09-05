import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/blocs/app_theme/bloc_app_theme.dart';
import 'package:pomodoro/screens/home_screen/home_screen.dart';
import 'package:pomodoro/theme/app_theme.dart';
import 'package:pomodoro/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: languageCode,
      path: 'assets/langs',
    ),
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
    return MultiBlocProvider(
        providers: [
          BlocProvider<AppThemeBloc>(
            create: (context) => AppThemeBloc()..add(GetAppThemeFromStorage()),
          )
        ],
        child: BlocBuilder<AppThemeBloc, AppThemeState>(
          builder: (context, state) {
            if (state is AppThemeInitial) return Container();
            ThemeMode themeMode = state.props[0] as ThemeMode;
            return MaterialApp(
              title: 'Pomodoro',
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              darkTheme: AppThemes.darkTheme,
              theme: AppThemes.lightTheme,
              home: HomeScreen(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            );
          },
        ));
  }
}
