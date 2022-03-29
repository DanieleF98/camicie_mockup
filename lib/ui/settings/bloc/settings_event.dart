part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

class SettingsEventInitializeSettings extends SettingsEvent {
  const SettingsEventInitializeSettings();
}

class SettingsEventUpdateSettings extends SettingsEvent {
  const SettingsEventUpdateSettings();
}

class SettingsEventChangeThemeMode extends SettingsEvent {
  const SettingsEventChangeThemeMode(this.themeMode);

  final ThemeMode themeMode;
}

class SettingsEventChangeTextHomePage extends SettingsEvent {
  const SettingsEventChangeTextHomePage(this.homeScreenText);

  final String homeScreenText;
}
