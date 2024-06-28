

import 'package:flutter/cupertino.dart';

class StrokedText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color strokeColor;
  final Color textColor;
  final double fontSize;

  StrokedText({
    required this.text,
    required this.strokeWidth,
    required this.strokeColor,
    required this.textColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Stroked text as the first layer
        Text(
          text,
          style: TextStyle(
            height: 1,
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        // Regular text as the second layer
        Text(
          text,
          style: TextStyle(
            height: 1,
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ],
    );
  }
}