import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_com1/core/view_model/auth_view_model.dart';
import 'package:get/get.dart';

class SecondScreen extends StatelessWidget {
  AuthViewModel viewModel = Get.put(AuthViewModel());
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetX<AuthViewModel>(
            init: AuthViewModel(),
            builder: (value) => Text("${value.counter.value}"),
          ),
          RaisedButton(
            child: Text("increment"),
            onPressed: () {
              viewModel.increment();
            },
          ),
        ],
      ),
    );
  }
}
