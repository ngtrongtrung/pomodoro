import 'package:flutter/material.dart';

import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:pomodoro/theme/app_color.dart';

const int POMODORO_TOTAL_TIME = 20;
const int SHORT_BREAK_TIME = 10;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.RUNNING: 'status_description_running',
  PomodoroStatus.PAUSED: 'status_description_pause',
  PomodoroStatus.RUNNING_SHORT_BREAK: 'status_description_running_short_break',
  PomodoroStatus.PAUSED_SHORT_BREAK: 'status_description_pause_short_break',
};

const Map<PomodoroStatus, Color> statusColor = {
  PomodoroStatus.RUNNING: JAVA,
  PomodoroStatus.PAUSED: Colors.orange,
  PomodoroStatus.RUNNING_SHORT_BREAK: Colors.red,
  PomodoroStatus.PAUSED_SHORT_BREAK: Colors.orange,
};

const int MINIMUM_TABLET_WIDTH = 650;
const int MINIMUM_DESKTOP_WIDTH = 1100;
const List<Locale> languageCode = [
  Locale('en'),
  Locale('vi'),
];
