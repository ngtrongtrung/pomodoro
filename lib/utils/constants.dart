import 'package:flutter/material.dart';
import 'package:pomodoro/models/pomodoro_status.dart';

const int POMODORO_TOTAL_TIME = 10;
const int SHORT_BREAK_TIME = 3;
const int LONG_BREAK_TIME = 5;
const int POMODORO_PER_SET = 4;

const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.RUNNING: 'Pomodoro is running, time to be focused',
  PomodoroStatus.PAUSED: 'Ready for a forcused pomodoro?',
  PomodoroStatus.RUNNING_SHORT_BREAK: 'Short break running, time to relax',
  PomodoroStatus.PAUSED_SHORT_BREAK: 'Let\'s have a short break',
  PomodoroStatus.RUNNING_LONG_BREAK: 'Long break running, time to relax',
  PomodoroStatus.PAUSED_LONG_BREAK: 'Let\s have a long break',
  PomodoroStatus.FINISHED: 'Congrats, you deserve a long break, ready to start?'
};

const Map<PomodoroStatus, MaterialColor> statusColor = {
  PomodoroStatus.RUNNING: Colors.green,
  PomodoroStatus.PAUSED: Colors.orange,
  PomodoroStatus.RUNNING_SHORT_BREAK: Colors.red,
  PomodoroStatus.PAUSED_SHORT_BREAK: Colors.orange,
  PomodoroStatus.RUNNING_LONG_BREAK: Colors.red,
  PomodoroStatus.PAUSED_LONG_BREAK: Colors.orange,
  PomodoroStatus.FINISHED: Colors.orange,
};
