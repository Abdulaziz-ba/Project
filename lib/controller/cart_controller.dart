import 'dart:async';

import 'package:brandz/model/product_model.dart';
import 'package:brandz/widgets/cart_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
 import '../model/product_model.dart';
import 'package:collection/collection.dart';
import "package:brandz/model/user_model.dart";
class CartController{
  var _products = {}.obs;
  static var id;
  static var Total = 0.obs;
  final _auth = FirebaseAuth.instance;



  //get products => _products;

  //get ProductSubtotal => _products.entries.map((product) => product.key.price * product.value).toList();

  get total  {
  Total.value = 0;
  Total.value = CartProductsCard.total.toInt();
  return Total;

  }
}