import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../model/product_model.dart';
import 'package:collection/collection.dart';

class CartController extends GetxController {
  var _products = {}.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      // increase quantity if product exists
      _products[product] = 1;
    }
    print("product added!");
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product)) {
      _products.removeWhere((key, value) => key == product);
      Get.reloadAll();
    }
    print("product removed!");
  }

  void decreaseQuantity(Product product) {
    if (_products.containsKey(product) && _products[product] > 1) {
      _products[product] -= 1;
    }
    print("Quantity decreased!");
  }

  get products => _products;

  //get ProductSubtotal => _products.entries.map((product) => product.key.price * product.value).toList();

  get total {
    if (_products.length > 0)
      return _products.entries
          .map((product) => product.key.price * product.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);
    print('Cart is empty!!!');
    return 0;
  }
}