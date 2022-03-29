part of 'main_navigation_bloc.dart';

abstract class MainNavigationState {
  const MainNavigationState(
    this.navigationPage, {
    required this.additionalInfo,
  });

  final NavigationPage navigationPage;
  final List<dynamic> additionalInfo;
}

class MainNavigationStateChangePage extends MainNavigationState {
  MainNavigationStateChangePage(
    NavigationPage navigationPage,
    List<dynamic> additionalInfo,
  ) : super(navigationPage, additionalInfo: additionalInfo);
}

enum NavigationPage {
  homeScreen,
  statisticsScreen,
  modelDetailScreen,
  sizeDetailScreen,
  addFabricScreen,
  notificationScreen,
  fabricImage,
}

const List<NavigationPage> rootPages = <NavigationPage>[
  NavigationPage.homeScreen,
];
