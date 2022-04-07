import 'package:brandz/view/Profile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title:
            Text('Profile Information', style: TextStyle(color: Colors.black)),
      ),
      body: Body(),
    );
  }
}
