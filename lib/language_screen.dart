import 'package:brandz/locale/local_controller.dart';
import 'package:brandz/main.dart';
import 'package:brandz/view/auth/login_screen.dart';
import 'package:brandz/view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:brandz/locate_screen.dart';
import 'package:brandz/main.dart';
import 'package:brandz/save_lang.dart';
class language_screen extends StatefulWidget {
  //RxBool savingState = false.obs;
  language_screen();

  @override
  State<language_screen> createState() => _language_screenState();
}

class _language_screenState extends State<language_screen> {
  int? val = 1 ;
  @override
  Widget build(BuildContext context) {
      MyLocalController controllerLang = Get.find();
      final CountinueButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.black,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: 10,
          onPressed: () async {
            if(val == 1){
              setState(() {
                controllerLang.changeLang('en'); 
                SettingsController.box.write("isArabic", false);
                             
              });
              

            }else{
              setState(() {
                controllerLang.changeLang('ar');
                SettingsController.box.write("isArabic", true);
              });
              

            }
            Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
            
          },
          child: Text(
            "Continue                                              ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200 , left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
                    child: Text('Hello,\nWelcome to \nBRANDZ' ,
                    style: GoogleFonts.inter(
                   fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
            ),
                    
                  ),
                  SizedBox(height: 100),
                  Text('Please choose your prefered \nlanguage :',
                   style: GoogleFonts.inter(
                   fontWeight: FontWeight.w300, fontSize: 21, color: Colors.black)),
                   SizedBox(height: 50),

                   Row(
                     children: [
                   Row(
                     children: [
                       Radio(
                          value: 1,
                          groupValue: val,
                         onChanged: (value) {
                           
                             setState(() {
                             val = value as int? ;
                             
                                        });
                                      },
                          activeColor: Colors.black,
                        ),
                        Text('English',
                   style: GoogleFonts.inter(
                   fontWeight: FontWeight.w300, fontSize: 21, color: Colors.black)),
                     ],
                   ),
                    
                    SizedBox(width:100),
                    Row(
                      children: [
                        Radio(
                          value: 2,
                          groupValue: val,
                         onChanged: (value) {
                             setState(() {
                             val = value as int? ;
                                        });
                                      },
                          activeColor: Colors.black,
                        ),
                        Text('العربية',
                   style: GoogleFonts.inter(
                   fontWeight: FontWeight.w300, fontSize: 21, color: Colors.black)),
                      ],
                    ),
                    

                  

                     ],
                  
                     
                   ),
                   SizedBox(height: 100),
                
              ],
            ),
            
            
          ),
          CountinueButton
        ],
      ),










    );
  }
}