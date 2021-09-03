import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_event.dart';
import 'package:pomodoro/widgets/action_button.dart';

class MobileLandscapeLayout extends StatefulWidget {
  final double pomodoroPercentage;
  final String timeRemain;
  final Color statusColor;
  final String resetButtonText;
  final String mainButtonText;
  final void Function() resetButtonPressed;
  final void Function() mainButtonPressed;
  final String description;

  MobileLandscapeLayout({
    required this.pomodoroPercentage,
    required this.timeRemain,
    required this.statusColor,
    required this.resetButtonText,
    required this.mainButtonText,
    required this.mainButtonPressed,
    required this.resetButtonPressed,
    required this.description,
  });

  @override
  _MobileLandscapeLayoutState createState() => _MobileLandscapeLayoutState();
}

class _MobileLandscapeLayoutState extends State<MobileLandscapeLayout> {
  late final appThemeBloc;
  @override
  void initState() {
    super.initState();
    appThemeBloc = BlocProvider.of<AppThemeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size mobileSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
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
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      child: CircularPercentIndicator(
                        radius: mobileSize.height * 0.5,
                        lineWidth: 15.0,
                        percent: widget.pomodoroPercentage,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          widget.timeRemain,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        progressColor: widget.statusColor,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ActionButton(
                            label: widget.mainButtonText,
                            onTap: widget.mainButtonPressed,
                            isFilled: true,
                          ),
                          ActionButton(
                            label: widget.resetButtonText,
                            onTap: widget.resetButtonPressed,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(widget.description),
              )
            ],
          ),
        ),
      ),
    );
  }
}
