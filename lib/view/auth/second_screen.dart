import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_com1/core/view_model/auth.dart';
import 'package:get/get.dart';

class SecondScreen extends StatelessWidget {
  Auth viewModel = Get.put(Auth());
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetX<Auth>(
            init: Auth(),
            builder: (value) => Text("${value}"),
          ),
          RaisedButton(
            child: Text("increment"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
