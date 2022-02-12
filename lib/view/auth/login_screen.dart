import 'package:flutter/material.dart';
import 'package:flutter_com1/view/auth/second_screen.dart';
import 'package:flutter_com1/view/auth/widgets/custom_button.dart';
import 'package:flutter_com1/view/auth/widgets/custom_text.dart';
import 'package:flutter_com1/view/auth/widgets/custom_txt_from.dart';
import 'package:flutter_com1/view/auth/widgets/primary_color.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation for the edges there is no edges 0.0
        elevation: 0.0, backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 20, left: 20),
        child: Column(
          children: [
            Row(
              children: [
                CustomText(
                  text: "BRANDZ",
                  fontSize: 85.0,
                  alignment: Alignment.topCenter,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Welcome,", fontSize: 30),
                CustomText(text: "Sign Up", fontSize: 18, color: primaryColor),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              text: "Sign in to continue",
              fontSize: 14,
              color: Colors.grey,
              alignment: Alignment.topLeft,
            ),
            SizedBox(
              height: 30,
            ),
            custom_txt_from(
                text: "Email",
                hint: "brandz@brandz.com",
                onSave: (Value) {},
                validato: (Value) {}),
            SizedBox(
              height: 15,
            ),
            custom_txt_from(
                text: "Password",
                hint: "********",
                onSave: (Value) {},
                validato: (Value) {}),
            SizedBox(
              height: 10,
            ),
            CustomText(
              text: "Forget Password",
              fontSize: 14.0,
              color: Colors.grey,
              alignment: Alignment.bottomRight,
            ),
            SizedBox(
              height: 15,
            ),
            // ignore: deprecated_member_use
            Custom_button(
                text: "Sign in",
                onPerssed: () {
                  Get.to(SecondScreen());
                }),
          ],
        ),
      ),
    );
  }
}
