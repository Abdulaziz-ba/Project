// Flutter imports:
import 'package:brandz/view/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../save_lang.dart';
import 'MyDetails.dart';
import 'MyOrders.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:brandz/locale/local_controller.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.find();
    return Column(
      children: [
        ProfilePic(),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            ProfileMenu(
              icon: 'assets/User Icon.svg',
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyDetails()),
                );
              },
              text: 'My Details',
            ),
          ],
        ),
        ProfileMenu(
          icon: 'assets/User Icon.svg',
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyOrders()),
            );
          },
          text: 'My Orders',
        ),
        ProfileMenu(
          icon: 'assets/User Icon.svg',
          press: () {
             bool isArabic =  SettingsController.box.read("isArabic") ?? true;
             print(isArabic);
             if(isArabic == true){
               controllerLang.changeLang('en');
               SettingsController.box.write("isArabic", false);
               Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainPage()));
             }
             else{
               controllerLang.changeLang('ar');
               SettingsController.box.write("isArabic", true);
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MainPage()));
             }

                        },
          text: 'Change Language',
        ),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);
  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.grey[200],
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              color: Colors.black,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
