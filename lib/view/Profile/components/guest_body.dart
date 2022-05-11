import 'package:brandz/view/auth/login_screen.dart';
import 'package:brandz/view/regScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../locale/local_controller.dart';
import '../../../save_lang.dart';
import '../../main_screen.dart';

class body_guest extends StatelessWidget {
  const body_guest({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyLocalController controllerLang = Get.find();

       final loginButton = Material(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromARGB(70, 0, 129, 172),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 100,
          onPressed: () {
                           Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));

          },
          child: Text(
            'SIGN IN                                  ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
           final signupButton = Material(
      borderRadius: BorderRadius.circular(15),
      color: Color.fromARGB(255, 171, 167, 167),
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 100,
          onPressed: () {
                           Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => reg_screen()));
          },
          child: Text(
            'SIGN UP                                  ',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 200),
           Text(
                    "Come on in",
                    style:
                        GoogleFonts.adamina(color: Colors.black, fontSize: 16 , fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "View orders and update your details",
                    style:
                        GoogleFonts.adamina(color: Colors.black, fontSize: 16 ),
                  ),
                  SizedBox(height:15),
                  loginButton ,
                  SizedBox(height: 20),
                  signupButton,
                  SizedBox(height: 199),
                  Card(
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



          ],
        )),
      
    );
  }
}