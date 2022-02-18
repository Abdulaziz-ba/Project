import 'package:flutter_com1/core/view_model/auth.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  void dependencies() {
    Get.lazyPut(() => Auth());
  }
}
