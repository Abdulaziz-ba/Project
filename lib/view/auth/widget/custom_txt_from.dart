// ignore_for_file: empty_constructor_bodies

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'custom_txt.dart';

class custom_txt_from extends StatelessWidget {
  final String text;
  final String hint;
  final Function onSave;
  final Function validato;

  custom_txt_from(
      {required this.text,
      required this.hint,
      required this.onSave,
      required this.validato});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTxt(
            text: text,
            fontSize: 14.0,
            color: Colors.grey,
          ),
          TextFormField(
            onSaved: (Value) {},
            validator: (Value) {},
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white),
          )
        ],
      ),
    );
  }
}
