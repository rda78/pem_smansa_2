import 'package:flutter/material.dart';

class TextSize {
  static Size get(String text, TextStyle style, double width) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        //maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: width);
    return textPainter.size;
  }
}