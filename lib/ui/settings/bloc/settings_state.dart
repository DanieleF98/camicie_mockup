part of 'settings_bloc.dart';

abstract class SettingsState {
  const SettingsState();
}

class SettingsInitialState extends SettingsState {
  const SettingsInitialState();
}

class SettingsLoadedState extends SettingsState {
  const SettingsLoadedState(this.themeMode, this.globalSettings);

  SettingsLoadedState copyWith({
    ThemeMode? themeMode,
    GlobalSettings? globalSettings,
  }) {
    return SettingsLoadedState(
      themeMode ?? this.themeMode,
      globalSettings ?? this.globalSettings,
    );
  }

  final ThemeMode themeMode;
  final GlobalSettings globalSettings;
}

class SettingsErrorState extends SettingsState {
  const SettingsErrorState();
}
