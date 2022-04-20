// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import '../widgets/cart_products.dart';

class CartController {
  var _products = {}.obs;
  static var id;
  static var Total = 0.obs;
  final _auth = FirebaseAuth.instance;

  //get products => _products;

  //get ProductSubtotal => _products.entries.map((product) => product.key.price * product.value).toList();

  get total {
    Total.value = 0;
    Total.value = CartProductsCard.total.toInt();
    return Total;
  }
}
