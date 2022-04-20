// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../widgets/cart_products.dart';
import '../widgets/cart_total.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  @override
  late String BrandName;
  CartPage({required this.BrandName});
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _CartPageState();
  //final CartController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white10,
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.adamina(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
      ),
      body: CartProducts(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Checkout()),
                );
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
