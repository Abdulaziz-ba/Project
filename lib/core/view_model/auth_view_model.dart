import 'package:get/get.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  var counter = 0.obs;
  void onInit() {
    super.onInit();
  }

  void onReady() {
    super.onReady();
  }

  void onClose() {
    super.onClose();
  }

  void increment() {
    counter++;
    update();
  }
}
