// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../controller/cart_controller.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.find();

  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "TOTAL",
              style: GoogleFonts.adamina(
                  //fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black),
            ),
            Text(
              '${controller.total} SAR',
              style: GoogleFonts.adamina(
                  //fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
