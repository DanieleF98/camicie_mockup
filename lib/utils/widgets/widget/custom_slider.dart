import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    required this.min,
    required this.max,
    this.initialValue = 0.0,
    required this.onChange,
    this.accentColor = Colors.white,
    this.gradient = const LinearGradient(
      colors: <Color>[
        Colors.indigo,
        Colors.deepPurple,
      ],
    ),
    this.showMinMaxText = true,
    this.minMaxTextStyle = const TextStyle(fontSize: 14),
    Key? key,
  }) : super(key: key);
  final double min;
  final double max;
  final double initialValue;
  final bool showMinMaxText;
  final Color accentColor;
  final LinearGradient gradient;
  final Function(double) onChange;
  final TextStyle minMaxTextStyle;

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentSliderValue;
  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: widget.gradient,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.5, right: 15.5),
        child: Row(
          children: <Widget>[
            Text(
              '${widget.min.toInt()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: widget.accentColor,
                  inactiveTrackColor: widget.accentColor.withAlpha(35),
                  trackShape: const RoundedRectSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbShape: CustomSliderThumbCircle(
                    thumbRadius: 20,
                    min: widget.min,
                    max: widget.max,
                  ),
                  thumbColor: widget.gradient.colors[0],
                  overlayColor: widget.gradient.colors[0].withAlpha(32),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 28.0),
                  tickMarkShape: const RoundSliderTickMarkShape(),
                  activeTickMarkColor: widget.accentColor,
                  inactiveTickMarkColor: widget.accentColor.withAlpha(35),
                  valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: widget.gradient.colors[0],
                  valueIndicatorTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                  divisions: widget.max.toInt(),
                  min: widget.min,
                  max: widget.max,
                  value: _currentSliderValue,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                    widget.onChange(value);
                  },
                ),
              ),
            ),
            Text(
              '${widget.max.toInt()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  const CustomSliderThumbCircle({
    required this.thumbRadius,
    this.min = 0.0,
    this.max = 100.0,
  });

  final double thumbRadius;
  final double min;
  final double max;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor,
      ),
      text: getValue(value),
    );

    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    final Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
