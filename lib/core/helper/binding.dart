// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:brandz/core/view_model/auth.dart';

class Binding extends Bindings {
  void dependencies() {
    Get.lazyPut(() => Auth());
  }
}
