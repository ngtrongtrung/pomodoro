import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_bloc.dart';
import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:pomodoro/screens/home_screen/mobile/mobile_landscape_layout.dart';
import 'package:pomodoro/screens/home_screen/mobile/mobile_portrait_layout.dart';
import 'package:pomodoro/utils/constants.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  _MobileHomeScreenState createState() => _MobileHomeScreenState();
}

const _buttonTextStart = 'START';
const _buttonTextResumePomodoro = "RESUME";
const _buttonTextResumeBreak = "RESUME BREAK";
const _buttonTextStartShortBreak = "BREAK";
const _buttonTextPause = "PAUSE";
const _buttonTextReset = "RESET";

class _MobileHomeScreenState extends State<MobileHomeScreen> {
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

  Widget getLayoutWhenLandscape() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return MobileLandscapeLayout(
            pomodoroPercentage: this._getPomodoroPercentage(),
            timeRemain: _secondsToFormatedString(_remainingTime),
            statusColor: statusColor[pomodoroStatus] ?? Colors.transparent,
            resetButtonText: _buttonTextReset,
            mainButtonText: this._mainButtonText,
            mainButtonPressed: this._mainButtonPressed,
            resetButtonPressed: this._resetButtonPressed,
            description: '${statusDescription[this.pomodoroStatus]}',
          );
        } else {
          return MobilePortraitLayout(
            pomodoroPercentage: this._getPomodoroPercentage(),
            timeRemain: _secondsToFormatedString(_remainingTime),
            statusColor: statusColor[pomodoroStatus] ?? Colors.transparent,
            resetButtonText: _buttonTextReset,
            mainButtonText: this._mainButtonText,
            mainButtonPressed: this._mainButtonPressed,
            resetButtonPressed: this._resetButtonPressed,
            description: '${statusDescription[this.pomodoroStatus]}',
          );
        }
      },
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

  void _mainButtonPressed() {
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

  void _resetButtonPressed() {
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
