import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  late Locale locale;

  static final box = GetStorage();

  @override // called when you use Get.put before running app
  void onInit() {
    super.onInit();
    _restoreLang();
  }

  void _restoreLang() {
    bool isArabic = box.read('isArabic') ?? true; // null check for first time running this
    if (isArabic) {
      locale = Locale('ar');
    } else {
      locale = Locale('en');
    }
  }

  void storeLangSetting(bool isArabic) {
    box.write('isArabic', isArabic);
  }
}