import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color textColor;
  final Color strokeColor;
  final TextStyle? textStyle;
  final List<Shadow>? shadows;

  const StrokeText(
      {Key? key,
        required this.text,
        this.strokeWidth = 1,
        this.strokeColor = Colors.black,
        this.textColor = Colors.white,
        this.textStyle,
        this.shadows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
            shadows: shadows,
          ).merge(textStyle),
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ).merge(textStyle),
        ),
      ],
    );
  }
}
