import 'package:camicie_mockup/ui/settings/bloc/settings_bloc.dart';
import 'package:camicie_mockup/utils/colors.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/storage_service.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

void changeThemeMode(BuildContext context) {
  final SettingsState settingsState = context.read<SettingsBloc>().state;
  final ThemeMode currentThemeMode =
      (settingsState as SettingsLoadedState).themeMode;
  context.read<SettingsBloc>().add(
        SettingsEventChangeThemeMode(
          getOppositeThemeMode(currentThemeMode: currentThemeMode).value,
        ),
      );
}

MapEntry<bool, ThemeMode> getCurrentThemeMode({
  ThemeMode? themeMode,
  bool? isLight,
}) {
  if (themeMode == ThemeMode.dark || isLight == false) {
    return const MapEntry<bool, ThemeMode>(
      false,
      ThemeMode.dark,
    );
  } else {
    return const MapEntry<bool, ThemeMode>(
      true,
      ThemeMode.light,
    );
  }
}

MapEntry<bool, ThemeMode> getOppositeThemeMode({
  ThemeMode? currentThemeMode,
  bool? isLight,
}) {
  switch (currentThemeMode ?? isLight) {
    case ThemeMode.dark:
      return const MapEntry<bool, ThemeMode>(true, ThemeMode.light);

    case ThemeMode.light:
      return const MapEntry<bool, ThemeMode>(false, ThemeMode.dark);

    case true:
      return const MapEntry<bool, ThemeMode>(false, ThemeMode.dark);

    case false:
      return const MapEntry<bool, ThemeMode>(true, ThemeMode.light);

    default:
      return const MapEntry<bool, ThemeMode>(true, ThemeMode.light);
  }
}

String getModelFromEnum(ModelOfShirtEnum? modelOfShirtEnum) {
  switch (modelOfShirtEnum) {
    case ModelOfShirtEnum.classic:
      return classicModelLabel;
    case ModelOfShirtEnum.classicSlim:
      return classicSlimModelLabel;
    case ModelOfShirtEnum.slim:
      return slimModelLabel;
    default:
      return anErrorHasOccurredWithError(
        retrievingModelLabel,
      );
  }
}

ModelOfShirtEnum getModelEnumFromString(String modelOfShirtEnum) {
  switch (modelOfShirtEnum) {
    case classicModelFirebaseLabel:
      return ModelOfShirtEnum.classic;
    case classicSlimModelFirebaseLabel:
      return ModelOfShirtEnum.classicSlim;
    case slimModelFirebaseLabel:
      return ModelOfShirtEnum.slim;
    default:
      return ModelOfShirtEnum.classic;
  }
}

String getSlimSizeFromInt(int size) {
  switch (size) {
    case 10:
      return slimSizeExtraExtraSlimLabel;
    case 11:
      return slimSizeExtraSlimLabel;
    case 12:
      return slimSizeSlimLabel;
    case 13:
      return slimSizeMediumLabel;
    case 14:
      return slimSizeLargeLabel;
    case 15:
      return slimSizeExtraLargeLabel;
    default:
      return genericErrorLabel;
  }
}

void showToastError({required String text}) {
  Fluttertoast.showToast(
    backgroundColor: Colors.red,
    textColor: primaryLightColor,
    msg: text,
    fontSize: 15,
    gravity: ToastGravity.TOP,
  );
}

Future<XFile?> pickImage(ImageSource source) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: source,
    );
    if (image == null) {
      showToastError(text: noPhotoSelected);
      return null;
    }
    return image;
  } catch (e) {
    showToastError(
      text: anErrorHasOccurredWithError(
        selectionOfThePhotoLabel,
      ),
    );
    return null;
  }
}

Future<void> uploadImage(XFile image) async {
  final String imagePath = image.path;
  final String imageName = image.name;
  try {
    await StorageService().uploadFile(imagePath, imageName);
  } catch (e) {
    showToastError(
      text: anErrorHasOccurredWithError(
        uploadOfThePhotoLabel,
      ),
    );
  }
}
