import 'dart:async';
import 'dart:developer';

import 'package:camicie_mockup/core/settings/converters/global_settings_builder.dart';
import 'package:camicie_mockup/core/settings/global_settings_repository.dart';
import 'package:camicie_mockup/core/settings/models/global_settings.dart';
import 'package:camicie_mockup/core/shared/shared_preferences/shared_preferences.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(BuildContext context)
      : _sharedPref = context.read<SharedPref>(),
        _globalSettingsRepository = context.read<GlobalSettingsRepository>(),
        super(const SettingsInitialState()) {
    _timer = Timer.periodic(
      const Duration(seconds: 20),
      (_) => add(const SettingsEventUpdateSettings()),
    );
    on<SettingsEventInitializeSettings>(_onSettingsEventInitializeSettings);
    on<SettingsEventUpdateSettings>(_onSettingsEventUpdateSettings);
    on<SettingsEventChangeThemeMode>(_onSettingsEventChangeThemeMode);
    on<SettingsEventChangeTextHomePage>(_onSettingsEventChangeTextHomePage);
    add(const SettingsEventInitializeSettings());
  }

  final GlobalSettingsRepository _globalSettingsRepository;
  final SharedPref _sharedPref;
  late final Timer _timer;

  Future<void> _onSettingsEventInitializeSettings(
    SettingsEventInitializeSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(
      const SettingsInitialState(),
    );
    try {
      final bool isLight = await _sharedPref.getThemeData();
      final QuerySnapshot<dynamic> querySnapshot =
          await _globalSettingsRepository.getAllGlobalSettings();
      final GlobalSettings globalSettings = GlobalSettingsBuilder.builder(
        querySnapshot.docs.single.data(),
      );
      emit(
        SettingsLoadedState(
          getCurrentThemeMode(isLight: isLight).value,
          globalSettings,
        ),
      );
    } catch (e) {
      showToastError(
        text: anErrorHasOccurredWithError(
          retrievingGlobalSettingsLabel,
        ),
      );
      log(e.toString());
      emit(
        const SettingsErrorState(),
      );
    }
  }

  Future<void> _onSettingsEventUpdateSettings(
    SettingsEventUpdateSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final SettingsState oldState = state;
    if (oldState is SettingsLoadedState) {
      try {
        final QuerySnapshot<dynamic> querySnapshot =
            await _globalSettingsRepository.getAllGlobalSettings();
        final GlobalSettings globalSettings = GlobalSettingsBuilder.builder(
          querySnapshot.docs.single.data(),
        );
        emit(
          oldState.copyWith(
            globalSettings: globalSettings,
          ),
        );
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            updatingGlobalSettingsLabel,
          ),
        );
        log(e.toString());
        emit(
          const SettingsErrorState(),
        );
      }
    }
  }

  Future<void> _onSettingsEventChangeThemeMode(
    SettingsEventChangeThemeMode event,
    Emitter<SettingsState> emit,
  ) async {
    final SettingsState oldState = state;
    if (oldState is SettingsLoadedState) {
      try {
        await _sharedPref.setThemeData(
          value: getCurrentThemeMode(themeMode: event.themeMode).key,
        );
        emit(oldState.copyWith(themeMode: event.themeMode));
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            changingThemeModeLabel,
          ),
        );
        log(e.toString());
        emit(const SettingsErrorState());
      }
    }
  }

  Future<void> _onSettingsEventChangeTextHomePage(
    SettingsEventChangeTextHomePage event,
    Emitter<SettingsState> emit,
  ) async {
    final SettingsState oldState = state;
    if (oldState is SettingsLoadedState) {
      try {
        final GlobalSettings globalSettings =
            oldState.globalSettings.copyWith(event.homeScreenText);
        await _globalSettingsRepository.updateGlobalSetting(globalSettings);
        emit(
          oldState.copyWith(
            globalSettings: globalSettings,
          ),
        );
      } catch (e) {
        showToastError(
          text: anErrorHasOccurredWithError(
            changingHomeScreenText,
          ),
        );
        log(e.toString());
        emit(
          const SettingsErrorState(),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
