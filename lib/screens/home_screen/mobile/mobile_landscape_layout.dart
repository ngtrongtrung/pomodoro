import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_event.dart';
import 'package:pomodoro/widgets/action_button.dart';
import 'package:pomodoro/widgets/drop_down/language_drop_down.dart';

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
    Size windowSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 20, right: 20),
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
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          radius: windowSize.height * 0.5,
                          lineWidth: 15.0,
                          percent: widget.pomodoroPercentage,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            widget.timeRemain,
                            style: TextStyle(
                              fontSize: windowSize.height * 0.09,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          progressColor: widget.statusColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: windowSize.width * 0.1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                          label: tr(widget.mainButtonText),
                          onTap: widget.mainButtonPressed,
                          isFilled: true,
                        ),
                        ActionButton(
                          label: tr(widget.resetButtonText),
                          onTap: widget.resetButtonPressed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(tr(widget.description)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
