import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    required this.inputController,
    required this.hintText,
    this.primaryColor = Colors.purple,
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
            color: Colors.grey.withOpacity(
              .1,
            ),
          ),
        ],
      ),
      child: TextField(
        controller: inputController,
        keyboardType: TextInputType.name,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}
