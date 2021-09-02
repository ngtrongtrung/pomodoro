import 'package:flutter/material.dart';

import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:pomodoro/theme/app_color.dart';

const int POMODORO_TOTAL_TIME = 20;
const int SHORT_BREAK_TIME = 10;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.RUNNING: 'Pomodoro is running, time to be focused',
  PomodoroStatus.PAUSED: 'Ready for a forcused pomodoro?',
  PomodoroStatus.RUNNING_SHORT_BREAK: 'Short break running, time to relax',
  PomodoroStatus.PAUSED_SHORT_BREAK: 'Let\'s have a short break',
};

const Map<PomodoroStatus, Color> statusColor = {
  PomodoroStatus.RUNNING: JAVA,
  PomodoroStatus.PAUSED: Colors.orange,
  PomodoroStatus.RUNNING_SHORT_BREAK: Colors.red,
  PomodoroStatus.PAUSED_SHORT_BREAK: Colors.orange,
};

const int MINIMUM_TABLET_WIDTH = 650;
const int MINIMUM_DESKTOP_WIDTH = 1100;
