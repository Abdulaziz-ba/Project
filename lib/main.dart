//import 'package:brandz/view/auth/login_screen.dart';
//import 'package:brandz/view/regScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'view/auth/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email And Password Login',
      // color indicator when texting or writing input>> (PrimarySwatch)
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
