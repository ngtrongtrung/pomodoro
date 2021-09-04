import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro/blocs/app_theme/app_theme_bloc.dart';
import 'package:pomodoro/theme/app_color.dart';

class ActionButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final bool isFilled;
  const ActionButton({this.onTap, required this.label, this.isFilled = false});
  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    final double diameter = 90;
    final appThemeBloc = BlocProvider.of<AppThemeBloc>(context);

    Color getLabelColor() {
      if (appThemeBloc.isDarkMode) {
        return this.isFilled ? DEAF_COVE : JAVA;
      }
      return DEAF_COVE;
    }

    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: JAVA, width: 3.0),
          color: this.isFilled ? JAVA : Colors.transparent),
      height: diameter,
      width: diameter,
      child: InkWell(
        onTap: this.onTap,
        borderRadius: BorderRadius.all(Radius.circular(diameter)),
        child: Center(
          child: Text(
            this.label,
            style: TextStyle(
              fontSize: 18,
              color: getLabelColor(),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
