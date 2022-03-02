// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
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
