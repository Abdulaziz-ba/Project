
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../controller/cart_controller.dart';
import '../widgets/cart_products.dart';
import '../widgets/cart_total.dart';

class CartPage extends StatefulWidget {
  @override
  late String BrandName;
  CartPage({required this.BrandName});
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  _CartPageState();
  //final CartController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text('Shopping Cart', style: TextStyle(color: Colors.black)),
      ),
      body:
        CartProducts(),
    
      

           
      persistentFooterButtons: [
        CartTotal(),
        Column(
          children: [
            SizedBox(height: 10),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {
                print('CHECKOUT');
              },
              child: Text("CHECKOUT"),
            ),
            SizedBox(height: 10),
          ],
        ),
      ],
    );
  }
  
 
}
