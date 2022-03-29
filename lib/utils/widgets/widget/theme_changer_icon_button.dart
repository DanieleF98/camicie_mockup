import 'package:camicie_mockup/ui/settings/bloc/settings_bloc.dart';
import 'package:camicie_mockup/utils/dimensions.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeChangerIconButton extends StatelessWidget {
  const ThemeChangerIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        changeThemeMode(context);
      },
      icon: (context.watch<SettingsBloc>().state as SettingsLoadedState)
                  .themeMode ==
              ThemeMode.dark
          ? const Icon(
              Icons.dark_mode,
              size: appBarIconSize,
            )
          : const Icon(
              Icons.light_mode,
              size: appBarIconSize,
            ),
    );
  }
}
