// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_com1/view/auth/widgets/custom_text.dart';
import 'package:flutter_com1/view/auth/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          right: 20,
          left: 20,
        ),
        child: Column(
          children: [
            Row(
              children: const [
                Text(
                  "Brandz",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            CustomTextFormField(
              text: 'Email',
              hint: 'Email',
              onSave: (value) {},
              validator: (value) {},
            ),
            SizedBox(
              height: 40,
            ),
            CustomTextFormField(
              text: 'Email',
              hint: 'Password',
              onSave: (value) {},
              validator: (value) {},
            ),
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: 'forgot password?',
              fontSize: 15,
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
              text: "Don't have an account?",
              fontSize: 15,
              color: Colors.black,
              alignment: Alignment.center,
              // textAlign: TextAlign.center,
            ),
            FlatButton(
                onPressed: () {},
                color: Colors.black,
                child: CustomText(
                  text: 'Log in',
                )),
          ],
        ),
      ),
    );
  }
}
