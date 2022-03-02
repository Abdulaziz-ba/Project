import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final TextAlign textAlign;
  CustomText(
      {this.text = "",
      this.fontSize = 16,
      this.color = Colors.black,
      this.alignment = Alignment.topLeft,
      this.textAlign = TextAlign.center});

  Widget build(BuildContext context) {
    // ignore: dead_code
    return Container(
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
