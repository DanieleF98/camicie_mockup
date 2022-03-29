import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:flutter/material.dart';

Widget floatingActionButton(
  BuildContext context,
  int size,
  ModelOfShirtEnum modelOfShirtEnum,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: FloatingActionButton(
      tooltip: addFabricFloatingButtonTooltip,
      child: const Icon(
        Icons.add,
        size: 35,
      ),
      onPressed: () =>
          navigateToAddFabricInfo(context, <dynamic>[size, modelOfShirtEnum]),
    ),
  );
}
