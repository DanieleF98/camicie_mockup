import 'package:camicie_mockup/utils/strings.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.upcoming,
            size: 50,
          ),
          Text(
            comingSoonLabel,
            style: TextStyle(fontSize: 50),
          ),
        ],
      ),
    );
  }
}
