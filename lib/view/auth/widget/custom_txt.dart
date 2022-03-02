import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomTxt extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;

  CustomTxt(
      {this.text = "",
      this.fontSize = 16.0,
      this.color = Colors.black,
      this.alignment = Alignment.topLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: fontSize),
      ),
    );
  }
}
