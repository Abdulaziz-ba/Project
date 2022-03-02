import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.find();

  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("TOTAL"),
          Text('${controller.total} SAR'),
        ],
      ),
    );
  }
}
