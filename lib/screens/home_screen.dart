import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_event.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_state.dart';
import 'package:provider/provider.dart';

import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:pomodoro/theme/app_theme.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:pomodoro/widgets/action_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const _buttonTextStart = 'START';
const _buttonTextResumePomodoro = "RESUME";
const _buttonTextResumeBreak = "RESUME BREAK";
const _buttonTextStartShortBreak = "BREAK";
const _buttonTextPause = "PAUSE";
const _buttonTextReset = "RESET";

class _HomeScreenState extends State<HomeScreen> {
  int _remainingTime = POMODORO_TOTAL_TIME;
  String _mainButtonText = _buttonTextStart;
  PomodoroStatus pomodoroStatus = PomodoroStatus.PAUSED;
  Timer? _timer;
  late final appThemeBloc;
  @override
  void initState() {
    super.initState();
    appThemeBloc = BlocProvider.of<AppThemeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            appThemeBloc.add(ToggleAppTheme());
                          },
                          icon: Icon(appThemeBloc.isDarkMode
                              ? Icons.dark_mode
                              : Icons.dark_mode_outlined),
                          padding: EdgeInsets.all(4),
                          iconSize: 26.0,
                        )
                      ],
                    ),
                    Text(
                      'Pomodoro Technique',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 220.0,
                      lineWidth: 15.0,
                      percent: _getPomodoroPercentage(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        _secondsToFormatedString(_remainingTime),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: statusColor[pomodoroStatus],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                          label: _buttonTextReset,
                          onTap: _resetButtonPressed,
                        ),
                        ActionButton(
                          label: "$_mainButtonText",
                          onTap: _mainButtonPressed,
                          isFilled: true,
                        ),
                      ],
                    ),
                    Text(
                      '${statusDescription[this.pomodoroStatus]}',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  String _secondsToFormatedString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - roundedMinutes * 60;
    return '$roundedMinutes:' +
        (remainingSeconds < 10 ? '0' : '') +
        remainingSeconds.toString();
  }

  _mainButtonPressed() {
    debugPrint('_mainButtonPressed');
    switch (pomodoroStatus) {
      case PomodoroStatus.PAUSED:
        _startPomodoroCountdown();
        break;
      case PomodoroStatus.RUNNING:
        _pausePomodoroCountdown();
        break;
      case PomodoroStatus.PAUSED_SHORT_BREAK:
        _startShortBreak();
        break;
      case PomodoroStatus.RUNNING_SHORT_BREAK:
        _pauseShortBreakCountdown();
        break;
    }
  }

  double _getPomodoroPercentage() {
    int totalTime;
    switch (pomodoroStatus) {
      case PomodoroStatus.RUNNING:
        totalTime = POMODORO_TOTAL_TIME;
        break;
      case PomodoroStatus.PAUSED:
        totalTime = POMODORO_TOTAL_TIME;
        break;
      case PomodoroStatus.RUNNING_SHORT_BREAK:
        totalTime = SHORT_BREAK_TIME;
        break;
      case PomodoroStatus.PAUSED_SHORT_BREAK:
        totalTime = SHORT_BREAK_TIME;
        break;
    }

    return (totalTime - _remainingTime) / totalTime;
  }

  void _startPomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.RUNNING;
    this._cancelTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          _mainButtonText = _buttonTextPause;
        });
      } else {
        _playSound();
        _cancelTimer();
        pomodoroStatus = PomodoroStatus.PAUSED_SHORT_BREAK;
        setState(() {
          _remainingTime = SHORT_BREAK_TIME;
          _mainButtonText = _buttonTextStartShortBreak;
        });
      }
    });
  }

  void _cancelTimer() {
    if (this._timer != null) {
      this._timer!.cancel();
    }
  }

  void _pausePomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.PAUSED;
    _cancelTimer();
    setState(() {
      _mainButtonText = _buttonTextResumePomodoro;
    });
  }

  _resetButtonPressed() {
    _cancelTimer();
    _stopCountdown();
  }

  void _stopCountdown() {
    pomodoroStatus = PomodoroStatus.PAUSED;
    setState(() {
      _mainButtonText = _buttonTextStart;
      _remainingTime = POMODORO_TOTAL_TIME;
    });
  }

  void _pauseShortBreakCountdown() {
    pomodoroStatus = PomodoroStatus.PAUSED_SHORT_BREAK;
    _pauseBreakCountdown();
  }

  void _pauseBreakCountdown() {
    _cancelTimer();
    setState(() {
      _mainButtonText = _buttonTextResumeBreak;
    });
  }

  void _startShortBreak() {
    pomodoroStatus = PomodoroStatus.RUNNING_SHORT_BREAK;
    setState(() {
      _mainButtonText = _buttonTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _playSound();
        _cancelTimer();
        _remainingTime = POMODORO_TOTAL_TIME;
        pomodoroStatus = PomodoroStatus.PAUSED;
        setState(() {
          _mainButtonText = _buttonTextStart;
        });
      }
    });
  }

  void _playSound() {
    debugPrint('playSound');
  }
}
