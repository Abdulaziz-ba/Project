import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      FlatButton(
        onPressed: () {},
        child: Text("LOGOUT"),
        color: Colors.red,
      ),
    ]))));
  }
}
