import 'package:camicie_mockup/ui/fabric/add_fabric_screen/add_fabric_screen.dart';
import 'package:camicie_mockup/ui/fabric/bloc/fabric_bloc.dart';
import 'package:camicie_mockup/ui/fabric/widgets/fabric_image.dart';
import 'package:camicie_mockup/ui/home_screen/custom_app_bar/custom_app_bar.dart';
import 'package:camicie_mockup/ui/home_screen/home_screen.dart';
import 'package:camicie_mockup/ui/main/main_navigation/bloc/main_navigation_bloc.dart';
import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/ui/model_detail_screen/model_detail_screen.dart';
import 'package:camicie_mockup/ui/notification/widget/notification_screen.dart';
import 'package:camicie_mockup/ui/size_detail_screen/size_detail_screen.dart';
import 'package:camicie_mockup/ui/statistics_screen/statistics_screen.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationBloc, MainNavigationState>(
      builder: (BuildContext context, MainNavigationState state) =>
          WillPopScope(
        onWillPop: () => _onWillPop(context, state),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customAppBar(context, state),
          body: AnimatedSwitcher(
            duration: defaultAnimationDuration,
            child: _getCurrentPage(state.navigationPage, state.additionalInfo),
          ),
        ),
      ),
    );
  }
}

Future<bool> _onWillPop(BuildContext context, MainNavigationState state) async {
  if (state.navigationPage == NavigationPage.homeScreen) {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(areYouSureYouWantToExitLabel),
            content: const Text(pressYesToContinueAndExitTheAppLabel),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(noLabel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(yesLabel),
              ),
            ],
          ),
        ) ??
        false;
  } else {
    navigateBack(context);
    return false;
  }
}

Widget _getCurrentPage(
  NavigationPage navigationPage,
  List<dynamic> additionalInfo,
) {
  switch (navigationPage) {
    case NavigationPage.homeScreen:
      return const HomeScreen();

    case NavigationPage.statisticsScreen:
      return const StatisticsScreen();

    case NavigationPage.modelDetailScreen:
      return ModelDetailScreen(
        modelOfShirtEnum: additionalInfo.single as ModelOfShirtEnum,
      );
    case NavigationPage.sizeDetailScreen:
      return SizeDetailScreen(
        info: additionalInfo,
      );

    case NavigationPage.addFabricScreen:
      return BlocProvider<FabricBloc>(
        lazy: false,
        create: (BuildContext context) => FabricBloc(
          context,
          additionalInfo[0] as int,
          additionalInfo[1] as ModelOfShirtEnum,
        ),
        child: AddFabricScreen(info: additionalInfo),
      );
    case NavigationPage.notificationScreen:
      return const NotificationScreen();
    case NavigationPage.fabricImage:
      return FabricImage(
        imageUrl: additionalInfo[0] as String,
        fabricId: additionalInfo[1] as String,
      );
  }
}
