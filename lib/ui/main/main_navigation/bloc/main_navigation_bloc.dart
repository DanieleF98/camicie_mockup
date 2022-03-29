import 'package:camicie_mockup/utils/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack/stack.dart';

part 'main_navigation_event.dart';
part 'main_navigation_state.dart';

final MainNavigationStateChangePage _initialState =
    MainNavigationStateChangePage(
  NavigationPage.homeScreen,
  <dynamic>[],
);

class MainNavigationBloc
    extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc() : super(_initialState) {
    on<MainNavigationEventNavigateTo>(
      _onMainNavigationEventNavigateTo,
    );
    on<MainNavigationEventNavigateBack>(
      _onMainNavigationEventNavigateBack,
    );
  }
  final Stack<MainNavigationState> _navigationStack =
      Stack<MainNavigationState>()
        ..push(
          _initialState,
        );

  void _onMainNavigationEventNavigateTo(
    MainNavigationEventNavigateTo event,
    Emitter<MainNavigationState> emit,
  ) {
    if (event.navigationPage != _navigationStack.top().navigationPage) {
      if (rootPages.contains(event.navigationPage)) {
        _navigationStack.clear();
      }
      final MainNavigationStateChangePage newState =
          MainNavigationStateChangePage(
        event.navigationPage,
        event.additionalInfo,
      );
      _navigationStack.push(newState);
      emit(newState);
    }
  }

  void _onMainNavigationEventNavigateBack(
    MainNavigationEventNavigateBack event,
    Emitter<MainNavigationState> emit,
  ) {
    _navigationStack.pop();
    emit(_navigationStack.top());
  }
}
