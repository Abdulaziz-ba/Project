import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
class MyLocalController extends GetxController{


void changeLang(String codeLang){
  Locale locale = Locale(codeLang);
  Get.updateLocale(locale);
  
}

} 