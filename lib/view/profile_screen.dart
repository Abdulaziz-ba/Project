import 'package:brandz/view/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      FlatButton(
        onPressed: () async{
        await _firebaseAuth.signOut();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
        },
        child: Text("LOGOUT"),
        color: Colors.red,
      ),
    ]))));
  }
}
