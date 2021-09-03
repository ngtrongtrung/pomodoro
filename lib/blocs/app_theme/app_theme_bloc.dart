import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_event.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  ThemeMode _themeMode = ThemeMode.light;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  AppThemeBloc() : super(AppThemeInitial(themeMode: ThemeMode.light));

  @override
  Stream<AppThemeState> mapEventToState(AppThemeEvent event) async* {
    if (event is ToggleAppTheme) {
      yield* _toogleTheme(event);
    }
  }

  Stream<AppThemeState> _toogleTheme(ToggleAppTheme event) async* {
    this._themeMode = this.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    yield ToggleAppThemeSuccess(themeMode: this._themeMode);
  }
}
