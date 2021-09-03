import 'package:equatable/equatable.dart';

class AppThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAppThemeFromStorage extends AppThemeEvent {}

class ToggleAppTheme extends AppThemeEvent {}
