import 'package:camicie_mockup/core/notification/models/notification.dart';

class NotificationBuilder {
  static MissingModelNotification builder(
    dynamic snapshot,
  ) {
    return MissingModelNotification(
      snapshot['Id'] as String,
      snapshot['ImageUrl'] as String,
      snapshot['FabricName'] as String,
      snapshot['FabricId'] as String,
      snapshot['Size'] as int,
      snapshot['TotalAmount'] as int,
    );
  }
}
