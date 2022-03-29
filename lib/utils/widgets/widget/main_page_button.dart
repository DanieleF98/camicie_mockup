import 'package:camicie_mockup/ui/main/main_navigation/utils/navigation_utils.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:camicie_mockup/utils/utils.dart';
import 'package:flutter/material.dart';

class MainPageButton extends StatelessWidget {
  const MainPageButton({
    Key? key,
    this.text,
    this.onPressed,
    this.modelOfShirtEnum,
  }) : super(key: key);

  final String? text;
  final VoidCallback? onPressed;
  final ModelOfShirtEnum? modelOfShirtEnum;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: onPressed ??
              () => navigateToModelInfo(context, modelOfShirtEnum!),
          child: Center(
            child: FittedBox(
              child: Text(
                text ?? getModelFromEnum(modelOfShirtEnum),
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
