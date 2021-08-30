import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  const CustomButton({this.onTap, required this.label});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.75,
      child: ElevatedButton(
        onPressed: this.onTap,
        child: Text(
          this.label,
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
