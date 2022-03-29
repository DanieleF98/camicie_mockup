import 'package:camicie_mockup/ui/settings/bloc/settings_bloc.dart';
import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:camicie_mockup/utils/widgets/widget/custom_input_field_blinking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _kPadding = 20.0;

Future<void> changeHomeScreenTextDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const ChangeTextDialog();
    },
  );
}

class ChangeTextDialog extends StatefulWidget {
  const ChangeTextDialog({Key? key}) : super(key: key);
  @override
  _ChangeTextDialogState createState() => _ChangeTextDialogState();
}

class _ChangeTextDialogState extends State<ChangeTextDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final SettingsLoadedState state =
        context.read<SettingsBloc>().state as SettingsLoadedState;
    controller.text = state.globalSettings.homeScreenText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const FittedBox(
        child: Text(
          doYouWantToChangeHomeScreenDialogQuestionLabel,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(_kPadding),
          child: CustomInputFieldBlinking(
            inputController: controller,
            hintText: controller.text,
          ),
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      cancelLabel,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    context.read<SettingsBloc>().add(
                          SettingsEventChangeTextHomePage(
                            controller.text,
                          ),
                        );
                    Navigator.pop(context);
                  } else {
                    showToastError(text: insertAtLeastOneCharacterLabel);
                  }
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      confirmLabel,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
