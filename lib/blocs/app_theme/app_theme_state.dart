import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppThemeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppThemeInitial extends AppThemeState {}

class AppThemeLocal extends AppThemeState {
  final ThemeMode themeMode;
  AppThemeLocal({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}

class ToggleAppThemeSuccess extends AppThemeState {
  final ThemeMode themeMode;
  ToggleAppThemeSuccess({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}
