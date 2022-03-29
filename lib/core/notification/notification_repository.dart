import 'package:camicie_mockup/core/notification/models/notification.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepository {
  final CollectionReference<dynamic> notificationCollection =
      FirebaseFirestore.instance.collection(notificationCollectionLabel);

  Future<QuerySnapshot<dynamic>> getAllNotifications() {
    return notificationCollection.get();
  }

  Future<DocumentReference<dynamic>> addNotification(
    MissingModelNotification notification,
  ) {
    return notificationCollection.add(notification.toJson());
  }

  Future<void> updateNotification(MissingModelNotification notification) async {
    await notificationCollection
        .doc(notification.id)
        .update(notification.toJson());
  }

  Future<void> deleteNotification(MissingModelNotification notification) async {
    await notificationCollection.doc(notification.id).delete();
  }

  Future<void> removeAllNotifications() async {
    getAllNotifications().then((QuerySnapshot<dynamic> snapshot) {
      for (final DocumentSnapshot<dynamic> ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
