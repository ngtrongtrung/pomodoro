import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/models/pomodoro_status.dart';
import 'package:pomodoro/utils/constants.dart';
import 'package:pomodoro/widgets/custom_button.dart';
import 'package:pomodoro/widgets/progress_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

const _buttonTextStart = 'START POMODORO';
const _buttonTextResumePomodoro = "RESUME POMODORO";
const _buttonTextResumeBreak = "RESUME BREAK";
const _buttonTextStartShortBreak = "TAKE SHORT BREAK";
const _buttonTextStartLongBreak = "TAKE LONG BREAK";
const _buttonTextStartNewSet = "START NEW SET";
const _buttonTextPause = "PAUSE";
const _buttonTextReset = "RESET";

class _HomeScreenState extends State<HomeScreen> {
  int remainingTime = POMODORO_TOTAL_TIME;
  String mainButtonText = _buttonTextStart;
  PomodoroStatus pomodoroStatus = PomodoroStatus.PAUSED;
  Timer? _timer;
  int _setNum = 0;

  // static AudioCache player = AudioCache();

  @override
  void initState() {
    super.initState();
    // player.load(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Pomodoro Technique',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Set: $_setNum',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 220.0,
                      lineWidth: 15.0,
                      percent: _getPomodoroPercentage(),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        _secondsToFormatedString(remainingTime),
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      progressColor: statusColor[pomodoroStatus],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProgressIcons(
                      total: POMODORO_PER_SET,
                      done: _setNum,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('${statusDescription[this.pomodoroStatus]}',
                        style: TextStyle(color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      label: "$mainButtonText",
                      onTap: _mainButtonPressed,
                    ),
                    CustomButton(
                      label: "$_buttonTextReset",
                      onTap: _resetButtonPressed,
                    ),
                  ],
                ),
              ),
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
    String remainingSecondsFormated = "";

    if (remainingSeconds < 10) {
      remainingSecondsFormated = '0';
    }

    remainingSecondsFormated += remainingSeconds.toString();
    return '$roundedMinutes:$remainingSecondsFormated';
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
      case PomodoroStatus.RUNNING_SHORT_BREAK:
        _pauseShortBreakCountdown();
        break;
      case PomodoroStatus.PAUSED_SHORT_BREAK:
        _startShortBreak();
        break;
      case PomodoroStatus.RUNNING_LONG_BREAK:
        _pauseLongBreakCountdown();
        break;
      case PomodoroStatus.PAUSED_LONG_BREAK:
        _startLongBreak();
        break;
      case PomodoroStatus.FINISHED:
        _startPomodoroCountdown();
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
      case PomodoroStatus.RUNNING_LONG_BREAK:
        totalTime = LONG_BREAK_TIME;
        break;
      case PomodoroStatus.PAUSED_LONG_BREAK:
        totalTime = LONG_BREAK_TIME;
        break;
      case PomodoroStatus.FINISHED:
        totalTime = POMODORO_TOTAL_TIME;
        break;
    }

    return (totalTime - remainingTime) / totalTime;
  }

  void _startPomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.RUNNING;
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
          mainButtonText = _buttonTextPause;
        });
      } else {
        _playSound();
        _setNum++;
        _cancelTimer();
        if (_setNum % POMODORO_PER_SET == 0) {
          pomodoroStatus = PomodoroStatus.PAUSED_LONG_BREAK;
          setState(() {
            remainingTime = LONG_BREAK_TIME;
            mainButtonText = _buttonTextStartLongBreak;
            _setNum = 0;
          });
        } else {
          pomodoroStatus = PomodoroStatus.PAUSED_SHORT_BREAK;
          setState(() {
            remainingTime = SHORT_BREAK_TIME;
            mainButtonText = _buttonTextStartShortBreak;
          });
        }
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
      mainButtonText = _buttonTextResumePomodoro;
    });
  }

  _resetButtonPressed() {
    _setNum = 0;
    _cancelTimer();
    _stopCountdown();
  }

  void _stopCountdown() {
    pomodoroStatus = PomodoroStatus.PAUSED;
    setState(() {
      mainButtonText = _buttonTextStart;
      remainingTime = POMODORO_TOTAL_TIME;
    });
  }

  void _pauseShortBreakCountdown() {
    pomodoroStatus = PomodoroStatus.PAUSED_SHORT_BREAK;
    _pauseBreakCountdown();
  }

  void _pauseLongBreakCountdown() {
    pomodoroStatus = PomodoroStatus.PAUSED_LONG_BREAK;
    _pauseBreakCountdown();
  }

  void _pauseBreakCountdown() {
    _cancelTimer();
    setState(() {
      mainButtonText = _buttonTextResumeBreak;
    });
  }

  void _startShortBreak() {
    pomodoroStatus = PomodoroStatus.RUNNING_SHORT_BREAK;
    setState(() {
      mainButtonText = _buttonTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _playSound();
        remainingTime = POMODORO_TOTAL_TIME;
        _cancelTimer();
        pomodoroStatus = PomodoroStatus.PAUSED;
        setState(() {
          mainButtonText = _buttonTextStart;
        });
      }
    });
  }

  void _startLongBreak() {
    pomodoroStatus = PomodoroStatus.RUNNING_LONG_BREAK;
    setState(() {
      mainButtonText = _buttonTextPause;
    });
    _cancelTimer();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _playSound();
        remainingTime = POMODORO_TOTAL_TIME;
        _cancelTimer();
        pomodoroStatus = PomodoroStatus.FINISHED;
        setState(() {
          mainButtonText = _buttonTextStartNewSet;
        });
      }
    });
  }

  void _playSound() {
    debugPrint('playSound');
    // player.play()
  }
}
