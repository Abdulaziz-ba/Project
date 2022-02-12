import 'package:flutter/material.dart';

import 'package:flutter_com1/view/auth/login_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: LoginScreen(),
      ),
    );
  }
}
