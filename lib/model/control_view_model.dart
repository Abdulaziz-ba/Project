import 'package:get/get.dart';

import 'package:get/get.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;
  // ignore: recursive_getters
  get navigatorValue => _navigatorValue;

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    update();
  }
}
