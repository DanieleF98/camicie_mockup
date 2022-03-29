import 'package:camicie_mockup/core/settings/models/global_settings.dart';

class GlobalSettingsBuilder {
  static GlobalSettings builder(
    dynamic snapshot,
  ) {
    return GlobalSettings(
      snapshot['Id'] as String,
      snapshot['HomeScreenText'] as String,
    );
  }
}
