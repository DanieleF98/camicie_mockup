import 'package:camicie_mockup/utils/colors.dart';
import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      // TODO: Improve
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          color: circularProgressIndicatorColor,
        ),
      ),
    );
  }
}
