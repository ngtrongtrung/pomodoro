import 'package:flutter/material.dart';
import 'package:pomodoro/reponsive.dart';
import 'package:pomodoro/screens/home_screen/mobile/mobile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: MobileHomeScreen(),
        tablet: Container(),
        desktop: Container(),
      ),
    );
  }
}
