// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../core/view_model/auth.dart';

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
