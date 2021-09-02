import 'package:flutter/material.dart';
import 'package:pomodoro/utils/constants.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < MINIMUM_TABLET_WIDTH;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < MINIMUM_DESKTOP_WIDTH &&
      MediaQuery.of(context).size.width >= MINIMUM_TABLET_WIDTH;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= MINIMUM_DESKTOP_WIDTH;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= MINIMUM_DESKTOP_WIDTH) {
          return desktop;
        } else if (constraints.minWidth >= MINIMUM_TABLET_WIDTH) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
