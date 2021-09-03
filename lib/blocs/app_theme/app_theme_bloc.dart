import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_event.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  ThemeMode _themeMode = ThemeMode.light;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  static final String _darkMode = 'darkMode';

  AppThemeBloc() : super(AppThemeInitial());

  @override
  Stream<AppThemeState> mapEventToState(AppThemeEvent event) async* {
    if (event is ToggleAppTheme) {
      yield* _toogleTheme(event);
    }
    if (event is GetAppThemeFromStorage) {
      yield* _getAppThemeFromStorage(event);
    }
  }

  Stream<AppThemeState> _toogleTheme(ToggleAppTheme event) async* {
    this._themeMode = this.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    yield ToggleAppThemeSuccess(themeMode: this._themeMode);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setInt(_darkMode, this._themeMode.index);
  }

  Stream<AppThemeState> _getAppThemeFromStorage(
      GetAppThemeFromStorage event) async* {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final int localDarkMode =
        localStorage.getInt(_darkMode) ?? ThemeMode.light.index;
    this._themeMode = ThemeMode.values[localDarkMode];
    yield AppThemeLocal(themeMode: this._themeMode);
  }
}
