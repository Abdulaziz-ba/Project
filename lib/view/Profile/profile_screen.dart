// Flutter imports:
import 'package:brandz/view/Profile/components/guest_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'components/body.dart';

class ProfilePage extends StatelessWidget {
  //const ProfilePage({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;
  bool isNull = false;

  @override
  Widget build(BuildContext context) {
    func();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Account',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          )),
      body: isNull?
     body_guest() :
      Body(),
    );
  }
    void func() {
    User? user =  _auth.currentUser;
    if(user == null){
      isNull = true;
    }
    else{
      isNull = false;
    }
    
  }
}
