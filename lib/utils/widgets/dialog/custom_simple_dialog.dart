import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:flutter/material.dart';

Future<void> showCustomAlert(
  BuildContext context,
  String title,
  String description,
  VoidCallback onPressed,
) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => CustomAlert(
      title: title,
      description: description,
      onPressed: onPressed,
    ),
  );
}

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    required this.title,
    required this.description,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final String description;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <ElevatedButton>[
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            cancelLabel,
            style: boldTextStyle.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            onPressed.call();
          },
          child: Text(
            confirmLabel,
            style: boldTextStyle.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
