//import '..constats.dart';
//import '../view/auth/widget/custom_button.dart';
//import 'package:brandz/view/auth/widget/custom_txt.dart';
//import 'package:brandz/view/auth/widget/custom_txt_from.dart';
//import 'package:brandz/view/home_screen.dart';
//import 'package:brandz/view/regScreen.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'login_screen.dart';

class ResetScreen extends StatelessWidget {
  @override
  final TextEditingController emailController = new TextEditingController();
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your Email");
        }
        //This is a Regex for the email Valdiation ==> (Valid Email or Not)
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please enter a valid Email!");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    final ResetButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            await FirebaseAuth.instance
                .sendPasswordResetEmail(email: emailController.text)
                .then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            });
          },
          child: Text(
            "Reset Password",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          title: Text(
            'Reset Password',
            style: GoogleFonts.adamina(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
          toolbarHeight: 35,
          centerTitle: true,
          titleSpacing: 0,
          backgroundColor: Colors.white, // leadingWidth: 0,
          elevation: 0,
          leading: BackButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              }),
          // leadingWidth: 3,)
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/logo_size.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    emailField,
                    SizedBox(
                      height: 20,
                    ),
                    ResetButton,
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
