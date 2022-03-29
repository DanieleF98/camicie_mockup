part of 'main_navigation_bloc.dart';

abstract class MainNavigationEvent {
  const MainNavigationEvent();
}

class MainNavigationEventNavigateTo extends MainNavigationEvent {
  const MainNavigationEventNavigateTo(
    this.navigationPage, {
    required this.additionalInfo,
  });

  final NavigationPage navigationPage;
  final List<dynamic> additionalInfo;
}

class MainNavigationEventNavigateBack extends MainNavigationEvent {
  const MainNavigationEventNavigateBack();
}
