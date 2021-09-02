import 'package:flutter/material.dart';
import 'package:pomodoro/theme/app_color.dart';

class ActionButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final bool isFilled;
  const ActionButton({this.onTap, required this.label, this.isFilled = false});
  @override
  Widget build(BuildContext context) {
    final double diameter = 90.0;
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
            style: TextStyle(fontSize: 18, color: DEAF_COVE),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    // InkWell(
    //   onTap: this.onTap,
    //   borderRadius: BorderRadius.all(Radius.circular(diameter)),
    //   customBorder: CircleBorder(),
    //   child: Padding(
    //     padding: EdgeInsets.all(8.0),
    //     child: Container(
    //       color: Colors.yellow,
    //       height: diameter,
    //       width: diameter,
    //       child: Center(
    //         child: Text(
    //           this.label,
    //           style: TextStyle(
    //             fontSize: 18,
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
