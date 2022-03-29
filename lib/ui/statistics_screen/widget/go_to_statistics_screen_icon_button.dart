import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/utils/dimensions.dart';
import 'package:flutter/material.dart';

class GoToStatisticsScreenIconButton extends StatelessWidget {
  const GoToStatisticsScreenIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        navigateToStatistics(context);
      },
      icon: const Icon(
        Icons.bar_chart,
        size: appBarIconSize,
      ),
    );
  }
}
