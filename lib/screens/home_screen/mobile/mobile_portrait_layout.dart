import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_event.dart';
import 'package:pomodoro/widgets/action_button.dart';
import 'package:pomodoro/widgets/drop_down/language_drop_down.dart';

class MobilePortraitLayout extends StatefulWidget {
  final double pomodoroPercentage;
  final String timeRemain;
  final Color statusColor;
  final String resetButtonText;
  final String mainButtonText;
  final void Function() resetButtonPressed;
  final void Function() mainButtonPressed;
  final String description;

  MobilePortraitLayout({
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
  _MobilePortraitLayoutState createState() => _MobilePortraitLayoutState();
}

class _MobilePortraitLayoutState extends State<MobilePortraitLayout> {
  late final appThemeBloc;
  @override
  void initState() {
    super.initState();
    appThemeBloc = BlocProvider.of<AppThemeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LanguageDropdown(),
                          IconButton(
                            onPressed: () {
                              appThemeBloc.add(ToggleAppTheme());
                            },
                            icon: Icon(appThemeBloc.isDarkMode
                                ? Icons.dark_mode
                                : Icons.dark_mode_outlined),
                            iconSize: 26.0,
                          )
                        ],
                      ),
                    ),
                    Text(
                      tr('app_title'),
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
                      radius: windowSize.height * 0.3,
                      lineWidth: 15.0,
                      percent: widget.pomodoroPercentage,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        widget.timeRemain,
                        style: TextStyle(
                          fontSize: windowSize.height * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      progressColor: widget.statusColor,
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
                          label: tr(widget.resetButtonText),
                          onTap: widget.resetButtonPressed,
                        ),
                        ActionButton(
                          label: tr(widget.mainButtonText),
                          onTap: widget.mainButtonPressed,
                          isFilled: true,
                        ),
                      ],
                    ),
                    Text(tr(widget.description)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
