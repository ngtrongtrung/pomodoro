import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:pomodoro/widgets/progress_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Pomodoro number: 2',
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Set: 2',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 220.0,
                      lineWidth: 15.0,
                      percent: 0.3,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        '12:00',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      progressColor: Colors.red,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProgressIcons(total: 4, done: 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
