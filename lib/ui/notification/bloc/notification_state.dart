part of 'notification_bloc.dart';

abstract class NotificationState {
  const NotificationState();
}

class NotificationInitialState extends NotificationState {
  const NotificationInitialState();
}

class NotificationLoadingState extends NotificationState {
  const NotificationLoadingState();
}

class NotificationLoadedState extends NotificationState {
  const NotificationLoadedState(this.notifications, {this.isLoading});

  NotificationLoadedState copyWith({
    List<MissingModelNotification>? notifications,
    bool? isLoading,
  }) {
    return NotificationLoadedState(
      notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final List<MissingModelNotification> notifications;
  final bool? isLoading;
}

class NotificationStateErrorState extends NotificationState {
  const NotificationStateErrorState();
}
