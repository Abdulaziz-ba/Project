//import 'package:brandz/view/auth/login_screen.dart';
//import 'package:brandz/view/regScreen.dart';

// Flutter imports:
import 'package:brandz/locale/local_controller.dart';
import 'package:brandz/locale/locale.dart';
import 'package:brandz/locate_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
// Project imports:
import 'package:brandz/language_screen.dart';
import 'package:brandz/save_lang.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
  Future<void> main() async {
    
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(SettingsController());
  await Firebase.initializeApp();
  runApp(MyApp());
  
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    Get.put(MyLocalController());
    return GetMaterialApp(
      locale: controller.locale ,
      translations : MyLocal(),
      title: 'Email And Password Login',
      // color indicator when texting or writing input>> (PrimarySwatch)
      theme: ThemeData(primarySwatch: Colors.blue),
       home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

