import 'package:camicie_mockup/core/settings/models/global_settings.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GlobalSettingsRepository {
  final CollectionReference<dynamic> globalSettingsCollection =
      FirebaseFirestore.instance.collection(globalSettingsCollectionLabel);

  Future<QuerySnapshot<dynamic>> getAllGlobalSettings() {
    return globalSettingsCollection.get();
  }

  Future<void> addGlobalSetting(
    GlobalSettings globalSettings,
  ) async {
    await globalSettingsCollection.add(globalSettings.toJson());
  }

  Future<void> updateGlobalSetting(GlobalSettings globalSettings) async {
    await globalSettingsCollection
        .doc(globalSettings.id)
        .update(globalSettings.toJson());
  }
}
