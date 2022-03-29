import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:flutter/material.dart';

void showCustomLoaderDialog(
  BuildContext context,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => const CustomLoaderAlert(),
  );
}

class CustomLoaderAlert extends StatelessWidget {
  const CustomLoaderAlert({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        loadingLabel,
        style: boldTextStyle,
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          children: const <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              pleaseWaitAMinuteLabel,
              style: baseTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void dismissDialog(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
