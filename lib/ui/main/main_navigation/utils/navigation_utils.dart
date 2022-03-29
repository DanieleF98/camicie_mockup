import 'package:camicie_mockup/ui/main/main_navigation/bloc/main_navigation_bloc.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void navigateToHomeScreen(BuildContext context) {
  context.read<MainNavigationBloc>().add(
        const MainNavigationEventNavigateTo(
          NavigationPage.homeScreen,
          additionalInfo: <dynamic>[],
        ),
      );
}

void navigateToModelInfo(
  BuildContext context,
  ModelOfShirtEnum modelOfShirtEnum,
) {
  context.read<MainNavigationBloc>().add(
        MainNavigationEventNavigateTo(
          NavigationPage.modelDetailScreen,
          additionalInfo: <dynamic>[modelOfShirtEnum],
        ),
      );
}

void navigateToSizeInfo(BuildContext context, List<dynamic> info) {
  context.read<MainNavigationBloc>().add(
        MainNavigationEventNavigateTo(
          NavigationPage.sizeDetailScreen,
          additionalInfo: info,
        ),
      );
}

void navigateToStatistics(BuildContext context) {
  context.read<MainNavigationBloc>().add(
        const MainNavigationEventNavigateTo(
          NavigationPage.statisticsScreen,
          additionalInfo: <dynamic>[],
        ),
      );
}

void navigateToAddFabricInfo(BuildContext context, List<dynamic> info) {
  context.read<MainNavigationBloc>().add(
        MainNavigationEventNavigateTo(
          NavigationPage.addFabricScreen,
          additionalInfo: info,
        ),
      );
}

void navigateToNotificationScreen(BuildContext context) {
  context.read<MainNavigationBloc>().add(
        const MainNavigationEventNavigateTo(
          NavigationPage.notificationScreen,
          additionalInfo: <dynamic>[],
        ),
      );
}

void navigateToFabricImage(
  BuildContext context,
  String imageUrl,
  String fabricId,
) {
  context.read<MainNavigationBloc>().add(
        MainNavigationEventNavigateTo(
          NavigationPage.fabricImage,
          additionalInfo: <String>[imageUrl, fabricId],
        ),
      );
}

void navigateBack(BuildContext context) {
  context.read<MainNavigationBloc>().add(
        const MainNavigationEventNavigateBack(),
      );
}
