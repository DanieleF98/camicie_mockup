import 'package:camicie_mockup/ui/main/main_navigation/bloc/main_navigation_bloc.dart';
import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/ui/notification/custom_notification_button.dart';
import 'package:camicie_mockup/ui/statistics_screen/widget/go_to_statistics_screen_icon_button.dart';
import 'package:camicie_mockup/utils/dimensions.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/widgets/widget/theme_changer_icon_button.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, MainNavigationState state) {
  return AppBar(
    elevation: appBarElevation,
    leading: state.navigationPage != NavigationPage.homeScreen
        ? _goBackArrow(
            context,
          )
        : null,
    title: const FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        camicieMockupLabel,
      ),
    ),
    actions: _getActions(context),
  );
}

Widget _goBackArrow(
  BuildContext context,
) {
  return IconButton(
    onPressed: () => navigateBack(context),
    padding: EdgeInsets.zero,
    icon: const Icon(
      Icons.arrow_back,
      size: 20,
    ),
  );
}

List<Widget> _getActions(BuildContext context) {
  return <Widget>[
    const GoToStatisticsScreenIconButton(),
    const SizedBox(
      width: appBarIconDistance,
    ),
    const ThemeChangerIconButton(),
    const SizedBox(
      width: appBarIconDistance,
    ),
    const CustomNotificationButton(),
  ];
}
