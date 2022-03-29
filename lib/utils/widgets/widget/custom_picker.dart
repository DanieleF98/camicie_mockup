import 'package:camicie_mockup/utils/strings.dart';
import 'package:flutter/material.dart';

class CustomPicker extends StatefulWidget {
  const CustomPicker({
    required this.onChangeValue,
    required this.defaultValue,
    required this.symbol,
    Key? key,
  })  : assert(defaultValue >= 0),
        super(key: key);

  final int defaultValue;
  final String symbol;
  final Function(int) onChangeValue;

  @override
  State<CustomPicker> createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  late int _count;
  @override
  void initState() {
    super.initState();
    _count = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.symbol == plusSymbolLabel) {
      return OutlinedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(10, 10)),
        ),
        onPressed: () {
          setState(() {
            _count += 1;
          });
          widget.onChangeValue(_count);
        },
        child: Text(
          widget.symbol,
          style: const TextStyle(fontSize: 22),
        ),
      );
    } else {
      return OutlinedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(10, 10)),
        ),
        onPressed: () {
          if (_count > 0) {
            setState(() {
              _count -= 1;
            });
            widget.onChangeValue(_count);
          }
        },
        child: Text(
          widget.symbol,
          style: const TextStyle(fontSize: 22),
        ),
      );
    }
  }
}
