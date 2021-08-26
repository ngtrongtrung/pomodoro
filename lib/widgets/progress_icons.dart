import 'package:flutter/material.dart';

class ProgressIcons extends StatelessWidget {
  final int total;
  final int done;

  const ProgressIcons({required this.total, required this.done})
      : assert(total >= 0),
        assert(done >= 0);

  @override
  Widget build(BuildContext context) {
    final double iconSize = 50.0;

    final Icon doneIcon = Icon(
      Icons.beenhere,
      color: Colors.orange,
      size: iconSize,
    );

    final Icon notDoneIcon = Icon(
      Icons.beenhere,
      color: Colors.orange[100],
      size: iconSize,
    );

    List<Icon> icons = List.generate(
        this.total, (int index) => index < done ? doneIcon : notDoneIcon);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: icons,
      ),
    );
  }
}
