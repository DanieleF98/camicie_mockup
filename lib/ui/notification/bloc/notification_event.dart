part of 'notification_bloc.dart';

abstract class NotificationEvent {
  const NotificationEvent();
}

class NotificationEventInitializeNotifications extends NotificationEvent {
  const NotificationEventInitializeNotifications();
}

class NotificationEventUpdateNotifications extends NotificationEvent {
  const NotificationEventUpdateNotifications();
}

class NotificationEventUpdateNotification extends NotificationEvent {
  const NotificationEventUpdateNotification(this.notification);

  final MissingModelNotification notification;
}

class NotificationEventAddNotification extends NotificationEvent {
  NotificationEventAddNotification(this.notification);

  final MissingModelNotification notification;
}

class NotificationEventRemoveNotification extends NotificationEvent {
  NotificationEventRemoveNotification(this.missingModelNotification);

  final MissingModelNotification missingModelNotification;
}

class NotificationEventRemoveAllNotifications extends NotificationEvent {
  const NotificationEventRemoveAllNotifications();
}
