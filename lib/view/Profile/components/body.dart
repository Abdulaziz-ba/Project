// Flutter imports:
import 'package:brandz/view/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        SizedBox(
          height: 20,
        ),
            Container(
              height: 80,
              child: Card(
                color: Color.fromARGB(179, 255, 255, 255),
                      shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10.0),
                      ),
                      shadowColor: Colors.white,
                      child: FlatButton(
                        onPressed: () {  
                                          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyDetails()),
                );
                          
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width:10),
                            Icon(Icons.badge_sharp
                            , size: 30,
                            ),
                            SizedBox(width: 30),
                               Text(
                                'My details',
                                style: GoogleFonts.adamina(
                                    fontSize: 17,),
                              ),
                              SizedBox(width: 170),
                                Icon(Icons.arrow_forward_ios
                            , size: 20,
                            color: Color.fromARGB(179, 113, 106, 106)
                            ),
                      
                      
                            
                          ],
                      
                        ),
                      ),
              ),
            ),
            
        

              Container(
              height: 80,
              child: Card(
                color: Color.fromARGB(179, 255, 255, 255),
                      shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10.0),
                      ),
                      shadowColor: Colors.white,
                      child: FlatButton(
                        onPressed: () {  
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyOrders()),
            );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width:10),
                            Icon(Icons.shopping_bag_outlined
                            , size: 30,
                            ),
                            SizedBox(width: 30),
                               Text(
                                'My orders',
                                style: GoogleFonts.adamina(
                                    fontSize: 17,),
                              ),
                              SizedBox(width: 170),
                                Icon(Icons.arrow_forward_ios
                            , size: 20,
                            color: Color.fromARGB(179, 113, 106, 106)
                            ),
                      
                      
                            
                          ],
                      
                        ),
                      ),
              ),
            ),

            
              Container(
              height: 80,
              child: Card(
                color: Color.fromARGB(179, 255, 255, 255),
                      shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10.0),
                      ),
                      shadowColor: Colors.white,
                      child: FlatButton(
                        onPressed: () {  
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width:10),
                            Icon(Icons.language
                            , size: 30,
                            ),
                            SizedBox(width: 30),
                               Text(
                                'Change Language',
                                style: GoogleFonts.adamina(
                                    fontSize: 17,),
                              ),
          
                      
                      
                            
                          ],
                      
                        ),
                      ),
              ),
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
