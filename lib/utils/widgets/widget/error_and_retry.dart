import 'package:camicie_mockup/utils/strings.dart';
import 'package:camicie_mockup/utils/style.dart';
import 'package:flutter/material.dart';

class ErrorAndRetry extends StatelessWidget {
  const ErrorAndRetry({required this.retryFunction, this.color, Key? key})
      : super(key: key);

  final Function retryFunction;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          anErrorHasOccurred,
          style: baseTextStyle.copyWith(fontSize: 24, color: color),
        ),
        const SizedBox(
          height: 10,
        ),
        IconButton(
          onPressed: () => retryFunction.call(),
          icon: Icon(
            Icons.refresh,
            color: color,
            size: 40,
          ),
        ),
      ],
    );
  }
}
