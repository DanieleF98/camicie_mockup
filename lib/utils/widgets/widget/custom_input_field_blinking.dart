import 'package:camicie_mockup/utils/style.dart';
import 'package:flutter/material.dart';

class CustomInputFieldBlinking extends StatelessWidget {
  const CustomInputFieldBlinking({
    Key? key,
    required this.inputController,
    required this.hintText,
    this.primaryColor = Colors.indigo,
  }) : super(key: key);

  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            color: Colors.grey.withOpacity(.1),
          ),
        ],
      ),
      child: TextField(
        autofocus: true,
        controller: inputController,
        keyboardType: TextInputType.emailAddress,
        style: baseTextStyle.copyWith(fontSize: 20),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}
