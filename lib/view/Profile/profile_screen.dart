import 'package:brandz/view/Profile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
            'Profile Information',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          )),
      body: Body(),
    );
  }
}
