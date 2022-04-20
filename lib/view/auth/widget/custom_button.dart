// ignore_for_file: deprecated_member_use

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'custom_txt.dart';

class Custom_button extends StatelessWidget {
  final String text;
  final Function onPerssed;

  const Custom_button({required this.text, required this.onPerssed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(18),
      onPressed: () {},
      color: Colors.black,
      child: CustomTxt(
        text: text,
        alignment: Alignment.topCenter,
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }
}
