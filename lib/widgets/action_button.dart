import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pomodoro/theme/app_color.dart';
import 'package:pomodoro/theme/app_theme.dart';

class ActionButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final bool isFilled;
  const ActionButton({this.onTap, required this.label, this.isFilled = false});
  @override
  Widget build(BuildContext context) {
    final double diameter = 90.0;
    final themeProvider = Provider.of<AppThemeProvider>(context);

    Color getLabelColor() {
      if (themeProvider.isDarkMode) {
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
