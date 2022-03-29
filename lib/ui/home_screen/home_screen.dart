import 'package:camicie_mockup/ui/home_screen/dialog/change_home_screen_text_dialog.dart';
import 'package:camicie_mockup/ui/settings/bloc/settings_bloc.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/widgets/dialog/custom_loader_dialog.dart';
import 'package:camicie_mockup/utils/widgets/widget/main_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[..._getHomeScreenButtons(context)],
    );
  }

  List<Widget> _getHomeScreenButtons(BuildContext context) {
    return <Widget>[
      MainPageButton(
        text: (context.watch<SettingsBloc>().state as SettingsLoadedState)
            .globalSettings
            .homeScreenText,
        onPressed: () async {
          showCustomLoaderDialog(context);
          await changeHomeScreenTextDialog(context).then((_) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        },
      ),
      const MainPageButton(
        modelOfShirtEnum: ModelOfShirtEnum.classic,
      ),
      const MainPageButton(
        modelOfShirtEnum: ModelOfShirtEnum.classicSlim,
      ),
      const MainPageButton(
        modelOfShirtEnum: ModelOfShirtEnum.slim,
      )
    ];
  }
}
