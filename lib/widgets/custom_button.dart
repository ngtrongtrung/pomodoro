import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  const CustomButton({this.onTap, required this.label});
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: 200,
        child: ElevatedButton(
            onPressed: this.onTap,
            child: Text(
              this.label,
              style: TextStyle(fontSize: 25),
            )));
  }
}
